#!/bin/sh
LOCAL_MODULE=test
LOCAL_MAKEFILE_AM=Makefile.am
LOCAL_CONFIGURE_AC=configure.ac
LOCAL_SRC_FILES=hello.c

set -e

if [ ! -f "$LOCAL_MAKEFILE_AM" ]; then
echo "creat $LOCAL_MAKEFILE_AM"
echo "AUTOMAKE_OPTIONS= foreign" > $LOCAL_MAKEFILE_AM
echo "bin_PROGRAMS=$LOCAL_MODULE" >> $LOCAL_MAKEFILE_AM
echo "${LOCAL_MODULE}_SOURCES=$LOCAL_SRC_FILES" >> $LOCAL_MAKEFILE_AM
fi

if [ ! -f "$LOCAL_CONFIGURE_AC" ]; then
echo "creat $LOCAL_CONFIGURE_AC"
autoscan
sed "/AC_CONFIG_HEADERS/a\AM_INIT_AUTOMAKE($LOCAL_MODULE,1.0)" configure.scan > configure.ac
fi

aclocal
autoheader
autoreconf -ivf

libtoolize --version
libtoolize --automake --copy --debug --force

automake --add-missing
automake

./configure

