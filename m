From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 3/3] bisect: fix indentation
Date: Thu,  4 Jun 2015 09:59:13 +0200
Message-ID: <1433404753-12039-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
References: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Cc: thomasxnguy@gmail.com, valentinduperray@gmail.com,
	remi.lespinet@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre@ensimag.grenoble-inp.fr,
	matthieu.moy@grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 09:59:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Q3p-0002nF-SM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 09:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbbFDH72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 03:59:28 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60406 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752434AbbFDH7Y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2015 03:59:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1393A282B;
	Thu,  4 Jun 2015 09:59:23 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qC7UjzKHusXw; Thu,  4 Jun 2015 09:59:23 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 036892829;
	Thu,  4 Jun 2015 09:59:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id F360420DC;
	Thu,  4 Jun 2015 09:59:22 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsYPJYPXSgFf; Thu,  4 Jun 2015 09:59:22 +0200 (CEST)
Received: from pcserveur.ensimag.fr (ensipcserveur.imag.fr [129.88.240.65])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id E1DA920D4;
	Thu,  4 Jun 2015 09:59:22 +0200 (CEST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1433404753-12039-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270753>

From: Christian Couder <chriscool@tuxfamily.org>

Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
---
 bisect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 68417bb..87a5f6d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -915,10 +915,10 @@ void read_bisect_terms(void)
 		name_bad = "bad";
 		name_good = "good";
 	} else {
-	strbuf_getline(&str, fp, '\n');
-	name_bad = strbuf_detach(&str, NULL);
-	strbuf_getline(&str, fp, '\n');
-	name_good = strbuf_detach(&str, NULL);
+		strbuf_getline(&str, fp, '\n');
+		name_bad = strbuf_detach(&str, NULL);
+		strbuf_getline(&str, fp, '\n');
+		name_good = strbuf_detach(&str, NULL);
 	}
 	strbuf_release(&str);
 	fclose(fp);
-- 
2.4.1.173.gd47f443.dirty
