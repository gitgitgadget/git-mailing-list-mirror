From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] Documentation: bisect: reformat more paragraphs.
Date: Sat, 24 Mar 2007 06:31:49 +0100
Message-ID: <20070324063149.56655ec8.chriscool@tuxfamily.org>
References: <20070324061307.127b2cbf.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:23:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyj3-0007de-27
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbXCXFXe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbXCXFXe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:23:34 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60756 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753380AbXCXFXd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:23:33 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 3A436B55D3;
	Sat, 24 Mar 2007 06:23:32 +0100 (CET)
In-Reply-To: <20070324061307.127b2cbf.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42980>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   73 ++++++++++++++++++++++-------------------
 1 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4bd468e..0bf8a08 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -12,8 +12,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-The command takes various subcommands, and different options
-depending on the subcommand:
+The command takes various subcommands, and different options depending
+on the subcommand:
 
  git bisect start [<paths>...]
  git bisect bad <rev>
@@ -24,10 +24,9 @@ depending on the subcommand:
  git bisect log
  git bisect run <cmd>...
 
-This command uses 'git-rev-list --bisect' option to help drive
-the binary search process to find which change introduced a bug,
-given an old "good" commit object name and a later "bad" commit
-object name.
+This command uses 'git-rev-list --bisect' option to help drive the
+binary search process to find which change introduced a bug, given an
+old "good" commit object name and a later "bad" commit object name.
 
 The way you use it is:
 
@@ -38,15 +37,16 @@ $ git bisect good v2.6.13-rc2		# v2.6.13-rc2 was the last version
 					# tested that was good
 ------------------------------------------------
 
-When you give at least one bad and one good versions, it will
-bisect the revision tree and say something like:
+When you give at least one bad and one good versions, it will bisect
+the revision tree and say something like:
 
 ------------------------------------------------
 Bisecting: 675 revisions left to test after this
 ------------------------------------------------
 
-and check out the state in the middle. Now, compile that kernel, and boot
-it. Now, let's say that this booted kernel works fine, then just do
+and check out the state in the middle. Now, compile that kernel, and
+boot it. Now, let's say that this booted kernel works fine, then just
+do
 
 ------------------------------------------------
 $ git bisect good			# this one is good
@@ -58,12 +58,12 @@ which will now say
 Bisecting: 337 revisions left to test after this
 ------------------------------------------------
 
-and you continue along, compiling that one, testing it, and depending on
-whether it is good or bad, you say "git bisect good" or "git bisect bad",
-and ask for the next bisection.
+and you continue along, compiling that one, testing it, and depending
+on whether it is good or bad, you say "git bisect good" or "git bisect
+bad", and ask for the next bisection.
 
-Until you have no more left, and you'll have been left with the first bad
-kernel rev in "refs/bisect/bad".
+Until you have no more left, and you'll have been left with the first
+bad kernel rev in "refs/bisect/bad".
 
 Oh, and then after you want to reset to the original head, do a
 
@@ -71,10 +71,10 @@ Oh, and then after you want to reset to the original head, do a
 $ git bisect reset
 ------------------------------------------------
 
-to get back to the master branch, instead of being in one of the bisection
-branches ("git bisect start" will do that for you too, actually: it will
-reset the bisection state, and before it does that it checks that you're
-not using some old bisection branch).
+to get back to the master branch, instead of being in one of the
+bisection branches ("git bisect start" will do that for you too,
+actually: it will reset the bisection state, and before it does that
+it checks that you're not using some old bisection branch).
 
 During the bisection process, you can say
 
@@ -84,9 +84,14 @@ $ git bisect visualize
 
 to see the currently remaining suspects in `gitk`.
 
-The good/bad input is logged, and `git bisect
-log` shows what you have done so far.  You can truncate its
-output somewhere and save it in a file, and run
+The good/bad input is logged, and 
+
+------------
+$ git bisect log
+------------
+
+shows what you have done so far. You can truncate its output somewhere
+and save it in a file, and run
 
 ------------
 $ git bisect replay that-file
@@ -95,12 +100,13 @@ $ git bisect replay that-file
 if you find later you made a mistake telling good/bad about a
 revision.
 
-If in a middle of bisect session, you know what the bisect
-suggested to try next is not a good one to test (e.g. the change
-the commit introduces is known not to work in your environment
-and you know it does not have anything to do with the bug you
-are chasing), you may want to find a near-by commit and try that
-instead.  It goes something like this:
+If in a middle of bisect session, you know what the bisect suggested
+to try next is not a good one to test (e.g. the change the commit
+introduces is known not to work in your environment and you know it
+does not have anything to do with the bug you are chasing), you may
+want to find a near-by commit and try that instead.
+
+It goes something like this:
 
 ------------
 $ git bisect good/bad			# previous round was good/bad.
@@ -110,13 +116,12 @@ $ git reset --hard HEAD~3		# try 3 revs before what
 					# was suggested
 ------------
 
-Then compile and test the one you chose to try.  After that,
-tell bisect what the result was as usual.
+Then compile and test the one you chose to try. After that, tell
+bisect what the result was as usual.
 
-You can further cut down the number of trials if you know what
-part of the tree is involved in the problem you are tracking
-down, by giving paths parameters when you say `bisect start`,
-like this:
+You can further cut down the number of trials if you know what part of
+the tree is involved in the problem you are tracking down, by giving
+paths parameters when you say `bisect start`, like this:
 
 ------------
 $ git bisect start arch/i386 include/asm-i386
-- 
1.5.1.rc1.14.ge96a-dirty
