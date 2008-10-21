From: Fergus McMenemie <fergus@twig.me.uk>
Subject: git 1.6.0.2 make test fails at t1301 under mac os x 10.4.
Date: Tue, 21 Oct 2008 19:32:32 +0100
Message-ID: <p06240800c523ac94cb4d@[192.168.47.9]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:15:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsMhg-0004ED-3r
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbYJUTOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYJUTOa
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:14:30 -0400
Received: from a.painless.aaisp.net.uk ([81.187.30.51]:60421 "EHLO
	a.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYJUTO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:14:29 -0400
X-Greylist: delayed 2512 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Oct 2008 15:14:28 EDT
Received: from 110.88.155.90.in-addr.arpa ([90.155.88.110] helo=twig.me.uk)
	by a.painless.aaisp.net.uk with smtp (Exim 4.69)
	(envelope-from <fergus@twig.me.uk>)
	id 1KsM1x-0005rz-Tm
	for git@vger.kernel.org; Tue, 21 Oct 2008 19:32:34 +0100
Received: from [192.168.47.9] (bigmac24.twig.me.uk [192.168.47.9])
	by twig.me.uk (Postfix) with ESMTP id 1724B308CE0
	for <git@vger.kernel.org>; Tue, 21 Oct 2008 19:32:33 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98807>

Hi,

Hoping for a quick pointer. I compiled git 1.6.0.2 on three
macs. Works fine on two fails on one. It only fails at test
t1301-shared-repo.sh all other tests pass.

Imac 2.16GHz Intel Core 2 Duo running MacOS X 10.4.11 - OK
MacMini 1.5Ghz PowerPC G4 running MacOS X 10.4.11 - Duff
Powerbook 1Ghz PowerPC G4 running MacOX X 10.5.5 - OK

All disks are formatted "Journaled HFS+". I have the same 
version of gcc and the development environment on both the
tiger machines. Here is a trace from the machine and test
that fails:-

>fergus:bash -x t1301-shared-repo.sh  -d -v -i
>+ test_description=Test shared repository initialization
>+ . ./test-lib.sh
>++ ORIGINAL_TERM=xterm-color
>++ LANG=C
>++ LC_ALL=C
>++ PAGER=cat
>++ TZ=UTC
>++ TERM=dumb
>++ export LANG LC_ALL PAGER TERM TZ
>++ EDITOR=:
>++ VISUAL=:
>++ unset GIT_EDITOR
>++ unset AUTHOR_DATE
>++ unset AUTHOR_EMAIL
>++ unset AUTHOR_NAME
>++ unset COMMIT_AUTHOR_EMAIL
>++ unset COMMIT_AUTHOR_NAME
>++ unset EMAIL
>++ unset GIT_ALTERNATE_OBJECT_DIRECTORIES
>++ unset GIT_AUTHOR_DATE
>++ GIT_AUTHOR_EMAIL=author@example.com
>++ GIT_AUTHOR_NAME=A U Thor
>++ unset GIT_COMMITTER_DATE
>++ GIT_COMMITTER_EMAIL=committer@example.com
>++ GIT_COMMITTER_NAME=C O Mitter
>++ unset GIT_DIFF_OPTS
>++ unset GIT_DIR
>++ unset GIT_WORK_TREE
>++ unset GIT_EXTERNAL_DIFF
>++ unset GIT_INDEX_FILE
>++ unset GIT_OBJECT_DIRECTORY
>++ unset GIT_CEILING_DIRECTORIES
>++ unset SHA1_FILE_DIRECTORIES
>++ unset SHA1_FILE_DIRECTORY
>++ GIT_MERGE_VERBOSITY=5
>++ export GIT_MERGE_VERBOSITY
>++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>++ export EDITOR VISUAL
>++ GIT_TEST_CMP=diff -u
>++ unset CDPATH
>+++ echo
>+++ tr '[A-Z]' '[a-z]'
>++ '[' xxterm-color '!=' xdumb ']'
>++ TERM=xterm-color
>++ export TERM
>++ '[' -t 1 ']'
>++ tput bold
>++ tput setaf 1
>++ tput sgr0
>++ color=t
>++ test 3 -ne 0
>++ debug=t
>++ shift
>++ test 2 -ne 0
>++ verbose=t
>++ shift
>++ test 1 -ne 0
>++ immediate=t
>++ shift
>++ test 0 -ne 0
>++ test -n t
>++ test 'Test shared repository initialization' '!=' ''
>++ test '' = t
>++ exec
>++ test t = t
>++ exec
>++ test_failure=0
>++ test_count=0
>++ test_fixed=0
>++ test_broken=0
>++ test_success=0
>++ trap die exit
>+++ pwd
>++ TEST_DIRECTORY=/usr/local/packages/git-1.6.0.2/t
>++ PATH=/usr/local/packages/git-1.6.0.2/t/..:/usr/local/bin:/usr/local/pgsql/bin:/bin:/sbin:/usr/bin:/usr/local/bin:/usr/sbin:/Volumes/TechmorePB/fergus/Current\ Contract/cwid-fixup/rollitts
>+++ pwd
>++ GIT_EXEC_PATH=/usr/local/packages/git-1.6.0.2/t/..
>+++ pwd
>++ GIT_TEMPLATE_DIR=/usr/local/packages/git-1.6.0.2/t/../templates/blt
>++ unset GIT_CONFIG
>++ unset GIT_CONFIG_LOCAL
>++ GIT_CONFIG_NOSYSTEM=1
>++ GIT_CONFIG_NOGLOBAL=1
>++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
>+++ pwd
>+++ pwd
>++ GITPERLLIB=/usr/local/packages/git-1.6.0.2/t/../perl/blib/lib:/usr/local/packages/git-1.6.0.2/t/../perl/blib/arch/auto/Git
>++ export GITPERLLIB
>++ test -d ../templates/blt
>++ test -x ../test-chmtime
>++ . ../GIT-BUILD-OPTIONS
>+++ SHELL_PATH=/bin/sh
>+++ TAR=tar
>++ test=trash directory
>++ rm -fr 'trash directory'
>++ test_create_repo 'trash directory'
>++ test 1 = 1
>+++ pwd
>++ owd=/usr/local/packages/git-1.6.0.2/t
>++ repo=trash directory
>++ mkdir 'trash directory'
>++ cd 'trash directory'
>++ /usr/local/packages/git-1.6.0.2/t/../git init --template=/usr/local/packages/git-1.6.0.2/t/../templates/blt/
>Initialized empty Git repository in /usr/local/packages/git-1.6.0.2/t/trash directory/.git/
>++ mv .git/hooks .git/hooks-disabled
>++ cd /usr/local/packages/git-1.6.0.2/t
>++ cd -P 'trash directory'
>+++ expr ./t1301-shared-repo.sh : '.*/\(t[0-9]*\)-[^/]*$'
>++ this_test=t1301
>+ test_expect_success 'shared = 0400 (faulty permission u-w)' '
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>+ test 2 = 2
>+ test_skip 'shared = 0400 (faulty permission u-w)' '
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>++ expr ./t1301-shared-repo.sh : '.*/\(t[0-9]*\)-[^/]*$'
>+ this_test=t1301
>++ expr 0 + 1
>+ this_test=t1301.1
>+ to_skip=
>+ false
>+ say 'expecting success: 
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>+ say_color info 'expecting success: 
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>+ TERM=xterm-color
>+ export TERM
>+ tput setaf 3
>+ shift
>+ echo '* expecting success: 
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>* expecting success: 
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>
>+ tput sgr0
>+ test_run_ '
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>+ eval '
>        mkdir sub && (
>                cd sub && git init --shared=0400
>        )
>        ret="$?"
>        rm -rf sub
>        test $ret != "0"
>'
>++ mkdir sub
>++ cd sub
>++ git init --shared=0400
>fatal: Problem with core.sharedRepository filemode value (0400).
>The owner of files must always have read and write permissions.
>++ ret=128
>++ rm -rf sub
>++ test 128 '!=' 0
>+ eval_ret=0
>+ return 0
>+ '[' 0 = 0 -a 0 = 0 ']'
>+ test_ok_ 'shared = 0400 (faulty permission u-w)'
>++ expr 0 + 1
>+ test_count=1
>++ expr 0 + 1
>+ test_success=1
>+ say_color '' '  ok 1: shared = 0400 (faulty permission u-w)'
>+ TERM=xterm-color
>+ export TERM
>+ test -n ''
>+ shift
>+ echo '*   ok 1: shared = 0400 (faulty permission u-w)'
>*   ok 1: shared = 0400 (faulty permission u-w)
>+ tput sgr0
>+ echo ''
>
>+ test_expect_success 'shared=1 does not clear bits preset by umask 002' '
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>+ test 2 = 2
>+ test_skip 'shared=1 does not clear bits preset by umask 002' '
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>++ expr ./t1301-shared-repo.sh : '.*/\(t[0-9]*\)-[^/]*$'
>+ this_test=t1301
>++ expr 1 + 1
>+ this_test=t1301.2
>+ to_skip=
>+ false
>+ say 'expecting success: 
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>+ say_color info 'expecting success: 
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>+ TERM=xterm-color
>+ export TERM
>+ tput setaf 3
>+ shift
>+ echo '* expecting success: 
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>* expecting success: 
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>
>+ tput sgr0
>+ test_run_ '
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>+ eval '
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>++ mkdir sub
>++ cd sub
>++ umask 002
>++ git init --shared=1
>fatal: Could not make /usr/local/packages/git-1.6.0.2/t/trash directory/sub/.git/refs writable by group
>
>++ echo Oops, .git/HEAD is not 0664 but
>Oops, .git/HEAD is not 0664 but
>++ false
>+ eval_ret=1
>+ return 0
>+ '[' 0 = 0 -a 1 = 0 ']'
>+ test_failure_ 'shared=1 does not clear bits preset by umask 002' '
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>++ expr 1 + 1
>+ test_count=2
>++ expr 0 + 1
>+ test_failure=1
>+ say_color error 'FAIL 2: shared=1 does not clear bits preset by umask 002'
>+ TERM=xterm-color
>+ export TERM
>+ tput bold
>+ tput setaf 1
>+ shift
>+ echo '* FAIL 2: shared=1 does not clear bits preset by umask 002'
>* FAIL 2: shared=1 does not clear bits preset by umask 002
>+ tput sgr0
>+ shift
>+ echo '
>                mkdir sub && (
>                        cd sub &&
>                        umask $u &&
>                        git init --shared=1 &&
>                        test 1 = "$(git config core.sharedrepository)"
>                ) &&
>                actual=$(ls -l sub/.git/HEAD)
>                case "$actual" in
>                -rw-rw-r--*)
>                        : happy
>                        ;;
>                *)
>                        echo Oops, .git/HEAD is not 0664 but $actual
>                        false
>                        ;;
>                esac
>        '
>+ sed -e 's/^/  /'
>
>                        mkdir sub && (
>                                cd sub &&
>                                umask $u &&
>                                git init --shared=1 &&
>                                test 1 = "$(git config core.sharedrepository)"
>                        ) &&
>                        actual=$(ls -l sub/.git/HEAD)
>                        case "$actual" in
>                        -rw-rw-r--*)
>                                : happy
>                                ;;
>                        *)
>                                echo Oops, .git/HEAD is not 0664 but $actual
>                                false
>                                ;;
>                        esac
>
>+ test t = ''
>+ trap - exit
>+ exit 1
>fergus:


Doing this manually I get:-

fergus:mkdir sub
fergus:cd sub 
fergus:../../git init --shared=0400
fatal: Problem with core.sharedRepository filemode value (0400).
The owner of files must always have read and write permissions.
fergus:echo $?
128
fergus:ls -al
total 0
drwxr-xr-x     3 fergus  wheel    102 Oct 21 18:24 .
drwxr-xr-x   333 fergus  wheel  11322 Oct 21 18:23 ..
drwxr-xr-x     2 fergus  wheel     68 Oct 21 18:24 sub
fergus:ls -al sub
total 0
drwxr-xr-x   2 fergus  wheel   68 Oct 21 18:24 .
drwxr-xr-x   3 fergus  wheel  102 Oct 21 18:24 ..


Any ideas where is going on? I have the same version of gcc
and the development environment on both the tiger machines.
-- 

===============================================================
Fergus McMenemie               Email:fergus@twig.me.uk
Techmore Ltd                   Phone:(UK) 07721 376021

Unix/Mac/Intranets             Analyst Programmer
===============================================================
