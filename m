From: Michael Coleman <tutufan@gmail.com>
Subject: [PATCH] Fix minor typos/grammar in user-manual.txt
Date: Tue, 27 Feb 2007 22:13:09 -0600
Message-ID: <1172635989747-git-send-email-tutufan@gmail.com>
Cc: Michael Coleman <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 05:13:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGBq-0001jt-8l
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXB1ENP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXB1ENP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:13:15 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:53486 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbXB1ENO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:13:14 -0500
Received: by nz-out-0506.google.com with SMTP id s1so24652nze
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 20:13:13 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=TonC0mdPox9iZ90zQ3p6NBsGrqKfESSRQk/nr4O5DToZPFzT/ttAkRt1jtzzjkSJy/I1qM7nAp2ArxK8M96w1mfRM1hFinSpWxsNywvqzT2VLWQ5ysRurjFU2E5x6MdyFycOtt3g3icTg9IEe4Rc0gPhqAw5Iyz0iWHlJI0wZY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=Jved+cQRqB6weeywzifo1J/rfDe/RQf4zqxnsbxNiPwigPNVfqzHG41v4qJS8jwp71xUzXaPc7/B9U2+GnLr41xwxepDCATeuBL3drZ5t+1bFIzHHLNi81BpNGi3CpH+ibsYUXpqtL2aU/RqgmxiTejf0UIf14yn5TqAiPKCxo0=
Received: by 10.35.32.9 with SMTP id k9mr53910pyj.1172635993353;
        Tue, 27 Feb 2007 20:13:13 -0800 (PST)
Received: from tutufan@gmail.com ( [69.154.17.234])
        by mx.google.com with ESMTP id n80sm123182pyh.2007.02.27.20.13.10;
        Tue, 27 Feb 2007 20:13:12 -0800 (PST)
Received: by tutufan@gmail.com (sSMTP sendmail emulation); Tue, 27 Feb 2007 22:13:09 -0600
X-Mailer: git-send-email 1.5.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40890>

---
 Documentation/user-manual.txt |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 03736bb..34e9651 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2,7 +2,7 @@ Git User's Manual
 _________________
 
 This manual is designed to be readable by someone with basic unix
-commandline skills, but no previous knowledge of git.
+command-line skills, but no previous knowledge of git.
 
 Chapter 1 gives a brief overview of git commands, without any
 explanation; you may prefer to skip to chapter 2 on a first reading.
@@ -1196,7 +1196,7 @@ will be HEAD, the tip of the current branch; the other will be the
 tip of the other branch, which is stored temporarily in MERGE_HEAD.
 
 The diff above shows the differences between the working-tree version
-of file.txt and two previous version: one version from HEAD, and one
+of file.txt and two previous versions: one version from HEAD, and one
 from MERGE_HEAD.  So instead of preceding each line by a single "+"
 or "-", it now uses two columns: the first column is used for
 differences between the first parent and the working directory copy,
@@ -1479,7 +1479,7 @@ Examining dangling objects
 
 In some situations the reflog may not be able to save you.  For
 example, suppose you delete a branch, then realize you need the history
-it pointed you.  The reflog is also deleted; however, if you have not
+it contained.  The reflog is also deleted; however, if you have not
 yet pruned the repository, then you may still be able to find
 the lost commits; run git-fsck and watch for output that mentions
 "dangling commits":
@@ -1505,7 +1505,7 @@ history that is described by all your existing branches and tags.  Thus
 you get exactly the history reachable from that commit that is lost.
 (And notice that it might not be just one commit: we only report the
 "tip of the line" as being dangling, but there might be a whole deep
-and complex commit history that was gotten dropped.)
+and complex commit history that was dropped.)
 
 If you decide you want the history back, you can always create a new
 reference pointing to it, for example, a new branch:
@@ -1561,7 +1561,7 @@ repository that you pulled from.
 
 (But note that no such commit will be created in the case of a
 <<fast-forwards,fast forward>>; instead, your branch will just be
-updated to point to the latest commit from the upstream branch).
+updated to point to the latest commit from the upstream branch.)
 
 The git-pull command can also be given "." as the "remote" repository,
 in which case it just merges in a branch from the current repository; so
@@ -1638,8 +1638,8 @@ updates with git pull>>".
 
 If you and maintainer both have accounts on the same machine, then
 then you can just pull changes from each other's repositories
-directly; note that all of the command (gitlink:git-clone[1],
-git-fetch[1], git-pull[1], etc.) which accept a URL as an argument
+directly; note that all of the commands (gitlink:git-clone[1],
+git-fetch[1], git-pull[1], etc.) that accept a URL as an argument
 will also accept a local file patch; so, for example, you can
 use
 
@@ -1832,7 +1832,7 @@ that makes it easy for them to read your changes, verify that they are
 correct, and understand why you made each change.
 
 If you present all of your changes as a single patch (or commit), they
-may find it is too much to digest all at once.
+may find that it is too much to digest all at once.
 
 If you present them with the entire history of your work, complete with
 mistakes, corrections, and dead ends, they may be overwhelmed.
@@ -1858,11 +1858,8 @@ you are rewriting history.
 Keeping a patch series up to date using git-rebase
 --------------------------------------------------
 
-Suppose you have a series of commits in a branch "mywork", which
-originally branched off from "origin".
-
-Suppose you create a branch "mywork" on a remote-tracking branch
-"origin", and created some commits on top of it:
+Suppose that you create a branch "mywork" on a remote-tracking branch
+"origin", and create some commits on top of it:
 
 -------------------------------------------------
 $ git checkout -b mywork origin
@@ -1966,7 +1963,7 @@ Other tools
 -----------
 
 There are numerous other tools, such as stgit, which exist for the
-purpose of maintaining a patch series.  These are out of the scope of
+purpose of maintaining a patch series.  These are outside of the scope of
 this manual.
 
 Problems with rewriting history
@@ -2088,7 +2085,7 @@ descendant of the old head, you may force the update with:
 $ git fetch git://example.com/proj.git +master:refs/remotes/example/master
 -------------------------------------------------
 
-Note the addition of the "+" sign.  Be aware that commits which the
+Note the addition of the "+" sign.  Be aware that commits that the
 old version of example/master pointed at may be lost, as we saw in
 the previous section.
 
@@ -2096,7 +2093,7 @@ Configuring remote branches
 ---------------------------
 
 We saw above that "origin" is just a shortcut to refer to the
-repository which you originally cloned from.  This information is
+repository that you originally cloned from.  This information is
 stored in git configuration variables, which you can see using
 gitlink:git-config[1]:
 
@@ -2407,7 +2404,7 @@ conflicts between different tree objects, allowing each pathname to be
 associated with sufficient information about the trees involved that
 you can create a three-way merge between them.'
 
-Those are the three ONLY things that the directory cache does.  It's a
+Those are the ONLY three things that the directory cache does.  It's a
 cache, and the normal operation is to re-generate it completely from a
 known tree object, or update/compare it with a live tree that is being
 developed.  If you blow the directory cache away entirely, you generally
-- 
1.5.0.rc3
