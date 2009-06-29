From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 1/2] Makes some cleanup/review in gittutorial
Date: Mon, 29 Jun 2009 11:05:19 -0300
Message-ID: <1246284319-26451-1-git-send-email-cascardo@holoscopio.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@minaslivre.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 16:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLHdJ-0004Mx-CU
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 16:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759051AbZF2OOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbZF2OOl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 10:14:41 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:37181 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759569AbZF2OOj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 10:14:39 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2009 10:14:39 EDT
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id 80FB7198349;
	Mon, 29 Jun 2009 11:15:37 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id 9AF0BC580; Mon, 29 Jun 2009 11:05:20 -0300 (BRT)
X-Mailer: git-send-email 1.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122439>

From: Thadeu Lima de Souza Cascardo <cascardo@minaslivre.org>

There are some different but little cleanup changes to fix some missing
quotes, to fix what seemed to be an unended sentence, to reident a
little paragraph with too large a sentence and fix a branch name that
was referred to twice later by another name.
---
 Documentation/gittutorial.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index c7fa949..f8b5830 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -332,11 +332,11 @@ alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------
 
 This operation is safe even if Alice has uncommitted local changes.
-The range notation HEAD..FETCH_HEAD" means "show everything that is reachable
-from the FETCH_HEAD but exclude anything that is reachable from HEAD.
+The range notation "HEAD..FETCH_HEAD" means "show everything that is reachable
+from the FETCH_HEAD but exclude anything that is reachable from HEAD".
 Alice already knows everything that leads to her current state (HEAD),
-and reviewing what Bob has in his state (FETCH_HEAD) that she has not
-seen with this command
+and reviews what Bob has in his state (FETCH_HEAD) that she has not
+seen with this command.
 
 If Alice wants to visualize what Bob did since their histories forked
 she can issue the following command:
@@ -375,9 +375,9 @@ it easier:
 alice$ git remote add bob /home/bob/myrepo
 ------------------------------------------------
 
-With this, Alice can perform the first part of the "pull" operation alone using the
-'git-fetch' command without merging them with her own branch,
-using:
+With this, Alice can perform the first part of the "pull" operation
+alone using the 'git-fetch' command without merging them with her own
+branch, using:
 
 -------------------------------------
 alice$ git fetch bob
@@ -566,7 +566,7 @@ $ git log v2.5.. Makefile       # commits since v2.5 which modify
 
 You can also give 'git-log' a "range" of commits where the first is not
 necessarily an ancestor of the second; for example, if the tips of
-the branches "stable-release" and "master" diverged from a common
+the branches "stable" and "master" diverged from a common
 commit some time ago, then
 
 -------------------------------------
-- 
1.6.3
