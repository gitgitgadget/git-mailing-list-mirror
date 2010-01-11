From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] push: spell 'Note about fast-forwards' section name correctly in error message.
Date: Mon, 11 Jan 2010 22:09:44 +0100
Message-ID: <1263244184-30810-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 22:09:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NURWQ-0003KF-18
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 22:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab0AKVJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 16:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010Ab0AKVJy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 16:09:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36625 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885Ab0AKVJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 16:09:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0BL9Ucu029095
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jan 2010 22:09:30 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NURWE-0007gL-Dp; Mon, 11 Jan 2010 22:09:46 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NURWE-00081V-Ai; Mon, 11 Jan 2010 22:09:46 +0100
X-Mailer: git-send-email 1.6.6.198.gbaea2
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jan 2010 22:09:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0BL9Ucu029095
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1263848971.44562@Jp+Ylpuu7sAwbwxwZItQog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136666>

The error message in case of non-fast forward points to 'git push
--help', but used to talk about a section 'non-fast-forward', while the
actual section name is 'Note about fast-forwards'.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
My bad, I'm the original author of the patch introducing this ;-).

 builtin-push.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index f7661d2..28a26e7 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -125,8 +125,8 @@ static int push_with_options(struct transport *transport, int flags)
 
 	if (nonfastforward && advice_push_nonfastforward) {
 		printf("To prevent you from losing history, non-fast-forward updates were rejected\n"
-		       "Merge the remote changes before pushing again.  See the 'non-fast-forward'\n"
-		       "section of 'git push --help' for details.\n");
+		       "Merge the remote changes before pushing again.  See the 'Note about\n"
+		       "fast-forwards' section of 'git push --help' for details.\n");
 	}
 
 	return 1;
-- 
1.6.6.198.gbaea2
