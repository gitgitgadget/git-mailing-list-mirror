From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 13:30:26 +0200
Message-ID: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
Cc: antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 13:31:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8RqV-0003Qy-RA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 13:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbbFZLay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 07:30:54 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54236 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827AbbFZLax (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 07:30:53 -0400
X-AuditID: 1207440d-f79136d00000402c-50-558d37dee364
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id E0.A2.16428.ED73D855; Fri, 26 Jun 2015 07:30:38 -0400 (EDT)
Received: from michael.fritz.box (p4FC9793D.dip0.t-ipconnect.de [79.201.121.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5QBUYo2024951
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Jun 2015 07:30:35 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqHvPvDfUoOGwqcXMmdYWm55PZLbo
	utLNZNHQe4XZYsH7o2wW/3csYLG4vWI+s8WyvilMFleevmZ34PT4+/4Dk8fV5gCPnbPusnsc
	O9bK7HHxkrLH8gev2D0+b5ILYI/itklKLCkLzkzP07dL4M749e42Y8HViYwVx69bNjBOK+1i
	5OSQEDCR2HjqESuELSZx4d56NhBbSOAyo8S7eSxdjFxA9gkmiZNXp4EVsQnoSizqaWYCsUUE
	1CQmth0CK2IWWM8kcfDeTLBuYQF1iUmr+tlBbBYBVYmZP56xgNi8AlESPWs+QG2Tkzh//Cfz
	BEbuBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRyM0v0UlNKNzFCgot3B+P/dTKHGAU4
	GJV4eGe09oQKsSaWFVfmHmKU5GBSEuUt1+kNFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCmywC
	lONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDuNANqFCxKTU+tSMvM
	KUFIM3FwggznkhIpTs1LSS1KLC3JiAeFenwxMNhBUjxAe6tA2nmLCxJzgaIQracYFaXEeXVB
	EgIgiYzSPLixsJTxilEc6Eth3jkgVTzAdAPX/QpoMBPQ4LfxXSCDSxIRUlINjDF+vtO+mPkE
	9DOGs/N9nBi2PKE8m8HqXfsNgao6FXGde+7WuSwuyqrTqlYo39zBle/TkPTw8foQkwI2FouQ
	Ndu/r36zc9+Ced1Xplo/rnuouXtuaZWHUbys19WeB4yzik+dZXrAKPbxcvwuPqn1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272772>

Thoroughly revise the "git bisect" manpage, including:

* Beef up the "Description" section.

* Integrate the good/bad alternate terms into more of the text.

* Merge the sections "Alternative terms: bisect new and bisect old"
  and "Alternative terms: use your own terms" into a single "Alternate
  terms" section.

* Make the first long example less specific to kernel development.

* De-emphasize implementation details in a couple of places.

* Add "(roughly N steps)" in the places where example output is shown.

* Move the "Getting help" section down.

* Remove the "Look for a fix instead of a regression in the code"
  example, as (1) it was in the "git bisect run" section, but it
  doesn't use that command, and (2) I think this usage is adequately
  explained in the "Alternate terms" section.

* Properly markup code within the prose.

* Lots of wordsmithing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
As I was reading the changes to the "git bisect" docs while trying to
understand Antoine Delaite's "bisect-terms" branch, I got the feeling
that the manpage could use some love. This is the result.

This patch applies on top of Antoine Delaite's "bisect-terms" branch
(as downloaded from Matthiew Moy's GitHub repo). It contains many
changes to the git-bisect manpage that I think improve the page
overall and also better integrate the documentation for the new
"terms" feature. Feel free to pick and choose parts of the changes.

 Documentation/git-bisect.txt | 230 +++++++++++++++++++++++--------------------
 1 file changed, 125 insertions(+), 105 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ce7be5a..2de8b3a 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -3,7 +3,7 @@ git-bisect(1)
 
 NAME
 ----
-git-bisect - Find by binary search the change that introduced a bug
+git-bisect - Use binary search to find the commit that introduced a bug
 
 
 SYNOPSIS
@@ -16,7 +16,6 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect help
  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new) [<rev>]
  git bisect (good|old) [<rev>...]
@@ -26,64 +25,80 @@ on the subcommand:
  git bisect replay <logfile>
  git bisect log
  git bisect run <cmd>...
+ git bisect help
 
-This command uses 'git rev-list --bisect' to help drive the
-binary search process to find which change introduced a bug, given an
-old "good" commit object name and a later "bad" commit object name.
+This command uses a binary search algorithm to find which commit in
+your project's history introduced a bug. You use it by first telling
+it a "bad" commit that is known to contain the bug, and a "good"
+commit that is known to be before the bug was introduced. Then `git
+bisect` picks a commit between those two endpoints and asks you
+whether the selected commit is "good" or "bad". It continues narrowing
+down the range until it finds the exact commit that introduced the
+change.
 
-Getting help
-~~~~~~~~~~~~
+In fact, `git bisect` can be used to find the commit that changed
+*any* property of your project; e.g., the commit that fixed a bug, or
+the commit that caused a benchmark's performance to improve. To
+support this more general usage, the terms "old" and "new" can be used
+in place of "good" and "bad", or you can choose your own terms. See
+section "Alternate terms" below for more information.
 
-Use "git bisect" to get a short usage description, and "git bisect
-help" or "git bisect -h" to get a long usage description.
 
 Basic bisect commands: start, bad, good
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Using the Linux kernel tree as an example, basic use of the bisect
-command is as follows:
+As an example, suppose you are trying to find the commit that broke a
+feature that was known to work in version `v2.6.13-rc2` of your
+project. You start a bisect session as follows:
 
 ------------------------------------------------
 $ git bisect start
 $ git bisect bad                 # Current version is bad
-$ git bisect good v2.6.13-rc2    # v2.6.13-rc2 was the last version
-                                 # tested that was good
+$ git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good
+------------------------------------------------
+
+Once you have specified at least one bad and one good commit, `git
+bisect` selects a commit in the middle of that range of history,
+checks it out, and outputs something similar to the following:
+
+------------------------------------------------
+Bisecting: 675 revisions left to test after this (roughly 10 steps)
 ------------------------------------------------
 
-When you have specified at least one bad and one good version, the
-command bisects the revision tree and outputs something similar to
-the following:
+You should now compile the checked-out version and test it. If that
+version works correctly, type
 
 ------------------------------------------------
-Bisecting: 675 revisions left to test after this
+$ git bisect good
 ------------------------------------------------
 
-The state in the middle of the set of revisions is then checked out.
-You would now compile that kernel and boot it. If the booted kernel
-works correctly, you would then issue the following command:
+If that version is broken, type
 
 ------------------------------------------------
-$ git bisect good			# this one is good
+$ git bisect bad
 ------------------------------------------------
 
-The output of this command would be something similar to the following:
+Then `git bisect` will respond with something like
 
 ------------------------------------------------
-Bisecting: 337 revisions left to test after this
+Bisecting: 337 revisions left to test after this (roughly 9 steps)
 ------------------------------------------------
 
-You keep repeating this process, compiling the tree, testing it, and
-depending on whether it is good or bad issuing the command "git bisect good"
-or "git bisect bad" to ask for the next bisection.
+Keep repeating the process: compile the tree, test it, and depending
+on whether it is good or bad run `git bisect good` or `git bisect bad`
+to ask for the next commit that needs testing.
+
+Eventually there will be no more revisions left to bisect, and the
+command will print out a description of the first bad commit, and also
+create a reference called `refs/bisect/bad` that points at that
+commit.
 
-Eventually there will be no more revisions left to bisect, and you
-will have been left with the first bad kernel revision in "refs/bisect/bad".
 
 Bisect reset
 ~~~~~~~~~~~~
 
 After a bisect session, to clean up the bisection state and return to
-the original HEAD (i.e., to quit bisecting), issue the following command:
+the original HEAD, issue the following command:
 
 ------------------------------------------------
 $ git bisect reset
@@ -100,61 +115,73 @@ instead:
 $ git bisect reset <commit>
 ------------------------------------------------
 
-For example, `git bisect reset HEAD` will leave you on the current
-bisection commit and avoid switching commits at all, while `git bisect
-reset bisect/bad` will check out the first bad revision.
+For example, `git bisect reset bisect/bad` will check out the first
+bad revision, while `git bisect reset HEAD` will leave you on the
+current bisection commit and avoid switching commits at all.
+
+
+Alternate terms
+~~~~~~~~~~~~~~~
 
+Sometimes you are not looking for the commit that introduced a
+breakage, but rather for a commit that caused a change between some
+other "old" state and "new" state. For example, you might be looking
+for the commit that introduced a particular fix. Or you might be
+looking for the first commit in which the source-code filenames were
+finally all converted to your company's naming standard. Or whatever.
 
-Alternative terms: bisect new and bisect old
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+In such cases it can be very confusing to use the terms "good" and
+"bad" to refer to "the state before the change" and "the state after
+the change". So instead, you can use the terms "old" and "new",
+respectively, in place of "good" and "bad". (But note that you cannot
+mix "good" and "bad" with "old" and "new" in a single session.)
 
-If you are not at ease with the terms "bad" and "good", perhaps
-because you are looking for the commit that introduced a fix, you can
-alternatively use "new" and "old" instead.
-But note that you cannot mix "bad" and good" with "new" and "old".
+In this more general usage, you provide `git bisect` with a "new"
+commit has some property and an "old" commit that doesn't have that
+property. Each time `git bisect` checks out a commit, you test if that
+commit has the property. If it does, mark the commit as "new";
+otherwise, mark it as "old". When the bisection is done, `git bisect`
+will report which commit introduced the property.
+
+To use "old" and "new" instead of "good" and bad, you must run `git
+bisect start` without commits as argument and then run the following
+commands to add the commits:
 
 ------------------------------------------------
-git bisect new [<rev>]
+git bisect old [<rev>]
 ------------------------------------------------
 
-Marks the commit as new, e.g. "the bug is no longer there", if you are looking
-for a commit that fixed a bug, or "the feature that used to work is now broken
-at this point", if you are looking for a commit that introduced a bug.
-It is the equivalent of "git bisect bad [<rev>]".
+to indicate that a commit was before the sought change, or
 
 ------------------------------------------------
-git bisect old [<rev>...]
+git bisect new [<rev>...]
 ------------------------------------------------
 
-Marks the commit as old, as the opposite of 'git bisect new'.
-It is the equivalent of "git bisect good [<rev>...]".
+to indicate that it was after.
 
-You must run `git bisect start` without commits as argument and run
-`git bisect new <rev>`/`git bisect old <rev>...` after to add the
-commits.
+If you would like to use your own terms instead of "bad"/"good" or
+"new"/"old", you can choose any names you like by typing
 
-Alternative terms: use your own terms
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+------------------------------------------------
+git bisect terms <term-new> <term-old>
+------------------------------------------------
 
-If the builtins terms bad/good and new/old do not satisfy you, you can
-set your own terms.
+before starting a bisection session. For example, if you are looking
+for a commit that introduced a performance regression, you might use
 
 ------------------------------------------------
-git bisect terms <term-new> <term-old>
+git bisect terms slow fast
 ------------------------------------------------
 
-This command has to be used before a bisection has started. <term-new>
-must be associated with the latest revisions and <term-old> with some
-ancestors of <term-new>. For example, if something was buggy in the
-old part of the history, you know somewhere the bug was fixed, and you
-want to find the exact commit that fixed it, you may want to say `git
-bisect terms broken fixed`; this way, you would mark a commit that
-still has the bug with `broken`, and a newer one after the fix with
-`fixed`.
+Or if you are looking for the commit that fixed a bug, you might use
 
-Only the first bisection following the `git bisect terms` will use the
-terms. If you mistyped one of the terms you can do again `git bisect
-terms <term-new> <term-old>`.
+------------------------------------------------
+git bisect terms fixed broken
+------------------------------------------------
+
+If you mistype one of the terms, just run `git bisect terms` again
+with the corrected terms. Only the first bisect session after you run
+`git bisect terms` will use the specified terms.
 
 
 Bisect visualize
@@ -200,17 +227,17 @@ $ git bisect replay that-file
 Avoiding testing a commit
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If, in the middle of a bisect session, you know that the next suggested
-revision is not a good one to test (e.g. the change the commit
-introduces is known not to work in your environment and you know it
-does not have anything to do with the bug you are chasing), you may
-want to find a nearby commit and try that instead.
+If, in the middle of a bisect session, you know that the suggested
+revision is not a good one to test (e.g. it fails to build and you
+know that the failure does not have anything to do with the bug you
+are chasing), you can manually select a nearby commit and test that
+one instead.
 
 For example:
 
 ------------
 $ git bisect good/bad			# previous round was good or bad.
-Bisecting: 337 revisions left to test after this
+Bisecting: 337 revisions left to test after this (roughly 9 steps)
 $ git bisect visualize			# oops, that is uninteresting.
 $ git reset --hard HEAD~3		# try 3 revisions before what
 					# was suggested
@@ -222,18 +249,19 @@ the revision as good or bad in the usual manner.
 Bisect skip
 ~~~~~~~~~~~~
 
-Instead of choosing by yourself a nearby commit, you can ask Git
-to do it for you by issuing the command:
+Instead of choosing a nearby commit by yourself, you can ask Git to do
+it for you by issuing the command:
 
 ------------
 $ git bisect skip                 # Current version cannot be tested
 ------------
 
-But Git may eventually be unable to tell the first bad commit among
-a bad commit and one or more skipped commits.
+However, if you skip a commit adjacent to the one you are looking for,
+Git will be unable to tell exactly which of those commits was the
+first bad one.
 
-You can even skip a range of commits, instead of just one commit,
-using the "'<commit1>'..'<commit2>'" notation. For example:
+You can also skip a range of commits, instead of just one commit,
+using range notation. For example:
 
 ------------
 $ git bisect skip v2.5..v2.6
@@ -249,8 +277,8 @@ would issue the command:
 $ git bisect skip v2.5 v2.5..v2.6
 ------------
 
-This tells the bisect process that the commits between `v2.5` included
-and `v2.6` included should be skipped.
+This tells the bisect process that the commits between `v2.5` and
+`v2.6` (inclusive) should be skipped.
 
 
 Cutting down bisection by giving more parameters to bisect start
@@ -284,14 +312,14 @@ or bad, you can bisect by issuing the command:
 $ git bisect run my_script arguments
 ------------
 
-Note that the script (`my_script` in the above example) should
-exit with code 0 if the current source code is good, and exit with a
-code between 1 and 127 (inclusive), except 125, if the current
-source code is bad.
+Note that the script (`my_script` in the above example) should exit
+with code 0 if the current source code is good/old, and exit with a
+code between 1 and 127 (inclusive), except 125, if the current source
+code is bad/new.
 
 Any other exit code will abort the bisect process. It should be noted
-that a program that terminates via "exit(-1)" leaves $? = 255, (see the
-exit(3) manual page), as the value is chopped with "& 0377".
+that a program that terminates via `exit(-1)` leaves $? = 255, (see the
+exit(3) manual page), as the value is chopped with `& 0377`.
 
 The special exit code 125 should be used when the current source code
 cannot be tested. If the script exits with this code, the current
@@ -300,7 +328,7 @@ as the highest sensible value to use for this purpose, because 126 and 127
 are used by POSIX shells to signal specific error status (127 is for
 command not found, 126 is for command found but not executable---these
 details do not matter, as they are normal errors in the script, as far as
-"bisect run" is concerned).
+`bisect run` is concerned).
 
 You may often find that during a bisect session you want to have
 temporary modifications (e.g. s/#define DEBUG 0/#define DEBUG 1/ in a
@@ -313,7 +341,7 @@ next revision to test, the script can apply the patch
 before compiling, run the real test, and afterwards decide if the
 revision (possibly with the needed patch) passed the test and then
 rewind the tree to the pristine state.  Finally the script should exit
-with the status of the real test to let the "git bisect run" command loop
+with the status of the real test to let the `git bisect run` command loop
 determine the eventual outcome of the bisect session.
 
 OPTIONS
@@ -360,12 +388,12 @@ $ git bisect run ~/test.sh
 $ git bisect reset                   # quit the bisect session
 ------------
 +
-Here we use a "test.sh" custom script. In this script, if "make"
+Here we use a `test.sh` custom script. In this script, if `make`
 fails, we skip the current commit.
-"check_test_case.sh" should "exit 0" if the test case passes,
-and "exit 1" otherwise.
+`check_test_case.sh` should `exit 0` if the test case passes,
+and `exit 1` otherwise.
 +
-It is safer if both "test.sh" and "check_test_case.sh" are
+It is safer if both `test.sh` and `check_test_case.sh` are
 outside the repository to prevent interactions between the bisect,
 make and test processes and the scripts.
 
@@ -432,20 +460,12 @@ In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit
 has at least one parent whose reachable graph is fully traversable in the sense
 required by 'git pack objects'.
 
-* Look for a fix instead of a regression in the code
-+
-------------
-$ git bisect start
-$ git bisect new HEAD    # current commit is marked as new
-$ git bisect old HEAD~10 # the tenth commit from now is marked as old
-------------
-+
-Let's consider the last commit has a given property, and that we are looking
-for the commit which introduced this property. For each commit the bisection
-guide us to, we will test if the property is present. If it is we will mark
-the commit as new with 'git bisect new', otherwise we will mark it as old.
-At the end of the bisect session, the result will be the first new commit (e.g
-the first one with the property).
+
+Getting help
+~~~~~~~~~~~~
+
+Use `git bisect` to get a short usage description, and `git bisect
+help` or `git bisect -h` to get a long usage description.
 
 
 SEE ALSO
-- 
2.1.4
