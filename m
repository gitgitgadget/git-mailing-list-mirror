From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] RelNotes/1.8.5: direct script writers to "git status --porcelain"
Date: Thu, 26 Sep 2013 15:23:35 +0200
Message-ID: <1380201815-14140-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 26 15:30:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPBeG-0000Ue-3H
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 15:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804Ab3IZNaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 09:30:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58169 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab3IZNaX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 09:30:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8QDNo8C021636
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Sep 2013 15:23:50 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VPBXr-0004Vb-FY; Thu, 26 Sep 2013 15:23:51 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VPBXr-0003h0-5u; Thu, 26 Sep 2013 15:23:51 +0200
X-Mailer: git-send-email 1.8.4.474.g128a96c
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 26 Sep 2013 15:23:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8QDNo8C021636
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380806631.36852@3P9ah7E/7b9G1qpyAUs/eQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235418>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

Not terribly important, but the old item alone may sound like "we
broke your script purposely, good luck with the new version" to a
script writer.

 Documentation/RelNotes/1.8.5.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/1.8.5.txt b/Documentation/RelNotes/1.8.5.txt
index ac5c3fa..f100a0f 100644
--- a/Documentation/RelNotes/1.8.5.txt
+++ b/Documentation/RelNotes/1.8.5.txt
@@ -96,6 +96,9 @@ UI, Workflows & Features
 
  * "git status" now omits the prefix to make its output a comment in a
    commit log editor, which is not necessary for human consumption.
+   Scripts that parse the output of "git status" are advised to use
+   "git status --porcelain", which is both easier to parse and stable,
+   instead.
 
  * Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
    "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" would be
-- 
1.8.4.474.g128a96c
