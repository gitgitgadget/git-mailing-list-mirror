From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/fast-import: clarify summary for `feature` command
Date: Fri, 23 Aug 2013 10:29:20 +0200
Message-ID: <1377246560-19847-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 23 10:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCmkZ-00026w-2K
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 10:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746Ab3HWI3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 04:29:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53832 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab3HWI3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 04:29:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7N8TL78004636
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 23 Aug 2013 10:29:23 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VCmkE-0005h0-BB; Fri, 23 Aug 2013 10:29:22 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VCmkE-0005Ay-1D; Fri, 23 Aug 2013 10:29:22 +0200
X-Mailer: git-send-email 1.8.4.rc4.4.g57d5d3d
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 23 Aug 2013 10:29:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7N8TL78004636
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1377851367.88983@gg2Bj7uIob/Xmn45pbqxAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232803>

In most cases, "feature <foo>" does not just require that the feature
exists, but also changes the behavior to enable it.

Cases where the feature is only requested like cat-blob, notes or ls are
clearly documented below.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-fast-import.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index bf1a02a..4a9cc74 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -361,8 +361,8 @@ and control the current import process.  More detailed discussion
 	`--cat-blob-fd` or `stdout` if unspecified.
 
 `feature`::
-	Require that fast-import supports the specified feature, or
-	abort if it does not.
+	Enable the specified feature. This requires that fast-import
+	supports the specified feature, and aborts if it does not.
 
 `option`::
 	Specify any of the options listed under OPTIONS that do not
-- 
1.8.4.rc4.4.g57d5d3d
