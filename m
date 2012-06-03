From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Sun,  3 Jun 2012 18:10:04 +0200
Message-ID: <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 03 18:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbDOR-0003uH-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 18:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab2FCQK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 12:10:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37484 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369Ab2FCQKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 12:10:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q53G1kKO009681
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 18:01:46 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNf-0000Cr-Ub; Sun, 03 Jun 2012 18:10:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNf-0008Nm-TO; Sun, 03 Jun 2012 18:10:15 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jun 2012 18:01:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53G1kKO009681
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339344106.3874@umF4Feyb7Sgtq4QMnwV1UA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199089>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/technical/api-credentials.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 4561469..ac6be31 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -288,3 +288,10 @@ request.
 If a helper receives any other operation, it should silently ignore the
 request. This leaves room for future operations to be added (older
 helpers will just ignore the new requests).
+
+See also
+--------
+
+linkgit:../gitcredentials[7]
+
+linkgit:../git-config[5] (See configuration variables `credential.*`)
-- 
1.7.11.rc0.57.g84a04c7
