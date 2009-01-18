From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 1/4] Documentation: git push repository can also be a remote
Date: Sun, 18 Jan 2009 15:36:55 +0100
Message-ID: <1232289418-25627-2-git-send-email-mail@cup.kalibalik.dk>
References: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 18 15:38:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYnT-0002Y3-4m
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761990AbZAROhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761139AbZAROhG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:37:06 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:46796 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757523AbZAROhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:37:01 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 690A630B2B;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 3EF7430881;
	Sun, 18 Jan 2009 15:36:23 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232289418-25627-1-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106193>

This is copied from pull-fetch-param.txt and helps the reader
to not get stuck in the URL section.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3321966..8bfa7cb 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -28,7 +28,9 @@ OPTIONS
 -------
 <repository>::
 	The "remote" repository that is destination of a push
-	operation.  See the section <<URLS,GIT URLS>> below.
+	operation.  This parameter can be either a URL
+	(see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>...::
 	The canonical format of a <refspec> parameter is
-- 
1.6.0.2.514.g23abd3
