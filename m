From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: make test
Date: Mon, 15 Oct 2012 13:37:49 +0200
Message-ID: <003801cdaac9$81d5bff0$85813fd0$@schmitz-digital.de>
References: <k5gov5$fe1$1@ger.gmane.org> <507BEB12.9040101@viscovery.net> <003101cdaac4$430b7a30$c9226e90$@schmitz-digital.de> <507BF0EA.7000805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Sixt'" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:38:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNj0G-0007x4-B8
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab2JOLiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:38:19 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62064 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab2JOLiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:38:14 -0400
Received: from DualCore (dsdf-4d0a1987.pool.mediaWays.net [77.10.25.135])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0LmeMF-1TvxcU0DLv-00ZkkB; Mon, 15 Oct 2012 13:38:13 +0200
In-Reply-To: <507BF0EA.7000805@viscovery.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIVSFpveJljjAzS/2bNxxeCRCIxGwHjqAgSAptEk9IBw7/mtpb46DFg
Content-Language: de
X-Provags-ID: V02:K0:urw9l9t7gIF6La8vnCiUhwy5HJtCHUalV7/r5QwF2+B
 t3ypPz5VWAWQhO6diKaNk815GEBQ+T/uHioeWvfT4HMTE2pJ2k
 dYNkctKT1Xd06EdbmOlpVef/p4+kprh4DM2blc5pqgp3oB4ZS1
 xcjQjq4XxKbufIxs3eruGmuloJry/JirmT84WFuvL1wqFp8LT3
 eHSFodBpbsfIvpvFbFJjErd6bCSOWcwbFUJ1VbaQ7BbNOhK7d/
 zHFxYbl/JWO8ghDGtuohG1/bZ+4xTgHqCeTMnkUuakAJc/Y5AG
 eSqjCdR1ZBJ429j4m58hjE2bC7AtKlfx57g2e4XRWO07dxyB3o
 qHz2KsC4pdajeDmc03CLsyqMPG6mR0eNn2KZsh7Si7mWPSwt2f
 AoMC9ZFGNaXuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207737>

> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> Sent: Monday, October 15, 2012 1:18 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: make test
> 
> Am 10/15/2012 13:00, schrieb Joachim Schmitz:
> >> From: Johannes Sixt [mailto:j.sixt@viscovery.net]
> >> and if that does not give sufficient clues,
> >>
> >>   $SHELL_PATH -x ./t0000-basic.sh -v -i
> >
> > not ok - 12 tests clean up even on failures
> > #...
> > + die
> >
> > Looks identical, except for the "die" at the end. And still leaves me without a clue...
> 
> When I do that it begins like this (I'm on Windows):
> 
> D:\Src\mingw-git\t>bash -x t0000-basic.sh -v -i
> + test_description='Test the very basics part #1.
> ...
> '
> + . ./test-lib.sh
> ++ ORIGINAL_TERM=cygwin
> ++ test -z ''
> +++ pwd
> ++ TEST_DIRECTORY=/d/Src/mingw-git/t
> ++ test -z ''
> ++ TEST_OUTPUT_DIRECTORY=/d/Src/mingw-git/t
> ++ GIT_BUILD_DIR=/d/Src/mingw-git/t/..
> ++ /d/Src/mingw-git/t/../git
> ++ test 1 '!=' 1
> ++ . /d/Src/mingw-git/t/../GIT-BUILD-OPTIONS
> +++ SHELL_PATH=/bin/sh
> +++ PERL_PATH=/usr/bin/perl
> +++ DIFF=diff
> +++ PYTHON_PATH=/usr/bin/python
> +++ TAR=tar
> ...
> 
> It seems you need a shell that is verbose under -x.


Erm, no, I left that part out...

+ . ./test-lib.sh
++ ORIGINAL_TERM=dumb
++ test -z ''
+++ pwd
++ TEST_DIRECTORY=/home/jojo/git/git/t
++ test -z ''
++ TEST_OUTPUT_DIRECTORY=/home/jojo/git/git/t
++ GIT_BUILD_DIR=/home/jojo/git/git/t/..
++ /home/jojo/git/git/t/../git
++ test 1 '!=' 1
++ . /home/jojo/git/git/t/../GIT-BUILD-OPTIONS
+++ SHELL_PATH=/bin/sh
+++ PERL_PATH=/usr/local/bin/perl
+++ DIFF=diff
+++ PYTHON_PATH=/usr/local/bin/python
+++ TAR=tar
+++ NO_CURL=
+++ USE_LIBPCRE=
+++ NO_PERL=
+++ NO_PYTHON=
+++ NO_UNIX_SOCKETS=
+++ GIT_TEST_CMP_USE_COPIED_CONTEXT=YesPlease
+++ NO_GETTEXT=
+++ GETTEXT_POISON=
++ export PERL_PATH SHELL_PATH
++ case "$GIT_TEST_TEE_STARTED, $* " in
++ LANG=C
++ LC_ALL=C
++ PAGER=cat
++ TZ=UTC
++ TERM=dumb
++ export LANG LC_ALL PAGER TERM TZ
++ EDITOR=:
+++ /usr/local/bin/perl -e '
        my @env = keys %ENV;
        my $ok = join("|", qw(
                TRACE
                DEBUG
                USE_LOOKUP
                TEST
                .*_TEST
                PROVE
                VALGRIND
                PERF_AGGREGATING_LATER
        ));
        my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
        print join("\n", @vars);
'
++ unset VISUAL EMAIL LANGUAGE COLUMNS GIT_AUTHOR_NAME GIT_MERGE_AUTOEDIT GIT_EXEC_PATH GIT_ATTR_NOSYSTEM GIT_MERGE_VERBOSITY
GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
++ unset XDG_CONFIG_HOME
++ GIT_AUTHOR_EMAIL=author@example.com
++ GIT_AUTHOR_NAME='A U Thor'
++ GIT_COMMITTER_EMAIL=committer@example.com
++ GIT_COMMITTER_NAME='C O Mitter'
++ GIT_MERGE_VERBOSITY=5
++ GIT_MERGE_AUTOEDIT=no
++ export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
++ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
++ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
++ export EDITOR
++ expr '  ' : '.* --valgrind '
++ test -n ''
++ unset CDPATH
++ unset GREP_OPTIONS
++ case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
+++ echo
+++ tr '[A-Z]' '[a-z]'
++ _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
++
_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-
f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0
-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
++ _z40=0000000000000000000000000000000000000000
++ LF='
'
++ export _x05 _x40 _z40 LF
++ '[' xdumb '!=' xdumb ']'
++ test 2 -ne 0
++ case "$1" in
++ verbose=t
++ shift
++ test 1 -ne 0
++ case "$1" in
++ immediate=t
++ shift
++ test 0 -ne 0
++ test -n ''
++ test 'Test the very basics part #1.
The rest of the test suite does not check the basic operation of git
plumbing commands to work very carefully.  Their job is to concentrate
on tricky features that caused bugs in the past to detect regression.

This test runs very basic features, like registering things in cache,
writing tree, etc.

Note that this test *deliberately* hard-codes many expected object
IDs.  When object ID computation changes, like in the previous case of
swapping compression and hashing order, the person who is making the
modification *should* take notice and update the test vectors here.
' '!=' ''
++ test '' = t
++ exec
++ exec
++ test t = t
++ exec
++ test_failure=0
++ test_count=0
++ test_fixed=0
++ test_broken=0
++ test_success=0
++ test_external_has_tap=0
++ GIT_EXIT_OK=
++ trap die EXIT
++ . /home/jojo/git/git/t/test-lib-functions.sh
+++ satisfied_prereq=' '
+++ lazily_testable_prereq=
+++ lazily_tested_prereq=
++ test -n ''
++ test -n ''
++ git_bin_dir=/home/jojo/git/git/t/../bin-wrappers
++ test -x /home/jojo/git/git/t/../bin-wrappers/git
++
PATH=/home/jojo/git/git/t/../bin-wrappers:/home/jojo/git/git/t/../bin-wrappers:/bin:/bin/unsupported:/usr/bin:/usr/ucb:/usr/local/bi
n:/usr/tandem/java/bin:/home/jojo/bin
++ GIT_EXEC_PATH=/home/jojo/git/git/t/..
++ test -n ''
++ GIT_TEMPLATE_DIR=/home/jojo/git/git/t/../templates/blt
++ unset GIT_CONFIG
++ GIT_CONFIG_NOSYSTEM=1
++ GIT_ATTR_NOSYSTEM=1
++ export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
++ test -z ''
++ test -n YesPlease
++ GIT_TEST_CMP='diff -c'
++ GITPERLLIB=/home/jojo/git/git/t/../perl/blib/lib:/home/jojo/git/git/t/../perl/blib/arch/auto/Git
++ export GITPERLLIB
++ test -d /home/jojo/git/git/t/../templates/blt
++ test -z ''
++ test -z ''
++ GITPYTHONLIB=/home/jojo/git/git/t/../git_remote_helpers/build/lib
++ export GITPYTHONLIB
++ test -d /home/jojo/git/git/t/../git_remote_helpers/build
++ test -x /home/jojo/git/git/t/../test-chmtime
+++ basename ./t0000-basic.sh .sh
++ test='trash directory.t0000-basic'
++ test -n ''
++ case "$test" in
++ TRASH_DIRECTORY='/home/jojo/git/git/t/trash directory.t0000-basic'
++ test '!' -z ''
++ remove_trash='/home/jojo/git/git/t/trash directory.t0000-basic'
++ rm -fr 'trash directory.t0000-basic'
++ HOME='/home/jojo/git/git/t/trash directory.t0000-basic'
++ export HOME
++ test -z ''
++ test_create_repo 'trash directory.t0000-basic'
++ test 1 = 1
++ repo='trash directory.t0000-basic'
++ mkdir -p 'trash directory.t0000-basic'
++ cd 'trash directory.t0000-basic'
++ /home/jojo/git/git/t/../git-init --template=/home/jojo/git/git/t/../templates/blt/
Initialized empty Git repository in /home/jojo/git/git/t/trash directory.t0000-basic/.git/
++ mv .git/hooks .git/hooks-disabled
++ cd -P 'trash directory.t0000-basic'
++ this_test=t0000-basic.sh
++ this_test=t0000
++ case $(uname -s) in
+++ uname -s
++ test_set_prereq POSIXPERM
++ satisfied_prereq=' POSIXPERM '
++ test_set_prereq BSLASHPSPEC
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC '
++ test_set_prereq EXECKEEPSPID
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID '
++ test_set_prereq NOT_MINGW
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW '
++ COLUMNS=1
++ test 1 = 1
++ test_set_prereq COLUMNS_CAN_BE_1
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW COLUMNS_CAN_BE_1 '
++ test -z ''
++ test_set_prereq PERL
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW COLUMNS_CAN_BE_1 PERL '
++ test -z ''
++ test_set_prereq PYTHON
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW COLUMNS_CAN_BE_1 PERL PYTHON '
++ test -n ''
++ test -z ''
++ test_set_prereq GETTEXT
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW COLUMNS_CAN_BE_1 PERL PYTHON GETTEXT '
++ test -n ''
++ test_set_prereq C_LOCALE_OUTPUT
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW COLUMNS_CAN_BE_1 PERL PYTHON GETTEXT C_LOCALE_OUTPUT '
++ test_lazy_prereq SYMLINKS '
        # test whether the filesystem supports symbolic links
        ln -s x y && test -h y
'
++ lazily_testable_prereq='SYMLINKS '
++ eval 'test_prereq_lazily_SYMLINKS=$2'
+++ test_prereq_lazily_SYMLINKS='
        # test whether the filesystem supports symbolic links
        ln -s x y && test -h y
'
++ test_lazy_prereq CASE_INSENSITIVE_FS '
        echo good >CamelCase &&
        echo bad >camelcase &&
        test "$(cat CamelCase)" != good
'
++ lazily_testable_prereq='SYMLINKS CASE_INSENSITIVE_FS '
++ eval 'test_prereq_lazily_CASE_INSENSITIVE_FS=$2'
+++ test_prereq_lazily_CASE_INSENSITIVE_FS='
        echo good >CamelCase &&
        echo bad >camelcase &&
        test "$(cat CamelCase)" != good
'
++ test_lazy_prereq UTF8_NFD_TO_NFC '
        # check whether FS converts nfd unicode to nfc
        auml=$(printf "\303\244")
        aumlcdiar=$(printf "\141\314\210")
        >"$auml" &&
        case "$(echo *)" in
        "$aumlcdiar")
                true ;;
        *)
                false ;;
        esac
