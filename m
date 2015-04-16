From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 3/5] t3904-stash-patch: fix test description
Date: Thu, 16 Apr 2015 09:02:29 +0200
Message-ID: <1429167751-19398-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
 <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Tanky Woo <wtq1990@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 09:03:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidpF-000452-IO
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbbDPHC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:02:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33527 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756917AbbDPHCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:02:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72eCh029335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 09:02:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72e4Q021229;
	Thu, 16 Apr 2015 09:02:40 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yidou-0005CO-LQ; Thu, 16 Apr 2015 09:02:40 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 09:02:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3G72eCh029335
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429772564.3149@wkwJoky+2LxbCSP30KlCKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267255>

The old description is rather clearly a wrong cut-and-paste from
t2016-checkout-patch.sh.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3904-stash-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 70655c1..9a59683 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git checkout --patch'
+test_description='stash -p'
 . ./lib-patch-mode.sh
 
 test_expect_success PERL 'setup' '
-- 
2.4.0.rc1.42.g9642cc6
