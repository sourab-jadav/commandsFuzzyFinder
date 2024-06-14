#!/bin/bash

# Path to the commands file
COMMANDS_FILE=~/bin/commands.txt
# Check if the commands file exists
if [[ ! -f $COMMANDS_FILE ]]; then
    echo "Commands file not found!"
    exit 1
fi

# Use fzf to fuzzy find a command from the file
SELECTED_LINE=$(cat $COMMANDS_FILE | fzf)

# If a line was selected, extract the command
if [[ -n "$SELECTED_LINE" ]]; then
    # Extract the command using one or more spaces as the delimiter
    COMMAND=$(echo "$SELECTED_LINE" | awk -F' + ' '{print $1}')
    if echo "$SELECTED_LINE" | grep -q "exec"; then
        echo "Executing: $COMMAND"
        eval "$COMMAND"
    else
        echo "Copying the command to clipboard."
        echo "$COMMAND" | xclip -selection clipboard
    fi
fi