'
++ lazily_testable_prereq='SYMLINKS CASE_INSENSITIVE_FS UTF8_NFD_TO_NFC '
++ eval 'test_prereq_lazily_UTF8_NFD_TO_NFC=$2'
+++ test_prereq_lazily_UTF8_NFD_TO_NFC='
        # check whether FS converts nfd unicode to nfc
        auml=$(printf "\303\244")
        aumlcdiar=$(printf "\141\314\210")
        >"$auml" &&
        case "$(echo *)" in
        "$aumlcdiar")
                true ;;
        *)
                false ;;
        esac
'
++ test -w /
++ test_set_prereq SANITY
++ satisfied_prereq=' POSIXPERM BSLASHPSPEC EXECKEEPSPID NOT_MINGW COLUMNS_CAN_BE_1 PERL PYTHON GETTEXT C_LOCALE_OUTPUT SANITY '
+ test_expect_success '.git/objects should be empty after git init in an empty repo' '
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
+ test 2 = 3
+ test_prereq=
+ test 2 = 2
+ export test_prereq
+ test_skip '.git/objects should be empty after git init in an empty repo' '
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
+ test_count=1
+ to_skip=
+ test -z ''
+ test -n ''
+ case "$to_skip" in
+ false
+ say 'expecting success:
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
+ say_color info 'expecting success:
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
+ test -z info
+ shift
+ echo 'expecting success:
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
expecting success:
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty

