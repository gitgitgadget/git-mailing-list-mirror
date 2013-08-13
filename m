From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: ignore generated git-mw
Date: Tue, 13 Aug 2013 15:32:19 +0200
Message-ID: <1376400739-8922-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 13 15:33:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Eid-0006oX-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 15:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068Ab3HMNcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 09:32:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57575 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758038Ab3HMNcb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 09:32:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7DDWLs7020520
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Aug 2013 15:32:21 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1V9Ehy-0001Oz-SG; Tue, 13 Aug 2013 15:32:22 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1V9Ehy-0002KY-Ir; Tue, 13 Aug 2013 15:32:22 +0200
X-Mailer: git-send-email 1.8.2.1.349.ge888d28.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 13 Aug 2013 15:32:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7DDWLs7020520
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1377005545.30687@vxJBXkoLvhGiMQWU/s13UQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232225>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/mw-to-git/.gitignore b/contrib/mw-to-git/.gitignore
index b919655..ae545b0 100644
--- a/contrib/mw-to-git/.gitignore
+++ b/contrib/mw-to-git/.gitignore
@@ -1 +1,2 @@
 git-remote-mediawiki
+git-mw
-- 
1.8.2.1.349.ge888d28.dirty
