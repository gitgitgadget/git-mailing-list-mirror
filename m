From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Wed,  3 Apr 2013 15:07:21 +0200
Message-ID: <1364994441-15961-1-git-send-email-cmn@elego.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 03 15:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNNYX-0005Nb-Fg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 15:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760779Ab3DCNQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 09:16:21 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:39367 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1760268Ab3DCNQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 09:16:20 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2013 09:16:20 EDT
Received: from cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id A971481E56
	for <git@vger.kernel.org>; Wed,  3 Apr 2013 15:07:22 +0200 (CEST)
Received: (nullmailer pid 15997 invoked by uid 1000);
	Wed, 03 Apr 2013 13:07:21 -0000
X-Mailer: git-send-email 1.8.2.524.g8f8def7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219934>

The explanation for 'git commit --amend' talks about preparing a tree
object, which shouldn't be how user-facing documentation talks about
commit.

Reword it to say it works as usual, but replaces the current commit.
---

The current text is from 2006, which I guess explains the wording.

 Documentation/git-commit.txt | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 42c22bb..48dac29 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -198,14 +198,11 @@ OPTIONS
 	without changing its commit message.
 
 --amend::
-	Used to amend the tip of the current branch. Prepare the tree
-	object you would want to replace the latest commit as usual
-	(this includes the usual -i/-o and explicit paths), and the
-	commit log editor is seeded with the commit message from the
-	tip of the current branch. The commit you create replaces the
-	current tip -- if it was a merge, it will have the parents of
-	the current tip as parents -- so the current top commit is
-	discarded.
+	Amend the tip of the current branch. The commit is prepared as
+	usual (including -i/-o and explicit paths) and the editor
+	starts off with the current tip's commit message. The new
+	commit has the same parents and author as the current one and
+	replaces it as the tip.
 +
 --
 It is a rough equivalent for:
-- 
1.8.2.524.g8f8def7
