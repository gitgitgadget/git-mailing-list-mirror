From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4 4/6] Documentation/git-show.txt: include common diff options, like git-log.txt
Date: Tue, 16 Jul 2013 10:05:38 +0200
Message-ID: <1373961940-31614-5-git-send-email-Matthieu.Moy@imag.fr>
References: <20130715185843.GH14690@google.com>
 <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: jrnieder@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 16 10:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz0bh-0007Hq-S7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 10:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab3GPI1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 04:27:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33666 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab3GPI1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 04:27:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r6G8ODTu014778
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Jul 2013 10:24:13 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uz0YQ-0001z1-LS; Tue, 16 Jul 2013 10:24:14 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uz0YQ-0008KD-BV; Tue, 16 Jul 2013 10:24:14 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <1373961940-31614-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 16 Jul 2013 10:24:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6G8ODTu014778
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374567854.59006@9V7POIE1SR/fVdpeYPf4/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230548>

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
