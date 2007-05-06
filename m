From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document "commit --only".
Date: Sun,  6 May 2007 23:11:57 +0200
Message-ID: <11784859184184-git-send-email-Matthieu.Moy@imag.fr>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
 <11784859173725-git-send-email-Matthieu.Moy@imag.fr>
 <11784859182473-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 23:12:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hko1X-0007yg-JO
	for gcvg-git@gmane.org; Sun, 06 May 2007 23:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbXEFVMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758909AbXEFVMD
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 17:12:03 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34131 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758893AbXEFVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 17:11:59 -0400
Received: from localhost (mut38-2-82-224-179-211.fbx.proxad.net [82.224.179.211])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B00D8B92E0;
	Sun,  6 May 2007 23:11:58 +0200 (CEST)
Received: from moy by localhost with local (Exim 4.67)
	(envelope-from <moy@imag.fr>)
	id 1Hko1O-0004T5-A0; Sun, 06 May 2007 23:11:58 +0200
X-Mailer: git-send-email 1.5.2.rc2.2.g6cfa-dirty
In-Reply-To: <11784859182473-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46377>

The documentation was there earlier, but removed by
4170a19587280eeb3663a47a6fd993910de78076.

That option being the default now, it could perhaps be actually
removed, but since it is there, and mentionned in the SYNOPSIS, it
should be actually documented.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-commit.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d024c03..0bdf794 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -116,6 +116,11 @@ but can be used to amend a merge commit.
 	as well.  This is usually not what you want unless you
 	are concluding a conflicted merge.
 
+-o|--only::
+	Commit only the files specified on the command line.
+	This format cannot be used during a merge. This is the
+	default.
+
 -q|--quiet::
 	Suppress commit summary message.
 
-- 
1.5.1.3
