From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: git-t4034-diff-words.sh.prb
Date: Sat, 7 Mar 2009 14:47:31 -0700
Message-ID: <alpine.LNX.2.00.0903071446030.2164@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:49:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg4OF-0000mZ-UZ
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbZCGVrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 16:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbZCGVrf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:47:35 -0500
Received: from suse104.zenez.com ([198.60.105.164]:40435 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbZCGVrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:47:33 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 93B4E6C08B2; Sat,  7 Mar 2009 14:47:31 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 81258938188
	for <git@vger.kernel.org>; Sat,  7 Mar 2009 14:47:31 -0700 (MST)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112589>

Here are the test failures using set -x for git-t4032-diff-words.sh

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047

$ bash ./t4034-diff-words.sh
+ test_description='word diff colors'
+ . ./test-lib.sh
++ ORIGINAL_TERM=xterm
++ LANG=C
++ LC_ALL=C
++ PAGER=cat
++ TZ=UTC
++ TERM=dumb
++ export LANG LC_ALL PAGER TERM TZ
++ EDITOR=:
++ VISUAL=:
++ unset GIT_EDITOR
++ unset AUTHOR_DATE
++ unset AUTHOR_EMAIL
++ unset AUTHOR_NAME
++ unset COMMIT_AUTHOR_EMAIL
++ unset COMMIT_AUTHOR_NAME
++ unset EMAIL
++ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
++ unset GIT_AUTHOR_DATE
++ GIT_AUTHOR_EMAIL=author@example.com
++ GIT_AUTHOR_NAME='A U Thor'
++ unset GIT_COMMITTER_DATE
++ GIT_COMMITTER_EMAIL=committer@example.com
++ GIT_COMMITTER_NAME='C O Mitter'
++ unset GIT_DIFF_OPTS
++ unset GIT_DIR
++ unset GIT_WORK_TREE
++ unset GIT_EXTERNAL_DIFF
++ unset GIT_INDEX_FILE
++ unset GIT_OBJECT_DIRECTORY
++ unset GIT_CEILING_DIRECTORIES
++ unset SHA1_FILE_DIRECTORIES
++ unset SHA1_FILE_DIRECTORY
++ GIT_MERGE_VERBOSITY=5
++ export GIT_MERGE_VERBOSITY
++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
++ export EDITOR VISUAL
++ GIT_TEST_CMP='diff -u'
++ unset CDPATH
++ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+++ echo
+++ tr '[A-Z]' '[a-z]'
++ '[' xxterm '!=' xdumb ']'
++ TERM=xterm
++ export TERM
++ '[' -t 1 ']'
++ tput bold
++ tput setaf 1
++ test 0 -ne 0
++ test -n ''
++ test 'word diff colors' '!=' ''
++ test '' = t
++ exec
++ test '' = t
++ exec
++ test_failure=0
++ test_count=0
++ test_fixed=0
++ test_broken=0
++ test_success=0
++ trap die EXIT
+++ pwd
++ TEST_DIRECTORY=/tmp/git-1.6.2/t
++ PATH=/tmp/git-1.6.2/t/..:/usr/local/bin:/usr/gnu/bin:/home/gerberb/bin:/usr/bin:/bin:/sbin:/usr/sbin:/etc:/usr/X11R6/bin
+++ pwd
++ GIT_EXEC_PATH=/tmp/git-1.6.2/t/..
+++ pwd
++ GIT_TEMPLATE_DIR=/tmp/git-1.6.2/t/../templates/blt
++ unset GIT_CONFIG
++ GIT_CONFIG_NOSYSTEM=1
++ GIT_CONFIG_NOGLOBAL=1
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
+++ pwd
+++ pwd
++ GITPERLLIB=/tmp/git-1.6.2/t/../perl/blib/lib:/tmp/git-1.6.2/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d ../templates/blt
++ test -x ../test-chmtime
++ . ../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/usr/bin/bash
+++ TAR=gtar
+++ basename ./t4034-diff-words.sh .sh
++ test='trash directory.t4034-diff-words'
++ test '!' -z ''
++ remove_trash='/tmp/git-1.6.2/t/trash directory.t4034-diff-words'
++ rm -fr 'trash directory.t4034-diff-words'
++ test_create_repo 'trash directory.t4034-diff-words'
++ test 1 = 1
+++ pwd
++ owd=/tmp/git-1.6.2/t
++ repo='trash directory.t4034-diff-words'
++ mkdir -p 'trash directory.t4034-diff-words'
++ cd 'trash directory.t4034-diff-words'
++ /tmp/git-1.6.2/t/../git init --template=/tmp/git-1.6.2/t/../templates/blt/
++ mv .git/hooks .git/hooks-disabled
++ cd /tmp/git-1.6.2/t
++ cd -P 'trash directory.t4034-diff-words'
+++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
++ this_test=t4034
+ test_expect_success setup '

         git config diff.color.old red
         git config diff.color.new green

'
+ test 2 = 2
+ test_skip setup '

         git config diff.color.old red
         git config diff.color.new green

'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 0 + 1
+ this_test=t4034.1
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         git config diff.color.old red
         git config diff.color.new green

'
+ say_color info 'expecting success:

         git config diff.color.old red
         git config diff.color.new green

'
+ test -z info
+ shift
+ echo '* expecting success:

         git config diff.color.old red
         git config diff.color.new green

'
+ test_run_ '

         git config diff.color.old red
         git config diff.color.new green

'
+ eval '

         git config diff.color.old red
         git config diff.color.new green

'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ setup
++ expr 0 + 1
+ test_count=1
++ expr 0 + 1
+ test_success=1
+ say_color '' '  ok 1: setup'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 1: setup'
*   ok 1: setup
+ echo ''
+ cat
+ cat
+ cat
+ test_expect_success 'word diff with runs of whitespace' '

         word_diff --color-words

'
+ test 2 = 2
+ test_skip 'word diff with runs of whitespace' '

         word_diff --color-words

'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 1 + 1
+ this_test=t4034.2
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         word_diff --color-words

'
+ say_color info 'expecting success:

         word_diff --color-words

'
+ test -z info
+ shift
+ echo '* expecting success:

         word_diff --color-words

'
+ test_run_ '

         word_diff --color-words

'
+ eval '

         word_diff --color-words

'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'word diff with runs of whitespace'
++ expr 1 + 1
+ test_count=2
++ expr 1 + 1
+ test_success=2
+ say_color '' '  ok 2: word diff with runs of whitespace'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 2: word diff with runs of whitespace'
*   ok 2: word diff with runs of whitespace
+ echo ''
+ cat
+ cp expect expect.letter-runs-are-words
+ test_expect_success 'word diff with a regular expression' '

         word_diff --color-words="[a-z]+"

'
+ test 2 = 2
+ test_skip 'word diff with a regular expression' '

         word_diff --color-words="[a-z]+"

'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 2 + 1
+ this_test=t4034.3
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         word_diff --color-words="[a-z]+"

'
+ say_color info 'expecting success:

         word_diff --color-words="[a-z]+"

'
+ test -z info
+ shift
+ echo '* expecting success:

         word_diff --color-words="[a-z]+"

'
+ test_run_ '

         word_diff --color-words="[a-z]+"

'
+ eval '

         word_diff --color-words="[a-z]+"

'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'word diff with a regular expression'
++ expr 2 + 1
+ test_count=3
++ expr 2 + 1
+ test_success=3
+ say_color '' '  ok 3: word diff with a regular expression'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 3: word diff with a regular expression'
*   ok 3: word diff with a regular expression
+ echo ''
+ test_expect_success 'set a diff driver' '
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
+ test 2 = 2
+ test_skip 'set a diff driver' '
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 3 + 1
+ this_test=t4034.4
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
+ say_color info 'expecting success:
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
+ test -z info
+ shift
+ echo '* expecting success:
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
+ test_run_ '
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
+ eval '
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF
'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'set a diff driver'
++ expr 3 + 1
+ test_count=4
++ expr 3 + 1
+ test_success=4
+ say_color '' '  ok 4: set a diff driver'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 4: set a diff driver'
*   ok 4: set a diff driver
+ echo ''
+ test_expect_success 'option overrides .gitattributes' '

         word_diff --color-words="[a-z]+"

'
+ test 2 = 2
+ test_skip 'option overrides .gitattributes' '

         word_diff --color-words="[a-z]+"

'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 4 + 1
+ this_test=t4034.5
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         word_diff --color-words="[a-z]+"

'
+ say_color info 'expecting success:

         word_diff --color-words="[a-z]+"

'
+ test -z info
+ shift
+ echo '* expecting success:

         word_diff --color-words="[a-z]+"

'
+ test_run_ '

         word_diff --color-words="[a-z]+"

'
+ eval '

         word_diff --color-words="[a-z]+"

'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'option overrides .gitattributes'
++ expr 4 + 1
+ test_count=5
++ expr 4 + 1
+ test_success=5
+ say_color '' '  ok 5: option overrides .gitattributes'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 5: option overrides .gitattributes'
*   ok 5: option overrides .gitattributes
+ echo ''
+ cat
+ cp expect expect.non-whitespace-is-word
+ test_expect_success 'use regex supplied by driver' '

         word_diff --color-words

'
+ test 2 = 2
+ test_skip 'use regex supplied by driver' '

         word_diff --color-words

'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 5 + 1
+ this_test=t4034.6
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         word_diff --color-words

'
+ say_color info 'expecting success:

         word_diff --color-words

'
+ test -z info
+ shift
+ echo '* expecting success:

         word_diff --color-words

'
+ test_run_ '

         word_diff --color-words

'
+ eval '

         word_diff --color-words

'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ 'use regex supplied by driver' '

         word_diff --color-words

'
++ expr 5 + 1
+ test_count=6
++ expr 0 + 1
+ test_failure=1
+ say_color error 'FAIL 6: use regex supplied by driver'
+ test -z error
+ shift
+ echo '* FAIL 6: use regex supplied by driver'
* FAIL 6: use regex supplied by driver
+ shift
+ echo '

         word_diff --color-words

'
+ sed -e 's/^/  /'


                 word_diff --color-words


+ test '' = ''
+ echo ''
+ test_expect_success 'set diff.wordRegex option' '
         git config diff.wordRegex "[[:alnum:]]+"
'
+ test 2 = 2
+ test_skip 'set diff.wordRegex option' '
         git config diff.wordRegex "[[:alnum:]]+"
'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 6 + 1
+ this_test=t4034.7
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         git config diff.wordRegex "[[:alnum:]]+"
'
+ say_color info 'expecting success:
         git config diff.wordRegex "[[:alnum:]]+"
'
+ test -z info
+ shift
+ echo '* expecting success:
         git config diff.wordRegex "[[:alnum:]]+"
'
+ test_run_ '
         git config diff.wordRegex "[[:alnum:]]+"
'
+ eval '
         git config diff.wordRegex "[[:alnum:]]+"
'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'set diff.wordRegex option'
++ expr 6 + 1
+ test_count=7
++ expr 5 + 1
+ test_success=6
+ say_color '' '  ok 7: set diff.wordRegex option'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 7: set diff.wordRegex option'
*   ok 7: set diff.wordRegex option
+ echo ''
+ cp expect.letter-runs-are-words expect
+ test_expect_success 'command-line overrides config' '
         word_diff --color-words="[a-z]+"
'
+ test 2 = 2
+ test_skip 'command-line overrides config' '
         word_diff --color-words="[a-z]+"
'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 7 + 1
+ this_test=t4034.8
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         word_diff --color-words="[a-z]+"
'
+ say_color info 'expecting success:
         word_diff --color-words="[a-z]+"
'
+ test -z info
+ shift
+ echo '* expecting success:
         word_diff --color-words="[a-z]+"
'
+ test_run_ '
         word_diff --color-words="[a-z]+"
'
+ eval '
         word_diff --color-words="[a-z]+"
'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'command-line overrides config'
++ expr 7 + 1
+ test_count=8
++ expr 6 + 1
+ test_success=7
+ say_color '' '  ok 8: command-line overrides config'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 8: command-line overrides config'
*   ok 8: command-line overrides config
+ echo ''
+ cp expect.non-whitespace-is-word expect
+ test_expect_success '.gitattributes override config' '
         word_diff --color-words
'
+ test 2 = 2
+ test_skip '.gitattributes override config' '
         word_diff --color-words
'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 8 + 1
+ this_test=t4034.9
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         word_diff --color-words
'
+ say_color info 'expecting success:
         word_diff --color-words
'
+ test -z info
+ shift
+ echo '* expecting success:
         word_diff --color-words
'
+ test_run_ '
         word_diff --color-words
'
+ eval '
         word_diff --color-words
'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ '.gitattributes override config' '
         word_diff --color-words
'
++ expr 8 + 1
+ test_count=9
++ expr 1 + 1
+ test_failure=2
+ say_color error 'FAIL 9: .gitattributes override config'
+ test -z error
+ shift
+ echo '* FAIL 9: .gitattributes override config'
* FAIL 9: .gitattributes override config
+ shift
+ echo '
         word_diff --color-words
'
+ sed -e 's/^/  /'

                 word_diff --color-words

+ test '' = ''
+ echo ''
+ test_expect_success 'remove diff driver regex' '
         git config --unset diff.testdriver.wordRegex
'
+ test 2 = 2
+ test_skip 'remove diff driver regex' '
         git config --unset diff.testdriver.wordRegex
'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 9 + 1
+ this_test=t4034.10
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         git config --unset diff.testdriver.wordRegex
'
+ say_color info 'expecting success:
         git config --unset diff.testdriver.wordRegex
'
+ test -z info
+ shift
+ echo '* expecting success:
         git config --unset diff.testdriver.wordRegex
'
+ test_run_ '
         git config --unset diff.testdriver.wordRegex
'
+ eval '
         git config --unset diff.testdriver.wordRegex
'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'remove diff driver regex'
++ expr 9 + 1
+ test_count=10
++ expr 7 + 1
+ test_success=8
+ say_color '' '  ok 10: remove diff driver regex'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 10: remove diff driver regex'
*   ok 10: remove diff driver regex
+ echo ''
+ cat
+ test_expect_success 'use configured regex' '
         word_diff --color-words
'
+ test 2 = 2
+ test_skip 'use configured regex' '
         word_diff --color-words
'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 10 + 1
+ this_test=t4034.11
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:
         word_diff --color-words
'
+ say_color info 'expecting success:
         word_diff --color-words
'
+ test -z info
+ shift
+ echo '* expecting success:
         word_diff --color-words
'
+ test_run_ '
         word_diff --color-words
'
+ eval '
         word_diff --color-words
'
+ eval_ret=0
+ return 0
+ '[' 0 = 0 -a 0 = 0 ']'
+ test_ok_ 'use configured regex'
++ expr 10 + 1
+ test_count=11
++ expr 8 + 1
+ test_success=9
+ say_color '' '  ok 11: use configured regex'
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 11: use configured regex'
*   ok 11: use configured regex
+ echo ''
+ echo 'aaa (aaa)'
+ echo 'aaa (aaa) aaa'
+ cat
+ test_expect_success 'test parsing words for newline' '

         word_diff --color-words="a+"


'
+ test 2 = 2
+ test_skip 'test parsing words for newline' '

         word_diff --color-words="a+"


'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 11 + 1
+ this_test=t4034.12
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         word_diff --color-words="a+"


'
+ say_color info 'expecting success:

         word_diff --color-words="a+"


'
+ test -z info
+ shift
+ echo '* expecting success:

         word_diff --color-words="a+"


'
+ test_run_ '

         word_diff --color-words="a+"


'
+ eval '

         word_diff --color-words="a+"


'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ 'test parsing words for newline' '

         word_diff --color-words="a+"


'
++ expr 11 + 1
+ test_count=12
++ expr 2 + 1
+ test_failure=3
+ say_color error 'FAIL 12: test parsing words for newline'
+ test -z error
+ shift
+ echo '* FAIL 12: test parsing words for newline'
* FAIL 12: test parsing words for newline
+ shift
+ echo '

         word_diff --color-words="a+"


'
+ sed -e 's/^/  /'


                 word_diff --color-words="a+"



+ test '' = ''
+ echo ''
+ echo '(:'
+ echo '('
+ cat
+ test_expect_success 'test when words are only removed at the end' '

         word_diff --color-words=.

'
+ test 2 = 2
+ test_skip 'test when words are only removed at the end' '

         word_diff --color-words=.

'
++ expr ././t4034-diff-words.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t4034
++ expr 12 + 1
+ this_test=t4034.13
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success:

         word_diff --color-words=.

'
+ say_color info 'expecting success:

         word_diff --color-words=.

'
+ test -z info
+ shift
+ echo '* expecting success:

         word_diff --color-words=.

'
+ test_run_ '

         word_diff --color-words=.

'
+ eval '

         word_diff --color-words=.

'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ 'test when words are only removed at the end' '

         word_diff --color-words=.

'
++ expr 12 + 1
+ test_count=13
++ expr 3 + 1
+ test_failure=4
+ say_color error 'FAIL 13: test when words are only removed at the end'
+ test -z error
+ shift
+ echo '* FAIL 13: test when words are only removed at the end'
* FAIL 13: test when words are only removed at the end
+ shift
+ echo '

         word_diff --color-words=.

'+ sed -e 's/^/ /'



                 word_diff --color-words=.


+ test '' = ''
+ echo ''
+ test_done
+ trap - EXIT
+ test_results_dir=/tmp/git-1.6.2/t/test-results
+ mkdir -p /tmp/git-1.6.2/t/test-results
+ test_results_path=/tmp/git-1.6.2/t/test-results/./t4034-diff-21979
+ echo 'total 13'
+ echo 'success 9'
+ echo 'fixed 0'
+ echo 'broken 0'
+ echo 'failed 4'
+ echo ''
+ test 0 '!=' 0
+ test 0 '!=' 0
+ msg='13 test(s)'
+ case "$test_failure" in
+ say_color error 'failed 4 among 13 test(s)'
+ test -z error
+ shift
+ echo '* failed 4 among 13 test(s)'
* failed 4 among 13 test(s)
+ exit 1
