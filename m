From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] t0003: add missing && at end of lines
Date: Sat, 28 Aug 2010 20:18:36 +0200
Message-ID: <1283019516-24135-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 28 20:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpPzc-0003VI-Lk
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 20:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab0H1SS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 14:18:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57941 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753095Ab0H1SS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 14:18:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7SIFI69015690
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 28 Aug 2010 20:15:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OpPzE-000848-3w; Sat, 28 Aug 2010 20:18:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OpPzE-0006Hu-0y; Sat, 28 Aug 2010 20:18:40 +0200
X-Mailer: git-send-email 1.7.2.2.175.ga619d.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 28 Aug 2010 20:15:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7SIFI69015690
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1283624124.55246@CX7BmyKBspi5f5ycQXnK2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154654>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Trivial fix fond while testing the core.attributesfile patch.

 t/t0003-attributes.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 53bd7fc..de38c7f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -48,11 +48,11 @@ test_expect_success 'attribute test' '
 	attr_check a/b/g a/b/g &&
 	attr_check b/g unspecified &&
 	attr_check a/b/h a/b/h &&
-	attr_check a/b/d/g "a/b/d/*"
-	attr_check onoff unset
-	attr_check offon set
-	attr_check no unspecified
-	attr_check a/b/d/no "a/b/d/*"
+	attr_check a/b/d/g "a/b/d/*" &&
+	attr_check onoff unset &&
+	attr_check offon set &&
+	attr_check no unspecified &&
+	attr_check a/b/d/no "a/b/d/*" &&
 	attr_check a/b/d/yes unspecified
 
 '
-- 
1.7.2.2.175.ga619d.dirty
