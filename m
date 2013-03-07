From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 2/2] bundle: Add colons to list headings in "verify"
Date: Thu,  7 Mar 2013 01:56:36 +0100
Message-ID: <1362617796-4120-2-git-send-email-git@cryptocrack.de>
References: <1362617796-4120-1-git-send-email-git@cryptocrack.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lukas Fleischer <git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 05:57:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDStG-00008r-7z
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 05:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203Ab3CGE4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 23:56:46 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:22249 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab3CGE4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 23:56:45 -0500
X-Greylist: delayed 14403 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2013 23:56:45 EST
Received: from localhost (p57B45C6D.dip.t-dialin.net [87.180.92.109])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id a2282021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128);
	Thu, 7 Mar 2013 01:56:38 +0100 (CET)
X-Mailer: git-send-email 1.8.2.rc2.352.g908df73
In-Reply-To: <1362617796-4120-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217573>

These slightly improve the reading flow by making it obvious that a list
follows.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 bundle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bundle.c b/bundle.c
index 65db53b..8cd8b4f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -183,8 +183,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		struct ref_list *r;
 
 		r = &header->references;
-		printf_ln(Q_("The bundle contains %d ref",
-			     "The bundle contains %d refs",
+		printf_ln(Q_("The bundle contains %d ref:",
+			     "The bundle contains %d refs:",
 			     r->nr),
 			  r->nr);
 		list_refs(r, 0, NULL);
@@ -192,8 +192,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
 		} else {
-			printf_ln(Q_("The bundle requires this ref",
-				     "The bundle requires these %d refs",
+			printf_ln(Q_("The bundle requires this ref:",
+				     "The bundle requires these %d refs:",
 				     r->nr),
 				  r->nr);
 			list_refs(r, 0, NULL);
-- 
1.8.2.rc2.352.g908df73
