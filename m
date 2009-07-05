From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] git-svn.txt: fix description of fetch flags accepted by clone.
Date: Mon,  6 Jul 2009 00:03:17 +0200
Message-ID: <1246831397-19489-5-git-send-email-ydirson@altern.org>
References: <1246831397-19489-1-git-send-email-ydirson@altern.org>
 <1246831397-19489-2-git-send-email-ydirson@altern.org>
 <1246831397-19489-3-git-send-email-ydirson@altern.org>
 <1246831397-19489-4-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 00:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNa3p-00051A-Gi
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 00:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbZGEWTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 18:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756189AbZGEWTb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 18:19:31 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58040 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547AbZGEWTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 18:19:30 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D8D6C94008D;
	Mon,  6 Jul 2009 00:19:27 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id ED73A9400E5;
	Mon,  6 Jul 2009 00:19:24 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8533AA008; Mon,  6 Jul 2009 00:03:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1246831397-19489-4-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122762>


Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/git-svn.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 03bc1c1..1e56466 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -147,10 +147,10 @@ Skip "branches" and "tags" of first level directories;;
 	or if a second argument is passed; it will create a directory
 	and work within that.  It accepts all arguments that the
 	'init' and 'fetch' commands accept; with the exception of
-	'--fetch-all'.   After a repository is cloned, the 'fetch'
-	command will be able to update revisions without affecting
-	the working tree; and the 'rebase' command will be able
-	to update the working tree with the latest changes.
+	'--fetch-all' and '--parent'.  After a repository is cloned,
+	the 'fetch' command will be able to update revisions without
+	affecting the working tree; and the 'rebase' command will be
+	able to update the working tree with the latest changes.
 
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
-- 
1.6.3.3
