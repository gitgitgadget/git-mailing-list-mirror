From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 1/5] bisect: correction of typo
Date: Tue, 23 Jun 2015 14:54:40 +0200
Message-ID: <1435064084-5554-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
 <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 23 19:30:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7S1N-0008Ku-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbbFWR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:29:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46816 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbbFWR3x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:29:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5NHTf1c023174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jun 2015 19:29:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5NHThmu009525;
	Tue, 23 Jun 2015 19:29:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z7S11-0004Dy-91; Tue, 23 Jun 2015 19:29:43 +0200
X-Mailer: git-send-email 2.4.4.414.ge37915c
In-Reply-To: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 23 Jun 2015 19:29:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5NHTf1c023174
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1435685385.57459@gvC/p+higQ1zmyNt2S04rA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272466>

From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 bisect.c                    | 2 +-
 t/t6030-bisect-porcelain.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 03d5cd9..5b8357d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -743,7 +743,7 @@ static void handle_bad_merge_base(void)
 
 	fprintf(stderr, "Some good revs are not ancestor of the bad rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistake good and bad revs?\n");
+		"Maybe you mistook good and bad revs?\n");
 	exit(1);
 }
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 06b4868..9e2c203 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -362,7 +362,7 @@ test_expect_success 'bisect starting with a detached HEAD' '
 test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset &&
 	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
-	grep "mistake good and bad" rev_list_error &&
+	grep "mistook good and bad" rev_list_error &&
 	git bisect reset
 '
 
-- 
2.4.4.414.ge37915c
