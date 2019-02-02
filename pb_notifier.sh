#!/bin/bash

ACCESS_TOKEN="<Pushbullet access token goes here>"
EMAIL=$1
TITLE=$2
BODY=$3

# help/usage information
function usage {
    echo "Usage: pb_notifier.sh <EMAIL> <TITLE> <BODY>"
    echo ""
    echo "  -h                  Display usage."
    echo ""
}

# get user input
while getopts ":h:" option
do
  case $option in
    h)
      usage
      exit 1
      ;;
    ?)
      usage
      exit 1
      ;;
  esac
done

curl --header 'Access-Token: '"${ACCESS_TOKEN}"'' \
	--header 'Content-Type: application/json' \
	--data-binary '{"body":"'"${BODY}"'","email":"'"${EMAIL}"'","title":"'"${TITLE}"'","type":"note"}' \
	--request POST \
	https://api.pushbullet.com/v2/pushes > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Pushbullet notification failed. Here is what it would have said: ${BODY}"
fi
