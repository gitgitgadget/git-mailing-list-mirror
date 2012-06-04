From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/4 v2] api-credentials.txt: mention credential.helper explicitly
Date: Mon,  4 Jun 2012 22:17:43 +0200
Message-ID: <1338841064-32294-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338841064-32294-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 04 22:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbdjU-0007Tu-4B
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455Ab2FDUS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:18:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37781 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab2FDUS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:18:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q54K9PYX003135
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Jun 2012 22:09:25 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sbdj5-0000e4-8O; Mon, 04 Jun 2012 22:18:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sbdj5-0008Q7-70; Mon, 04 Jun 2012 22:18:07 +0200
X-Mailer: git-send-email 1.7.11.rc0.57.g84a04c7
In-Reply-To: <1338841064-32294-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Jun 2012 22:09:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q54K9PYX003135
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1339445366.24751@htO07D8Z1bLkqeDrNDfI5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199181>

The name of the configuration variable was mentioned only at the very
end of the explanation, in a place specific to a specific rule, hence it
was not very clear what the specification was about.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Added "and others" with a link to git-config(1), for completeness.

 Documentation/technical/api-credentials.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
index 2d6e811..969a1ff 100644
--- a/Documentation/technical/api-credentials.txt
+++ b/Documentation/technical/api-credentials.txt
@@ -179,8 +179,10 @@ credentials from and to long-term storage (where "long-term" is simply
 longer than a single git process; e.g., credentials may be stored
 in-memory for a few minutes, or indefinitely on disk).
 
-Each helper is specified by a single string. The string is transformed
-by git into a command to be executed using these rules:
+Each helper is specified by a single string in the configuration
+variable `credential.helper` (and others, see
+linkgit:../git-config[1]). The string is transformed by git into a
+command to be executed using these rules:
 
   1. If the helper string begins with "!", it is considered a shell
      snippet, and everything after the "!" becomes the command.
-- 
1.7.11.rc0.57.g84a04c7
