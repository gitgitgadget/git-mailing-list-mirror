From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: [PATCH] documentation: update cvsimport description of "-r" for recent clone
Date: Thu, 26 Mar 2009 00:08:09 -0700
Message-ID: <1238051289-7342-1-git-send-email-carenas@sajinet.com.pe>
Cc: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 08:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjtH-0007Og-Kg
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 08:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbZCZHTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 03:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbZCZHTI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 03:19:08 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:34172 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbZCZHTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 03:19:07 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2009 03:19:07 EDT
Received: by sajino.sajinet.com.pe (Postfix, from userid 65534)
	id 702E4A580F7; Thu, 26 Mar 2009 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (dsl081-071-036.sfo1.dsl.speakeasy.net [64.81.71.36])
	by sajino.sajinet.com.pe (Postfix) with ESMTP id 0A9FFA58037;
	Thu, 26 Mar 2009 07:08:09 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114745>

the "--use-separate-remote" option no longer exists, having since
become the default for a clone.

Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
---
 Documentation/git-cvsimport.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 3123725..e1fd047 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -65,7 +65,7 @@ OPTIONS
 -r <remote>::
 	The git remote to import this CVS repository into.
 	Moves all CVS branches into remotes/<remote>/<branch>
-	akin to the 'git-clone' "--use-separate-remote" option.
+	akin to the way 'git-clone' uses 'origin' by default.
 
 -o <branch-for-HEAD>::
 	When no remote is specified (via -r) the 'HEAD' branch
-- 
1.6.0.6
