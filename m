From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document the fact that commit -a is the way to go for simple operations
Date: Sun,  6 May 2007 23:11:54 +0200
Message-ID: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 23:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hko1X-0007yg-35
	for gcvg-git@gmane.org; Sun, 06 May 2007 23:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbXEFVMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758899AbXEFVMB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 17:12:01 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34125 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758894AbXEFVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 17:11:59 -0400
Received: from localhost (mut38-2-82-224-179-211.fbx.proxad.net [82.224.179.211])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5D2F0B93AC;
	Sun,  6 May 2007 23:11:58 +0200 (CEST)
Received: from moy by localhost with local (Exim 4.67)
	(envelope-from <moy@imag.fr>)
	id 1Hko1N-0004Sz-PM; Sun, 06 May 2007 23:11:57 +0200
X-Mailer: git-send-email 1.5.2.rc2.2.g6cfa-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46376>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-commit.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 2895225..d024c03 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -54,7 +54,8 @@ OPTIONS
 -a|--all::
 	Tell the command to automatically stage files that have
 	been modified and deleted, but new files you have not
-	told git about are not affected.
+	told git about are not affected.  You should use it for most
+        trivial operations.
 
 -c or -C <commit>::
 	Take existing commit object, and reuse the log message
-- 
1.5.1.3
