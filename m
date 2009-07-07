From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] git-svn.txt: fix description of fetch flags accepted by clone.
Date: Tue,  7 Jul 2009 22:22:22 +0200
Message-ID: <e8ba63a3c233549955f6558c4b6b06aded54fd11.1246997775.git.ydirson@altern.org>
References: <cover.1246997775.git.ydirson@altern.org>
 <ffe5b8e8cf2cb889cdcc04850cf867b46df9ced9.1246997775.git.ydirson@altern.org>
 <4d918af1f5122cc5b71142cd50b7d5699a2a912d.1246997775.git.ydirson@altern.org>
 <a427e73e459e18d9e28701a97eca338934d74300.1246997775.git.ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 22:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOHBQ-0002yV-UK
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 22:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbZGGUWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 16:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757416AbZGGUWK
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 16:22:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:42601 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756467AbZGGUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 16:22:09 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 8DDC19401D5;
	Tue,  7 Jul 2009 22:22:01 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id A0CA69401C3;
	Tue,  7 Jul 2009 22:21:59 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 84F1C1F0E3; Tue,  7 Jul 2009 22:22:24 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <a427e73e459e18d9e28701a97eca338934d74300.1246997775.git.ydirson@altern.org>
In-Reply-To: <cover.1246997775.git.ydirson@altern.org>
References: <cover.1246997775.git.ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122870>

Signed-off-by: Yann Dirson <ydirson@altern.org>
Acked-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1e8242b..10af599 100644
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
