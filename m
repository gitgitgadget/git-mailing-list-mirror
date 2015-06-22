From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH v3 1/6] bisect: correction of typo
Date: Mon, 22 Jun 2015 23:00:31 +0200
Message-ID: <1435006836-18182-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 23:00:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78ph-0005rM-BG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbbFVVAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:00:41 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:47328 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751879AbbFVVAj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 17:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9B6E3259B;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9irJvCPl4RGJ; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 84EA421E0;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 73FA220E9;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqMRaEH34kiB; Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3414120D2;
	Mon, 22 Jun 2015 23:00:37 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272409>

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 bisect.c                    |    2 +-
 t/t6030-bisect-porcelain.sh |    2 +-
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
1.7.1
