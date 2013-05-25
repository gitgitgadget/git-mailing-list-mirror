From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/25] show_head_ref(): rename first parameter to "refname"
Date: Sat, 25 May 2013 11:08:19 +0200
Message-ID: <1369472904-12875-21-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAUm-0005t7-C3
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab3EYJJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:29 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:64455 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754464Ab3EYJJ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:27 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-44-51a07fc61426
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id C9.4F.02295.6CF70A15; Sat, 25 May 2013 05:09:26 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guu000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:25 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqHusfkGgwefFahZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgzth6ZC9bwUz2ii/t09kaGN+xdjFycEgImEjsv6XTxcgJZIpJXLi3
	nq2LkYtDSOAyo8S+1tPMEM4FJondB94yglSxCehKLOppZgKxRQQcJU48uM4KUsQs0Mso8fDR
	d7CEsICfxNUJF1lAbBYBVYnVGw+CNfMKuEps3j+DDWKdgsTlWWuYQa7gBIq/PcEJEhYScJF4
	/ukc6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQsKMZwfjt3Uy
	hxgFOBiVeHgFy+cHCrEmlhVX5h5ilORgUhLl5a9dECjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJ
	hJchBSjHm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQWgSTleHgUJLgZQLGk5BgUWp6
	akVaZk4JQpqJgxNEcIFs4AHawAVSyFtckJhbnJkOUXSKUVFKnPdmHVBCACSRUZoHNwCWEF4x
	igP9I8x7F6SKB5hM4LpfAQ1mAhp8M3c+yOCSRISUVAMjy9aFb71a3NrPhzt2pfwxmsg4J5DX
	SWTqwqcVzVUv7/LYfIsxnZzZ53+FT06Xd8WRR9vkf+154b/2/3pZsU2mkobnX2y592jRf3Hv
	AIussJn+Fy8/L2WZcNfAWJZV4LXGvTcrBDqTD2/Q/q657tSH9PyiGMZ7Aq//sNxV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225507>

This is the usual convention.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 3135835..0324417 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -410,14 +410,14 @@ static void get_info_refs(char *arg)
 	strbuf_release(&buf);
 }
 
-static int show_head_ref(const char *name, const unsigned char *sha1,
+static int show_head_ref(const char *refname, const unsigned char *sha1,
 	int flag, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
 	if (flag & REF_ISSYMREF) {
 		unsigned char unused[20];
-		const char *target = resolve_ref_unsafe(name, unused, 1, NULL);
+		const char *target = resolve_ref_unsafe(refname, unused, 1, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
-- 
1.8.2.3
