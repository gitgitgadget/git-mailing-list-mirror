From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/2] Documentation/git-am.txt: mention mailinfo.scissors config variable
Date: Fri, 20 Feb 2015 11:29:03 +0100
Message-ID: <1424428143-641-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1424426947-26441-1-git-send-email-Matthieu.Moy@imag.fr>
 <1424428143-641-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 11:29:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkpl-0001mf-QM
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbbBTK3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:29:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47903 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbbBTK3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:29:18 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAT90A017042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:29:09 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KATBgF031670;
	Fri, 20 Feb 2015 11:29:11 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YOkpa-0000Fm-S8; Fri, 20 Feb 2015 11:29:10 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
In-Reply-To: <1424428143-641-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Feb 2015 11:29:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KAT90A017042
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1425032950.59587@LIiWB0xxCa0SAUhF5txi/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264151>

It was already documented, but the user had to follow the link to
git-mailinfo.txt to find it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-am.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index f4eea28..0d8ba48 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -52,7 +52,8 @@ OPTIONS
 -c::
 --scissors::
 	Remove everything in body before a scissors line (see
-	linkgit:git-mailinfo[1]).
+	linkgit:git-mailinfo[1]). Can be activated by default using
+	the `mailinfo.scissors` configuration variable.
 
 --no-scissors::
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
-- 
2.3.0.157.g79e124b