+ test_run_ '
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
+ test_cleanup=:
+ expecting_failure=
+ test_eval_ '
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
+ eval '
        find .git/objects -type f -print >should-be-empty &&
        test_line_count = 0 should-be-empty
'
++ find .git/objects -type f -print
++ test_line_count = 0 should-be-empty
++ test 3 '!=' 3
+++ wc -l
++ test 0 = 0
+ eval_ret=0
+ test -z t
+ test 0 = 0
+ setup_malloc_check
+ MALLOC_CHECK_=3
+ MALLOC_PERTURB_=165
+ export MALLOC_CHECK_ MALLOC_PERTURB_
+ test_eval_ :
+ eval :
++
+ teardown_malloc_check
+ unset MALLOC_CHECK_ MALLOC_PERTURB_
+ test t = t
+ test -n ''
+ return 0
+ test_ok_ '.git/objects should be empty after git init in an empty repo'
+ test_success=1
+ say_color '' 'ok 1 - .git/objects should be empty after git init in an empty repo'
+ test -z ''
+ test -n ''
+ shift
+ echo 'ok 1 - .git/objects should be empty after git init in an empty repo'
ok 1 - .git/objects should be empty after git init in an empty repo
+ echo ''

+ test_expect_success '.git/objects should have 3 subdirectories' '
        find .git/objects -type d -print >full-of-directories &&
        test_line_count = 3 full-of-directories
'
+ test 2 = 3
+ test_prereq=
...

Bye, Jojo
