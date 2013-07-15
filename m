From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5] Documentation/git-show.txt: include common diff options, like git-log.txt
Date: Mon, 15 Jul 2013 15:07:17 +0200
Message-ID: <1373893639-13413-4-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
 <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 15:08:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyiVy-0004cU-SS
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab3GONI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 09:08:27 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40190 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227Ab3GONI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 09:08:26 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FD7rkO019957
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 15:07:53 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UyiVP-0000YK-3V; Mon, 15 Jul 2013 15:07:55 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UyiVO-0003XJ-Ol; Mon, 15 Jul 2013 15:07:54 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 15:07:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FD7rkO019957
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374498476.47452@DrJyNGi1bQbE2i64MHJJWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230462>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-show.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index ae4edcc..4e617e6 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -45,6 +45,15 @@ include::pretty-options.txt[]
 include::pretty-formats.txt[]
 
 
+COMMON DIFF OPTIONS
+-------------------
+
+:git-log: 1
+include::diff-options.txt[]
+
+include::diff-generate-patch.txt[]
+
+
 EXAMPLES
 --------
 
-- 
1.8.3.1.495.g13f33cf.dirty
