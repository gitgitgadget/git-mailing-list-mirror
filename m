From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: t9500-gitweb-standalone-no-errors.sh.prb 4 errors
Date: Sat, 7 Mar 2009 17:11:47 -0700
Message-ID: <alpine.LNX.2.00.0903071645370.20607@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 01:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg6e1-0003xR-1R
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 01:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbZCHALv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 19:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZCHALu
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 19:11:50 -0500
Received: from suse104.zenez.com ([198.60.105.164]:50522 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbZCHALt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 19:11:49 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 5ADAA6C08B2; Sat,  7 Mar 2009 17:11:47 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 47EF0938188
	for <git@vger.kernel.org>; Sat,  7 Mar 2009 17:11:47 -0700 (MST)
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112598>

Test fails for SCO OpenServer 6.0 MP4 with 1.6.2

Below is the set -x output of the tests.

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047


+ test_description='gitweb as standalone script (basic tests).

This test runs gitweb (git web interface) as CGI script from
commandline, and checks that it would not write any errors
or warnings to log.'
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
++ test 0 -ne 0
++ test -n ''
++ test 'gitweb as standalone script (basic tests).

This test runs gitweb (git web interface) as CGI script from
commandline, and checks that it would not write any errors
or warnings to log.' '!=' ''
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
++ 
PATH=/tmp/git-1.6.2/t/..:/usr/local/bin:/usr/gnu/bin:/home/gerberb/bin:/usr/bin:/bin:/sbin:/usr/sbin:/etc:/usr/X11R6/bin
+++ pwd
++ GIT_EXEC_PATH=/tmp/git-1.6.2/t/..
+++ pwd
++ GIT_TEMPLATE_DIR=/tmp/git-1.6.2/t/../templates/blt
++ unset GIT_CONFIG
++ GIT_CONFIG_NOSYSTEM=1
++ GIT_CONFIG_NOGLOBAL=1
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM 
GIT_CONFIG_NOGLOBAL
+++ pwd
+++ pwd
++ 
GITPERLLIB=/tmp/git-1.6.2/t/../perl/blib/lib:/tmp/git-1.6.2/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d ../templates/blt
++ test -x ../test-chmtime
++ . ../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/usr/bin/bash
+++ TAR=gtar
+++ basename ./t9500-gitweb-standalone-no-errors.sh .sh
++ test='trash directory.t9500-gitweb-standalone-no-errors'
++ test '!' -z ''
++ remove_trash='/tmp/git-1.6.2/t/trash 
directory.t9500-gitweb-standalone-no-errors'
++ rm -fr 'trash directory.t9500-gitweb-standalone-no-errors'
++ test_create_repo 'trash directory.t9500-gitweb-standalone-no-errors'
++ test 1 = 1
+++ pwd
++ owd=/tmp/git-1.6.2/t
++ repo='trash directory.t9500-gitweb-standalone-no-errors'
++ mkdir -p 'trash directory.t9500-gitweb-standalone-no-errors'
++ cd 'trash directory.t9500-gitweb-standalone-no-errors'
++ /tmp/git-1.6.2/t/../git init --template=/tmp/git-1.6.2/t/../templates/blt/
++ mv .git/hooks .git/hooks-disabled
++ cd /tmp/git-1.6.2/t
++ cd -P 'trash directory.t9500-gitweb-standalone-no-errors'
+++ expr ././t9500-gitweb-standalone-no-errors.sh : '.*/\(t[0-9]*\)-[^/]*$'
++ this_test=t9500
+ perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)'
+ gitweb_init
++ perl -MPOSIX=getcwd -e 'print quotemeta(getcwd)'
+ safe_pwd='\/tmp\/git\-1\.6\.2\/t\/trash\ 
directory\.t9500\-gitweb\-standalone\-no\-errors'
+ cat
+ cat
+ test_expect_success 'no commits: projects_list (implicit)' gitweb_run
+ test 2 = 2
+ test_skip 'no commits: projects_list (implicit)' gitweb_run
++ expr ././t9500-gitweb-standalone-no-errors.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t9500
...
+ echo ''
+ test_debug 'cat gitweb.log'
+ test '' = ''
+ test_expect_success '.git blob (file)' 'gitweb_run "p=.git;a=blob;f=file"'
+ test 2 = 2
+ test_skip '.git blob (file)' 'gitweb_run "p=.git;a=blob;f=file"'
++ expr ././t9500-gitweb-standalone-no-errors.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t9500
++ expr 17 + 1
+ this_test=t9500.18
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: gitweb_run "p=.git;a=blob;f=file"'
+ say_color info 'expecting success: gitweb_run "p=.git;a=blob;f=file"'
+ test -z info
+ shift
+ echo '* expecting success: gitweb_run "p=.git;a=blob;f=file"'
+ test_run_ 'gitweb_run "p=.git;a=blob;f=file"'
+ eval 'gitweb_run "p=.git;a=blob;f=file"'
+ eval_ret=255
+ return 0
+ '[' 0 = 0 -a 255 = 0 ']'
+ test_failure_ '.git blob (file)' 'gitweb_run "p=.git;a=blob;f=file"'
++ expr 17 + 1
+ test_count=18
++ expr 0 + 1
+ test_failure=1
+ say_color error 'FAIL 18: .git blob (file)'
+ test -z error
+ shift
+ echo '* FAIL 18: .git blob (file)'
* FAIL 18: .git blob (file)
+ shift
+ echo 'gitweb_run "p=.git;a=blob;f=file"'
+ sed -e 's/^/	/'
      	gitweb_run "p=.git;a=blob;f=file"
