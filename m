From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] ref-filter: fix indentation
Date: Wed, 29 Jul 2015 17:52:30 +0200
Message-ID: <1438185150-31730-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 29 17:52:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTey-0001xO-FM
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbbG2Pwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:52:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56160 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbbG2Pwo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 11:52:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6TFqa6M009181
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 29 Jul 2015 17:52:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6TFqcug020926;
	Wed, 29 Jul 2015 17:52:38 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZKTeo-0008Hz-94; Wed, 29 Jul 2015 17:52:38 +0200
X-Mailer: git-send-email 2.5.0.rc0.7.ge1edd74.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Jul 2015 17:52:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6TFqa6M009181
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1438789958.76754@y+V3y3tYGrHpzGwSUO3NRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274907>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is meant to be applied on top of kn/for-each-ref.

 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 43502a4..3fbbbeb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -868,8 +868,8 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
-		  warning("ignoring ref with broken name %s", refname);
-		  return 0;
+		warning("ignoring ref with broken name %s", refname);
+		return 0;
 	}
 
 	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
-- 
2.5.0.rc0.7.ge1edd74.dirty
