From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 0/6] manual: Fix or remove em dashes.
Date: Tue, 9 Oct 2007 23:05:30 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071009210530.GH31317@ins.uni-bonn.de>
References: <20071009205755.GB31317@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 23:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMHb-0003kS-O3
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915AbXJIVGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 17:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbXJIVGL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:06:11 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:34464 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbXJIVGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 17:06:09 -0400
Received: from localhost.localdomain (xdsl-87-78-163-242.netcologne.de [87.78.163.242])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 6573C400009E5
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 23:06:08 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IfMGg-0000mz-NK
	for git@vger.kernel.org; Tue, 09 Oct 2007 23:05:30 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071009205755.GB31317@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60441>

em dashes were used inconsistently in the manual.
This changes them to the way they are used in US English.
---
 Documentation/user-manual.txt |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 38e35d8..d99adc6 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2756,7 +2756,7 @@ There are four different types of objects: "blob", "tree", "commit", and
   "blob" objects into a directory structure. In addition, a tree object
   can refer to other tree objects, thus creating a directory hierarchy.
 - A <<def_commit_object,"commit" object>> ties such directory hierarchies
-  together into a <<def_DAG,directed acyclic graph>> of revisions - each
+  together into a <<def_DAG,directed acyclic graph>> of revisions--each
   commit contains the object name of exactly one tree designating the
   directory hierarchy at the time of the commit. In addition, a commit
   refers to "parent" commit objects that describe the history of how we
@@ -3029,7 +3029,7 @@ There are also other situations that cause dangling objects. For
 example, a "dangling blob" may arise because you did a "git add" of a
 file, but then, before you actually committed it and made it part of the
 bigger picture, you changed something else in that file and committed
-that *updated* thing - the old state that you added originally ends up
+that *updated* thing--the old state that you added originally ends up
 not being pointed to by any commit or tree, so it's now a dangling blob
 object.
 
@@ -3044,7 +3044,7 @@ up pointing to them, so they end up "dangling" in your repository.
 Generally, dangling objects aren't anything to worry about. They can
 even be very useful: if you screw something up, the dangling objects can
 be how you recover your old tree (say, you did a rebase, and realized
-that you really didn't want to - you can look at what dangling objects
+that you really didn't want to--you can look at what dangling objects
 you have, and decide to reset your head to some old dangling state).
 
 For commits, you can just use:
@@ -3088,10 +3088,10 @@ $ git prune
 ------------------------------------------------
 
 and they'll be gone. But you should only run "git prune" on a quiescent
-repository - it's kind of like doing a filesystem fsck recovery: you
+repository--it's kind of like doing a filesystem fsck recovery: you
 don't want to do that while the filesystem is mounted.
 
-(The same is true of "git-fsck" itself, btw - but since
+(The same is true of "git-fsck" itself, btw, but since
 git-fsck never actually *changes* the repository, it just reports
 on what it found, git-fsck itself is never "dangerous" to run.
 Running it while somebody is actually changing the repository can cause
@@ -3483,7 +3483,7 @@ You write your current index file to a "tree" object with the program
 $ git write-tree
 -------------------------------------------------
 
-that doesn't come with any options - it will just write out the
+that doesn't come with any options--it will just write out the
 current index into the set of tree objects that describe that state,
 and it will return the name of the resulting top-level tree. You can
 use that tree to re-generate the index at any time by going in the
@@ -3494,7 +3494,7 @@ object database -> index
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 You read a "tree" file from the object database, and use that to
-populate (and overwrite - don't do this if your index contains any
+populate (and overwrite--don't do this if your index contains any
 unsaved state that you might want to restore later!) your current
 index.  Normal operation is just
 
@@ -3542,7 +3542,7 @@ Tying it all together
 
 To commit a tree you have instantiated with "git-write-tree", you'd
 create a "commit" object that refers to that tree and the history
-behind it - most notably the "parent" commits that preceded it in
+behind it--most notably the "parent" commits that preceded it in
 history.
 
 Normally a "commit" has one parent: the previous state of the tree
@@ -3685,7 +3685,7 @@ Once you know the three trees you are going to merge (the one "original"
 tree, aka the common tree, and the two "result" trees, aka the branches
 you want to merge), you do a "merge" read into the index. This will
 complain if it has to throw away your old index contents, so you should
-make sure that you've committed those - in fact you would normally
+make sure that you've committed those--in fact you would normally
 always do a merge against your last commit (which should thus match what
 you have in your current index anyway).
 
@@ -3957,7 +3957,7 @@ Two things are interesting here:
 
 - `get_sha1()` returns 0 on _success_.  This might surprise some new
   Git hackers, but there is a long tradition in UNIX to return different
-  negative numbers in case of different errors -- and 0 on success.
+  negative numbers in case of different errors--and 0 on success.
 
 - the variable `sha1` in the function signature of `get_sha1()` is `unsigned
   char \*`, but is actually expected to be a pointer to `unsigned
-- 
1.5.3.3.g34c6d
