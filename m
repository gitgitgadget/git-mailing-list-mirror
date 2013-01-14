From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/14] iamp-send.c: remove unused struct imap_store_conf
Date: Mon, 14 Jan 2013 06:32:35 +0100
Message-ID: <1358141566-26081-4-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucn3-0004wq-SS
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673Ab3ANFkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:40:36 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:53569 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751182Ab3ANFkg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:40:36 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2013 00:40:35 EST
X-AuditID: 12074412-b7f216d0000008e3-8c-50f398ae9942
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 55.B6.02275.EA893F05; Mon, 14 Jan 2013 00:33:34 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2k026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:33:32 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLtuxucAg85v3BZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujGmT/zMX
	fGSuuPrjKGsDYw9zFyMnh4SAicS5n2fYIGwxiQv31oPZQgKXGSU6m6W6GLmA7LNMElc2zWQH
	SbAJ6Eos6mlmArFFBNQkJrYdYgGxmQVSJDqedzOC2MICHhLND5eygtgsAqoSb5fMBovzCrhI
	rGxYxQ6xTEHi9c5LYDWcAq4S3z+eYoZY7CLx8FQz2wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdM30cjNL9FJTSjcxQsJHaAfj+pNyhxgFOBiVeHg3lnwOEGJNLCuuzD3EKMnBpCTK
	G94PFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCG1oHlONNSaysSi3Kh0lJc7AoifP+XKzuJySQ
	nliSmp2aWpBaBJOV4eBQkuDtnw7UKFiUmp5akZaZU4KQZuLgBBFcIBt4gDbUgBTyFhck5hZn
	pkMUnWJUlBLnTQVJCIAkMkrz4AbAIv0VozjQP8K8TSBVPMAkAdf9CmgwE9DgsxfegwwuSURI
	STUwGpsXn+RSajzJd3jdbaETS6bv2/U6haF44663fRZxQidOlgQ93ViTayu8WtR88mZGBy/r
	9h8eU5oPMKxbERRx/s6uLe7Oj2d/eu4kl3Vg43JB946f8S13k73Su3vr6mXmf3iT2vPhT2Ka
	xdlvifP1ZPbdFbLlvi73NPBbtcWHubPFbmyv03GUUGIpzkg01GIuKk4EAOsa5gHP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213443>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a8cb66a..d675e70 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -130,11 +130,6 @@ static struct imap_server_conf server = {
 	NULL,	/* auth_method */
 };
 
-struct imap_store_conf {
-	struct store_conf gen;
-	struct imap_server_conf *server;
-};
-
 #define NIL	(void *)0x1
 #define LIST	(void *)0x2
 
-- 
1.8.0.3
