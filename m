From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 1/7] bisect : correction of typo
Date: Wed, 10 Jun 2015 18:24:26 +0200
Message-ID: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 18:24:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2inx-0007D8-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 18:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933893AbbFJQYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 12:24:37 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:44665 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933733AbbFJQYf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 12:24:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E82284887C;
	Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AmK3FtLjvIGL; Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D491748876;
	Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id B2C5D20E7;
	Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Za3Dyr-T8+ve; Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 6883A20DC;
	Wed, 10 Jun 2015 18:24:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271320>


Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 bisect.c                    |    2 +-
 t/t6030-bisect-porcelain.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 10f5e57..de92953 100644
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
1.7.1
