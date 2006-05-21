From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: (unknown)
Date: Sun, 21 May 2006 19:53:18 -0400
Message-ID: <1148255528.61d5d241.0@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 01:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhxjo-0008W6-JZ
	for gcvg-git@gmane.org; Mon, 22 May 2006 01:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWEUXxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 19:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWEUXxa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 19:53:30 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33457 "EHLO
	puzzle.fieldses.org") by vger.kernel.org with ESMTP id S964950AbWEUXx3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 19:53:29 -0400
Received: from bfields by puzzle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fhxja-000667-Nf; Sun, 21 May 2006 19:53:18 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20466>

>From nobody Mon Sep 17 00:00:00 2001
From: J. Bruce Fields <bfields@citi.umich.edu>
Date: Sun, 21 May 2006 16:52:34 -0400
Subject: [PATCH 1/3] tutorial: replace "whatchanged" by "log"

Junio suggested changing references to git-whatchanged to git-log.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

d1177b299b449e9eb63d963ee118a5e0283aa611
 Documentation/tutorial.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

d1177b299b449e9eb63d963ee118a5e0283aa611
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index fa79b01..cd0f0df 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -80,13 +80,13 @@ file; just remove it, then commit.
 At any point you can view the history of your changes using
 
 ------------------------------------------------
-$ git whatchanged
+$ git log
 ------------------------------------------------
 
 If you also want to see complete diffs at each step, use
 
 ------------------------------------------------
-$ git whatchanged -p
+$ git log -p
 ------------------------------------------------
 
 Managing branches
@@ -216,7 +216,7 @@ This actually pulls changes from the bra
 "master".  Alice could request a different branch by adding the name
 of the branch to the end of the git pull command line.
 
-This merges Bob's changes into her repository; "git whatchanged" will
+This merges Bob's changes into her repository; "git log" will
 now show the new commits.  If Alice has made her own changes in the
 meantime, then Bob's changes will be merged in, and she will need to
 manually fix any conflicts.
@@ -234,7 +234,7 @@ named bob-incoming.  (Unlike git pull, g
 of Bob's line of development without doing any merging).  Then
 
 -------------------------------------
-$ git whatchanged -p master..bob-incoming
+$ git log -p master..bob-incoming
 -------------------------------------
 
 shows a list of all the changes that Bob made since he branched from
@@ -330,13 +330,13 @@ But you may find it more useful to see t
 the experimental branch but not in the current branch, and
 
 -------------------------------------
-git whatchanged HEAD..experimental
+git log HEAD..experimental
 -------------------------------------
 
 will do that, just as
 
 -------------------------------------
-git whatchanged experimental..HEAD
+git log experimental..HEAD
 -------------------------------------
 
 will show the list of commits made on the HEAD but not included in
-- 
1.3.3.gff62
