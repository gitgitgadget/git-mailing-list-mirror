From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 02/16] contrib/git-credential-gnome-keyring.c: remove unused die() function
Date: Mon, 23 Sep 2013 11:49:03 -0700
Message-ID: <1379962157-1338-3-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCc-0007aR-AG
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab3IWSt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9052 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab3IWStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:25 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B52408d1f0001>; Mon, 23 Sep 2013 11:49:03 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:49:24 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 23 Sep 2013 11:49:24 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:24 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235218>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../credential/gnome-keyring/git-credential-gnome-keyring.c    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 15b0a1c..4334f23 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -91,16 +91,6 @@ static inline void error(const char *fmt, ...)
 	va_end(ap);
 }
 
-static inline void die(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap,fmt);
-	error(fmt, ap);
-	va_end(ap);
-	exit(EXIT_FAILURE);
-}
-
 static inline void die_errno(int err)
 {
 	error("%s", strerror(err));
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
