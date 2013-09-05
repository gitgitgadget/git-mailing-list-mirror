From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 1/5] builtin/stripspace.c: fix broken indentation
Date: Thu,  5 Sep 2013 11:50:14 +0200
Message-ID: <1378374618-31439-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 05 11:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHWDL-0006o4-4d
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 11:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195Ab3IEJur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 05:50:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35592 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965148Ab3IEJuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 05:50:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r859oKu8006911
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Sep 2013 11:50:20 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VHWCj-0006Vv-V4; Thu, 05 Sep 2013 11:50:21 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VHWCj-0008CF-LW; Thu, 05 Sep 2013 11:50:21 +0200
X-Mailer: git-send-email 1.8.4.4.g70bf5e8.dirty
In-Reply-To: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Sep 2013 11:50:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r859oKu8006911
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378979422.44663@KIKFS3vjDt3BtuKq2bG1lQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233950>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.8.4.4.g70bf5e8.dirty
