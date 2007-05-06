From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Added a reference to git-add in the documentation for git-update-index
Date: Sun,  6 May 2007 23:11:56 +0200
Message-ID: <11784859182473-git-send-email-Matthieu.Moy@imag.fr>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
 <11784859173725-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 23:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hko1p-00081T-TD
	for gcvg-git@gmane.org; Sun, 06 May 2007 23:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912AbXEFVMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 17:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758893AbXEFVMH
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 17:12:07 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34133 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758897AbXEFVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 17:11:59 -0400
Received: from localhost (mut38-2-82-224-179-211.fbx.proxad.net [82.224.179.211])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1FE0DB93F3;
	Sun,  6 May 2007 23:11:58 +0200 (CEST)
Received: from moy by localhost with local (Exim 4.67)
	(envelope-from <moy@imag.fr>)
	id 1Hko1O-0004T3-7V; Sun, 06 May 2007 23:11:58 +0200
X-Mailer: git-send-email 1.5.2.rc2.2.g6cfa-dirty
In-Reply-To: <11784859173725-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46378>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-update-index.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index cd5e014..6cfbd9a 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -27,6 +27,9 @@ Modifies the index or directory cache. Each file mentioned is updated
 into the index and any 'unmerged' or 'needs updating' state is
 cleared.
 
+See also gitlink:git-add[1] for a more user-friendly way to do some of
+the most common operations on the index.
+
 The way "git-update-index" handles files it is told about can be modified
 using the various options:
 
@@ -306,7 +309,8 @@ The command looks at `core.ignorestat` configuration variable.  See
 
 See Also
 --------
-gitlink:git-config[1]
+gitlink:git-config[1],
+gitlink:git-add[1]
 
 
 Author
-- 
1.5.1.3
