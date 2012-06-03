From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/3] api-credentials.txt: mention credential.helper explicitly
Date: Sun,  3 Jun 2012 18:10:03 +0200
Message-ID: <1338739804-32167-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 03 18:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbDOd-0004HH-NR
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 18:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab2FCQK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jun 2012 12:10:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37477 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab2FCQKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2012 12:10:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q53G1i3R009672
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jun 2012 18:01:44 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNe-0000Cg-Dv; Sun, 03 Jun 2012 18:10:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SbDNe-0008Nj-Cp; Sun, 03 Jun 2012 18:10:14 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jun 2012 18:01:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q53G1i3R009672
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339344105.22234@JPd3/fq1GPIYJN4/FxBA3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199090>

The name of the configuration variable was mentioned only at the very
end of the explanation, in a place specific to a specific rule, hence it
was not very clear what the specification was about.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/technical/api-credentials.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 8804c42..4561469 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -179,7 +179,8 @@ credentials from and to long-term storage (where "long-term" is simply
 longer than a single git process; e.g., credentials may be stored
 in-memory for a few minutes, or indefinitely on disk).
 
-Each helper is specified by a single string. The string is transformed
+Each helper is specified by a single string in the configuration
+variable credential.helper. The string is transformed
 by git into a command to be executed using these rules:
 
   1. If the helper string begins with "!", it is considered a shell
-- 
1.7.11.rc0.57.g84a04c7
