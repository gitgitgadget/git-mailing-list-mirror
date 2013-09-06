From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v5 1/6] builtin/stripspace.c: fix broken indentation
Date: Fri,  6 Sep 2013 19:43:04 +0200
Message-ID: <1378489389-25802-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq38phsvuc.fsf@anie.imag.frvpq38phsvuc.fsf@anie.imag.fr>
 <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 19:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI04A-00010r-51
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab3IFRn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:43:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54066 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab3IFRnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:43:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r86HhIo9014266
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:43:18 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VI040-0000b4-UD; Fri, 06 Sep 2013 19:43:20 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VI040-0006jG-Jf; Fri, 06 Sep 2013 19:43:20 +0200
X-Mailer: git-send-email 1.8.4.5.g8688bea
In-Reply-To: <1378489389-25802-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Sep 2013 19:43:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HhIo9014266
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1379094199.24346@2dVcZQ8CBuc+I9Q1sh89bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234070>

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
1.8.4.5.g8688bea
