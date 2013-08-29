From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 1/4] builtin/stripspace.c: fix broken indentation
Date: Thu, 29 Aug 2013 15:05:33 +0200
Message-ID: <1377781536-31955-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 15:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1x0-0005xP-3K
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 15:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab3H2NHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 09:07:36 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59327 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272Ab3H2NHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 09:07:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TD5jH4019319
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 15:05:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VF1v1-0008H5-5F; Thu, 29 Aug 2013 15:05:47 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VF1v0-0008KV-Rh; Thu, 29 Aug 2013 15:05:46 +0200
X-Mailer: git-send-email 1.8.4.12.gf9d53a3.dirty
In-Reply-To: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 15:05:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TD5jH4019319
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378386349.50352@B4m8C3wvbqpvklqj658JNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233253>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/stripspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index e981dfb..1259ed7 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -89,11 +89,11 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 
 	if (argc == 2) {
 		if (!strcmp(argv[1], "-s") ||
-			!strcmp(argv[1], "--strip-comments")) {
-			 strip_comments = 1;
+		    !strcmp(argv[1], "--strip-comments")) {
+			strip_comments = 1;
 		} else if (!strcmp(argv[1], "-c") ||
-					 !strcmp(argv[1], "--comment-lines")) {
-			 mode = COMMENT_LINES;
+			   !strcmp(argv[1], "--comment-lines")) {
+			mode = COMMENT_LINES;
 		} else {
 			mode = INVAL;
 		}
-- 
1.8.4.12.gf9d53a3.dirty
