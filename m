From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] api-credential.txt: document that helpers field is filled-in automatically
Date: Mon, 11 Jun 2012 12:46:14 +0200
Message-ID: <1339411574-22998-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 11 12:48:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se28z-0001x5-JA
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 12:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab2FKKqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 06:46:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60019 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652Ab2FKKqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 06:46:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5BAbKZP023921
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 12:37:20 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Se28e-0008RS-7H; Mon, 11 Jun 2012 12:46:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Se28e-0005zb-2M; Mon, 11 Jun 2012 12:46:24 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 11 Jun 2012 12:37:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BAbKZP023921
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1340015843.0972@KQb+qHqXiS2uMtyVLM2rlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199641>

It was unclear whether the field was to be specified by the user of the
API.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

A quick grep in Git's source code seems to show that no user of the
API explicitely modify this "helpers" field (except test-credential.c).

 Documentation/technical/api-credentials.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 21ca6a2..fc6d2b9 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -46,7 +46,9 @@ Functions
 	consulting helpers, then asking the user. After this function
 	returns, the username and password fields of the credential are
 	guaranteed to be non-NULL. If an error occurs, the function will
-	die().
+	die(). The `helpers` member of the structure is filled-in
+	according to the corresponding configuration variables before
+	consulting helpers.
 
 `credential_reject`::
 
-- 
1.7.11.rc0.57.g84a04c7
