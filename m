From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
Date: Fri, 08 Jun 2012 22:51:19 +0200
Message-ID: <4FD265C7.6050807@web.de>
References: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339167235-2009-2-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD24AE9.8020101@web.de> <20120608211540.Horde.SRiCRHwdC4BP0k9c5TdWBaA@webmail.minatec.grenoble-inp.fr> <4FD258AD.6070601@web.de> <20120608220751.Horde.HHn7fXwdC4BP0luXQhxWxBA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 22:51:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd69b-0002J1-CE
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 22:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934476Ab2FHUv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 16:51:26 -0400
Received: from mout.web.de ([212.227.17.11]:62575 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759707Ab2FHUvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 16:51:25 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MaJng-1SNdfE0a76-00KITw; Fri, 08 Jun 2012 22:51:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120608220751.Horde.HHn7fXwdC4BP0luXQhxWxBA@webmail.minatec.grenoble-inp.fr>
X-Provags-ID: V02:K0:I8aO0UELPEB1wOULN6nnR2RILCJRoCsWvcvpH9etHoV
 HVxKewSjveerjUj4aBJZjvSd2JtH2fFYYlZXatO8cVTV6jcca/
 Ce/VJVAa/W34ZozDtimX/LZHE54LtJCqvzBK6nUwgFTtLrNh5Q
 A0mPJCqXsKg63vahaGki482E8g2dk+fIrovjs6RB7lWlTDjbB5
 l/RFVFhop0u6hHttM0Frg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199531>

On 08.06.12 22:07, konglu@minatec.inpg.fr wrote:
>=20
> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>=20
>> On 08.06.12 21:15, konglu@minatec.inpg.fr wrote:
>>>
>>> Torsten B=F6gershausen <tboegi@web.de> a =E9crit :
>>
>>> Which part does not apply ? If you skip the part that's implementin=
g the
>>> exec option, of course Git will not recognize it.
>>
>>
>> Hej,
>> 2 questions:
>> a) Where should it apply ?
>> I tried to apply it on commit f623ca1cae600e97cb0b38131fdd33e4fb669c=
f8
>=20
> I just tried to apply it on that commit and it works for me. What's t=
he
> error message ?
>=20
>> b) Does the line from my log
>> "error: unknown option `exec'"
>> tell us anything?
>=20
> Yes, that the patch was not applied ^^'.
------------------------------------------------
That's the outcome, if I try to re-apply it:
Applying: Fwd: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>...
error: patch failed: Documentation/git-rebase.txt:210
error: Documentation/git-rebase.txt: patch does not apply
Patch failed at 0001 Fwd: [PATCHv3 2/2] rebase [-i --exec | -ix] <CMD>.=
=2E.
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
And after my fumbling, the diff looks like this (see below).
It seems that something changed, because the error line is different-=20

Sorry if I messed something up here, it looks as if the functionality i=
mplementing
the "exec" is missing in my code base.
=46or me it looks as if I only picked up the test cases, and I'm missin=
g something.

In this case it would be helpful if you just re-send the patch to my em=
ail,
and I can try to re-do the patch based on f623ca1cae600e97cb0b38,
or whatever you specify.
Does that makes sense?
/Torsten
=20
------------------------
git diff  f623ca1cae600e97cb0b38..63884a991c9d8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 147fa1a..1dd95c4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,9 +8,9 @@ git-rebase - Forward-port local commits to the updated =
upstream head
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [options] [--onto <newbase>]
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <ne=
wbase>]
 	[<upstream>] [<branch>]
-'git rebase' [-i | --interactive] [options] --onto <newbase>
+'git rebase' [-i | --interactive] [options] [--exec <cmd>] --onto <new=
base>
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort
=20
@@ -210,11 +210,29 @@ rebase.autosquash::
=20
 OPTIONS
 -------
-<newbase>::
-	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.  May be any valid commit, and not just an
-	existing branch name.
+-x <cmd>::
+--exec <cmd>::
+	Automatically add "exec" followed by <cmd> between each commit
+	applications. Using this option along with --autosquash adds
+	the exec line after the squash/fixeup series only. <cmd>
+	stands for shell commands. The --exec option has to be
+	specified. (see INTERACTIVE MODE below)
++
+This has to be used along with the `--interactive` option explicitly.
+You may execute several commands between each commit applications.
+For this, you can use one instance of exec:
+	git rebase -i --exec "cmd1; cmd2; ...".
+You can also insert several instances of exec, if you wish to
+only have one command per line for example:
+	git rebase -i --exec "cmd1" --exec "cmd2" ...
+
+--onto <newbase>::
+	With this option, git rebase takes all commits from <branch>,
+	that are not in <upstream>, and transplant them on top of
+	<newbase>. <newbase> is the starting point at which to create
+	the new commits. If the --onto option is not specified, the
+	starting point is <upstream>.  May be any valid commit, and
+	not just an existing branch name.
 +
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
@@ -521,6 +539,28 @@ in `$SHELL`, or the default shell if `$SHELL` is n=
ot set), so you can
 use shell features (like "cd", ">", ";" ...). The command is run from
 the root of the working tree.
=20
+----------------------------------
+$ git rebase -i --exec "make test"
+----------------------------------
+
+This command lets you check that intermediate commits are compilable.
+The todo list becomes like that:
+
+--------------------
+pick 5928aea one
+exec make test
+pick 04d0fda two
+exec make test
+pick ba46169 three
+exec make test
+pick f4593f9 four
+exec make test
+--------------------
+
+If the option '-i' is missing, The command will return a message
+error. If there is no <cmd> specified behind --exec, the command will
+return a message error and the usage page of 'git rebase'.
+
 SPLITTING COMMITS
 -----------------
