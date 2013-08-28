From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH v2 1/3] builtin/stripspace.c: fix broken indentation
Date: Wed, 28 Aug 2013 14:47:02 +0200
Message-ID: <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
Cc: j.sixt@viscovery.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 14:48:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEfAH-000485-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 14:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab3H1Mr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 08:47:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44249 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243Ab3H1Mr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 08:47:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7SClsMN008735
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 14:47:54 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VEfAB-0006K6-Ob; Wed, 28 Aug 2013 14:47:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VEfAB-0006J1-Em; Wed, 28 Aug 2013 14:47:55 +0200
X-Mailer: git-send-email 1.8.4.11.g9db5bc7.dirty
In-Reply-To: <vpqhaeaasuf.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Aug 2013 14:47:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SClsMN008735
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378298874.82773@y4lU/y47DQEOP29WhN4dgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233185>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
I normally don't like whitespace-only patches, but the indentation was
seriously broken here.

Can safely be dropped.

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
1.8.4.11.g9db5bc7.dirty