+ test '' = ''
+ echo ''
+ test_debug 'cat gitweb.log'
+ test '' = ''
+ test_expect_success '.git blob_plain (file)' 'gitweb_run 
"p=.git;a=blob_plain;f=file"'
+ test 2 = 2
+ test_skip '.git blob_plain (file)' 'gitweb_run "p=.git;a=blob_plain;f=file"'
++ expr ././t9500-gitweb-standalone-no-errors.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t9500
++ expr 18 + 1
+ this_test=t9500.19
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: gitweb_run "p=.git;a=blob_plain;f=file"'
+ say_color info 'expecting success: gitweb_run "p=.git;a=blob_plain;f=file"'
+ test -z info
+ shift
+ echo '* expecting success: gitweb_run "p=.git;a=blob_plain;f=file"'
+ test_run_ 'gitweb_run "p=.git;a=blob_plain;f=file"'
+ eval 'gitweb_run "p=.git;a=blob_plain;f=file"'
+ eval_ret=255
+ return 0
+ '[' 0 = 0 -a 255 = 0 ']'
+ test_failure_ '.git blob_plain (file)' 'gitweb_run 
"p=.git;a=blob_plain;f=file"'
++ expr 18 + 1
+ test_count=19
++ expr 1 + 1
+ test_failure=2
+ say_color error 'FAIL 19: .git blob_plain (file)'
+ test -z error
+ shift
+ echo '* FAIL 19: .git blob_plain (file)'
* FAIL 19: .git blob_plain (file)
+ shift
+ echo 'gitweb_run "p=.git;a=blob_plain;f=file"'
+ sed -e 's/^/	/'
      	gitweb_run "p=.git;a=blob_plain;f=file"
...
+ echo ''
+ test_debug 'cat gitweb.log'
+ test '' = ''
+ test_expect_success 'path_info: project/branch:file' 'gitweb_run "" 
"/.git/master:file"'
+ test 2 = 2
+ test_skip 'path_info: project/branch:file' 'gitweb_run "" 
"/.git/master:file"'
++ expr ././t9500-gitweb-standalone-no-errors.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t9500
++ expr 61 + 1
+ this_test=t9500.62
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: gitweb_run "" "/.git/master:file"'
+ say_color info 'expecting success: gitweb_run "" "/.git/master:file"'
+ test -z info
+ shift
+ echo '* expecting success: gitweb_run "" "/.git/master:file"'
+ test_run_ 'gitweb_run "" "/.git/master:file"'
+ eval 'gitweb_run "" "/.git/master:file"'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ 'path_info: project/branch:file' 'gitweb_run "" 
"/.git/master:file"'
++ expr 61 + 1
+ test_count=62
++ expr 2 + 1
+ test_failure=3
+ say_color error 'FAIL 62: path_info: project/branch:file'
+ test -z error
+ shift
+ echo '* FAIL 62: path_info: project/branch:file'
* FAIL 62: path_info: project/branch:file
+ shift
+ echo 'gitweb_run "" "/.git/master:file"'
+ sed -e 's/^/	/'
      	gitweb_run "" "/.git/master:file"
...
+ test -z ''
+ test -n ''
+ shift
+ echo '*   ok 65: path_info: project/branch:dir/ (non-existent)'
*   ok 65: path_info: project/branch:dir/ (non-existent)
+ echo ''
+ test_debug 'cat gitweb.log'
+ test '' = ''
+ test_expect_success 'path_info: project/branch:/file' 'gitweb_run "" 
"/.git/master:/file"'
+ test 2 = 2
+ test_skip 'path_info: project/branch:/file' 'gitweb_run "" 
"/.git/master:/file"'
++ expr ././t9500-gitweb-standalone-no-errors.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t9500
++ expr 65 + 1
+ this_test=t9500.66
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: gitweb_run "" "/.git/master:/file"'
+ say_color info 'expecting success: gitweb_run "" "/.git/master:/file"'
+ test -z info
+ shift
+ echo '* expecting success: gitweb_run "" "/.git/master:/file"'
+ test_run_ 'gitweb_run "" "/.git/master:/file"'
+ eval 'gitweb_run "" "/.git/master:/file"'
+ eval_ret=2
+ return 0
+ '[' 0 = 0 -a 2 = 0 ']'
+ test_failure_ 'path_info: project/branch:/file' 'gitweb_run "" 
"/.git/master:/file"'
++ expr 65 + 1
+ test_count=66
++ expr 3 + 1
+ test_failure=4
+ say_color error 'FAIL 66: path_info: project/branch:/file'
+ test -z error
+ shift
+ echo '* FAIL 66: path_info: project/branch:/file'
* FAIL 66: path_info: project/branch:/file
+ shift
+ echo 'gitweb_run "" "/.git/master:/file"'
+ sed -e 's/^/	/'
      	gitweb_run "" "/.git/master:/file"
...
+ echo ''
+ test_debug 'cat gitweb.log'
+ test '' = ''
+ test_done
+ trap - EXIT
+ test_results_dir=/tmp/git-1.6.2/t/test-results
+ mkdir -p /tmp/git-1.6.2/t/test-results
+ 
test_results_path=/tmp/git-1.6.2/t/test-results/./t9500-gitweb-standalone-no-1287
+ echo 'total 87'
+ echo 'success 83'
+ echo 'fixed 0'
+ echo 'broken 0'
+ echo 'failed 4'
+ echo ''
+ test 0 '!=' 0
+ test 0 '!=' 0
+ msg='87 test(s)'
+ case "$test_failure" in
+ say_color error 'failed 4 among 87 test(s)'
+ test -z error
+ shift
+ echo '* failed 4 among 87 test(s)'
* failed 4 among 87 test(s)
+ exit 1
