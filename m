From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] Documentation: bisect: add some titles to some
 paragraphs.
Date: Sat, 24 Mar 2007 06:30:33 +0100
Message-ID: <20070324063033.c3b4eae5.chriscool@tuxfamily.org>
References: <20070324061614.b8ff00ab.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 24 06:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUyiW-0007N1-Ia
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 06:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXCXFWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 01:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbXCXFWT
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 01:22:19 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60734 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378AbXCXFWR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 01:22:17 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 7C1E9B5A50;
	Sat, 24 Mar 2007 06:22:16 +0100 (CET)
In-Reply-To: <20070324061614.b8ff00ab.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42978>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 0bf8a08..ae0a974 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -28,6 +28,9 @@ This command uses 'git-rev-list --bisect' option to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
 
+Basic bisect commands: start, bad, good
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The way you use it is:
 
 ------------------------------------------------
@@ -65,6 +68,9 @@ bad", and ask for the next bisection.
 Until you have no more left, and you'll have been left with the first
 bad kernel rev in "refs/bisect/bad".
 
+Bisect reset
+~~~~~~~~~~~~
+
 Oh, and then after you want to reset to the original head, do a
 
 ------------------------------------------------
@@ -76,6 +82,9 @@ bisection branches ("git bisect start" will do that for you too,
 actually: it will reset the bisection state, and before it does that
 it checks that you're not using some old bisection branch).
 
+Bisect visualize
+~~~~~~~~~~~~~~~~
+
 During the bisection process, you can say
 
 ------------
@@ -84,6 +93,9 @@ $ git bisect visualize
 
 to see the currently remaining suspects in `gitk`.
 
+Bisect log and bisect replay
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The good/bad input is logged, and 
 
 ------------
@@ -100,6 +112,9 @@ $ git bisect replay that-file
 if you find later you made a mistake telling good/bad about a
 revision.
 
+Avoiding to test a commit
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
 If in a middle of bisect session, you know what the bisect suggested
 to try next is not a good one to test (e.g. the change the commit
 introduces is known not to work in your environment and you know it
@@ -119,6 +134,9 @@ $ git reset --hard HEAD~3		# try 3 revs before what
 Then compile and test the one you chose to try. After that, tell
 bisect what the result was as usual.
 
+Cutting down bisection by giving path parameter to bisect start
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 You can further cut down the number of trials if you know what part of
 the tree is involved in the problem you are tracking down, by giving
 paths parameters when you say `bisect start`, like this:
@@ -127,6 +145,9 @@ paths parameters when you say `bisect start`, like this:
 $ git bisect start arch/i386 include/asm-i386
 ------------
 
+Bisect run
+~~~~~~~~~~
+
 If you have a script that can tell if the current source code is good
 or bad, you can automatically bisect using:
 
-- 
1.5.1.rc1.14.ge96a-dirty