=20
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..dc9e7e9 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -684,6 +684,22 @@ rearrange_squash () {
 	rm -f "$1.sq" "$1.rearranged"
 }
=20
+# Add commands after a pick or after a squash/fixup serie
+# in the todo list.
+add_exec_commands () {
+	OIFS=3D$IFS
+	IFS=3D$LF
+	for i in $cmd
+	do
+		tmp=3D$(sed "/^pick .*/i\exec $i" "$1")
+		echo "$tmp" >"$1"
+		tmp=3D$(sed '1d' "$1")
+		echo "$tmp" >"$1"
+		echo "exec $i" >>"$1"
+	done
+	IFS=3D$OIFS
+}
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -857,6 +873,8 @@ fi
=20
 test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
+test -n "$cmd" && add_exec_commands "$todo"
+
 cat >> "$todo" << EOF
=20
 # Rebase $shortrevisions onto $shortonto
diff --git a/git-rebase.sh b/git-rebase.sh
index e616737..87b21e3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,8 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
=20
-USAGE=3D'[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--=
onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE=3D'[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase=
 | -f]
+       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--=
quiet | -q]'
 LONG_USAGE=3D'git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream=
>
@@ -30,8 +31,8 @@ Example:       git-rebase master~1 topic
 SUBDIRECTORY_OK=3DYes
 OPTIONS_KEEPDASHDASH=3D
 OPTIONS_SPEC=3D"\
-git rebase [-i] [options] [--onto <newbase>] [<upstream>] [<branch>]
-git rebase [-i] [options] --onto <newbase> --root [<branch>]
+git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream=
>] [<branch>]
+git rebase [-i] [options] [--exec <cmd>] --onto <newbase> --root [<bra=
nch>]
 git-rebase [-i] --continue | --abort | --skip
 --
  Available options are
@@ -43,6 +44,7 @@ s,strategy=3D!       use the given merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
+x,exec=3D!           add exec lines after each commit of the editable =
list
 k,keep-empty	   preserve empty commits during rebase
 f,force-rebase!    force rebase even if branch is up to date
 X,strategy-option=3D! pass the argument through to the merge strategy
@@ -76,6 +78,7 @@ If you would prefer to skip this patch, instead run \=
"git rebase --skip\".
 To check out the original branch and stop rebasing run \"git rebase --=
abort\".
 "
 unset onto
+cmd=3D
 strategy=3D
 strategy_opts=3D
 do_merge=3D
@@ -220,6 +223,11 @@ do
 		onto=3D"$2"
 		shift
 		;;
+	-x)
+		test 2 -le "$#" || usage
+		cmd=3D"${cmd:+"$cmd$LF"} $2"
+		shift
+		;;
 	-i)
 		interactive_rebase=3Dexplicit
 		;;
@@ -305,6 +313,12 @@ do
 done
 test $# -gt 2 && usage
=20
+if test -n "$cmd" &&
+   test "$interactive_rebase" !=3D explicit
+then
+	die "--exec option must be used with --interactive option\n"
+fi
+
 if test -n "$action"
 then
 	test -z "$in_progress" && die "No rebase in progress?"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index 025c1c6..4fe98d5 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -755,4 +755,128 @@ test_expect_success 'rebase-i history with funny =
messages' '
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'prepare for rebase -i --exec' '
+	git checkout master &&
+	git checkout -b execute &&
+	test_commit one_exec main.txt one_exec &&
+	test_commit two_exec main.txt two_exec &&
+	test_commit three_exec main.txt three_exec
+'
+
+
+test_expect_success 'running "git rebase -i --exec git show HEAD"' '
+	git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase --exec git show HEAD -i"' '
+	git reset --hard execute &&
+	git rebase --exec "git show HEAD" -i HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'running "git rebase -ix git show HEAD"' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several <CMD>' '
+	git reset --hard execute &&
+	git rebase -ix "git show HEAD; pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD;_pwd 2 exec_git_show_HEAD;_pwd" &=
&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,9d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with several instances of --exec' '
+	git reset --hard execute &&
+	git rebase -i --exec "git show HEAD" --exec "pwd" HEAD~2 >actual &&
+	(
+		FAKE_LINES=3D"1 exec_git_show_HEAD exec_pwd 2
+				exec_git_show_HEAD exec_pwd" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~2 >expected
+	) &&
+	sed '1,11d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -ix with --autosquash' '
+	git reset --hard execute &&
+	git checkout -b autosquash &&
+	echo second >second.txt &&
+	git add second.txt &&
+	git commit -m "fixup! two_exec" &&
+	echo bis >bis.txt &&
+	git add bis.txt &&
+	git commit -m "fixup! two_exec" &&
+	(
+		git checkout -b autosquash_actual &&
+		git rebase -i --exec "git show HEAD" --autosquash HEAD~4 >actual
+	) &&
+	git checkout autosquash &&
+	(
+		git checkout -b autosquash_expected &&
+		FAKE_LINES=3D"1 fixup 3 fixup 4 exec_git_show_HEAD 2 exec_git_show_H=
EAD" &&
+		export FAKE_LINES &&
+		git rebase -i HEAD~4 >expected
+	) &&
+	sed '1,13d' expected >expect &&
+	mv expect expected &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase --exec without -i shows error message' '
+	git reset --hard execute &&
+	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
+	echo "--exec option must be used with --interactive option\n" >expect=
ed &&
+	test_cmp expected actual
+'
+
+
+test_expect_success 'rebase -i --exec without <CMD> shows error messag=
e and usage' '
+	git reset --hard execute &&
+	test_must_fail git rebase -i --exec 2>actual &&
+	sed '1d' actual >tmp &&
+	mv tmp actual &&
+	test_must_fail git rebase -h >expected &&
+	test_cmp expected actual &&
+	git checkout master
+'
+
 test_done
