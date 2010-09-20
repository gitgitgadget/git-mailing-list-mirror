From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] sha1_name.c: update comment to mention :/foo syntax
Date: Mon, 20 Sep 2010 23:01:17 +0200
Message-ID: <1285016477-22222-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 20 23:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxnY9-0006rR-N6
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 23:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545Ab0ITVFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 17:05:12 -0400
Received: from imag.imag.fr ([129.88.30.1]:62861 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637Ab0ITVFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 17:05:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8KL1Pwx016466
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 23:01:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OxnUL-0008K5-5n; Mon, 20 Sep 2010 23:01:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OxnUL-0005n2-1q; Mon, 20 Sep 2010 23:01:25 +0200
X-Mailer: git-send-email 1.7.3.2.g257b5f
In-Reply-To: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Sep 2010 23:01:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156668>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Noticed while reviewing the patch serie about textconv and symlinks.
If we have comments, better have them up-to-date ;-).

 sha1_name.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 7b7e617..d7ab72a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1062,6 +1062,7 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	/* sha1:path --> object name of path in ent sha1
 	 * :path -> object name of path in index
 	 * :[0-3]:path -> object name of path in index at stage
+	 * :/foo -> last commit whose subject starts with foo
 	 */
 	if (name[0] == ':') {
 		int stage = 0;
-- 
1.7.3.2.g257b5f
