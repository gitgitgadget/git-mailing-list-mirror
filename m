From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] Makes some cleanup/review in gittutorial
Date: Mon, 29 Jun 2009 12:13:58 -0300
Message-ID: <1246288438-29119-1-git-send-email-cascardo@holoscopio.com>
References: <7vprcnccci.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, bfields@citi.umich.edu,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLIYj-00051w-Ko
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 17:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbZF2POI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753059AbZF2POG
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 11:14:06 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:55059 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbZF2POF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 11:14:05 -0400
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id 0D6EF198349;
	Mon, 29 Jun 2009 12:24:22 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id 8A578C580; Mon, 29 Jun 2009 12:14:04 -0300 (BRT)
X-Mailer: git-send-email 1.6.3
In-Reply-To: <7vprcnccci.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122441>

There are some different but little cleanup changes to fix some missing
quotes, to fix what seemed to be an unended sentence, to reident a
little paragraph with too large a sentence and fix a branch name that
was referred to twice later by another name.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
---
 Documentation/gittutorial.txt |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index c7fa949..cf0689c 100644
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
@@ -566,22 +566,22 @@ $ git log v2.5.. Makefile       # commits since v2.5 which modify
 
 You can also give 'git-log' a "range" of commits where the first is not
 necessarily an ancestor of the second; for example, if the tips of
-the branches "stable-release" and "master" diverged from a common
+the branches "stable" and "master" diverged from a common
 commit some time ago, then
 
 -------------------------------------
-$ git log stable..experimental
+$ git log stable..master
 -------------------------------------
 
-will list commits made in the experimental branch but not in the
+will list commits made in the master branch but not in the
 stable branch, while
 
 -------------------------------------
-$ git log experimental..stable
+$ git log master..stable
 -------------------------------------
 
 will show the list of commits made on the stable branch but not
-the experimental branch.
+the master branch.
 
 The 'git-log' command has a weakness: it must present commits in a
 list.  When the history has lines of development that diverged and
-- 
1.6.3
