From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2] git-remote-mediawiki: fix incorrect test usage in test
Date: Tue, 17 Jul 2012 16:05:59 +0200
Message-ID: <1342533960-22123-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 17 16:34:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr8rF-0007Za-MW
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 16:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab2GQOec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 10:34:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42531 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab2GQOeb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 10:34:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6HE4RHf019165
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jul 2012 16:04:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sr8Pd-0006bt-OF; Tue, 17 Jul 2012 16:06:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sr8Pd-0006I4-Ms; Tue, 17 Jul 2012 16:06:05 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342533960-22123-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Jul 2012 16:04:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6HE4RHf019165
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343138667.84964@WmMYUbYb4D3k0icPYudDWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201606>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/push-pull-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/push-pull-tests.sh b/contrib/mw-to-git/t/push-pull-tests.sh
index 6692a0f..9da2dc5 100644
--- a/contrib/mw-to-git/t/push-pull-tests.sh
+++ b/contrib/mw-to-git/t/push-pull-tests.sh
@@ -104,7 +104,7 @@ test_push_pull () {
 			git push
 		) &&
 
-		test ! wiki_page_exist Foo
+		test_must_fail wiki_page_exist Foo
 	'
 
 	test_expect_success 'Merge conflict expected and solving it' '
-- 
1.7.11.2.258.g5ff3cdf.dirty
