From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/14] imap-send.c: remove unused field imap_store::uidvalidity
Date: Mon, 14 Jan 2013 06:32:45 +0100
Message-ID: <1358141566-26081-14-git-send-email-mhagger@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 06:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tucgm-0007bD-Hy
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 06:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab3ANFeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 00:34:08 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:47254 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752369Ab3ANFeG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 00:34:06 -0500
X-AuditID: 1207440d-b7f306d0000008b7-52-50f398ce650b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.E0.02231.EC893F05; Mon, 14 Jan 2013 00:34:06 -0500 (EST)
Received: from michael.fritz.box (p57A25AA5.dip.t-dialin.net [87.162.90.165])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E5Wt2u026427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 00:34:05 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqHtuxucAgz+/+S26rnQzWTT0XmG2
	uL1iPrPFj5YeZgcWj7/vPzB5POvdw+hx8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGfMbvjIX
	fGCuuP9rFXsDYxdzFyMnh4SAicTmrutQtpjEhXvr2boYuTiEBC4zSsz4NIcZwjnLJDH3/352
	kCo2AV2JRT3NTCC2iICaxMS2QywgNrNAikTH825GEFtYwF+ivbkFLM4ioCpxduIbsF5eAVeJ
	8zP+MEFsU5B4vfMSK4jNCRT//vEU2BVCAi4SD081s01g5F3AyLCKUS4xpzRXNzcxM6c4NVm3
	ODkxLy+1SNdILzezRC81pXQTIySAeHcw/l8nc4hRgINRiYd3U8nnACHWxLLiytxDjJIcTEqi
	vOH9QCG+pPyUyozE4oz4otKc1OJDjBIczEoivKF1QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB
	9MSS1OzU1ILUIpisDAeHkgSvMzBShASLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CGz9NBNhQXJOYW
	Z6ZDFJ1iVJQS510NkhAASWSU5sENgMX6K0ZxoH+Eef+BVPEA0wRc9yugwUxAg89eeA8yuCQR
	ISXVwOjF8GSTiXpld3bdHdYV/CtEdVf9UCm6tcHr8ISeU7e+aSw/qG3Zd2ruNL7Hi1Zq7t3h
	y9jVlvEkVunB9933dT/PlDeqffTkXPL1lIZaD5d6Tpd827ysWesm/hYPy8y/soDhk45A14ot
	12TK4t4H/YsolXVZz7OGq2lGyd9o5zXdi8QLXkjOZFBiKc5INNRiLipOBAAgrbQr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213440>

I suspect that the existence of both imap_store::uidvalidity and
store::uidvalidity was an accident.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 31fdbf3..4d24faf 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -124,7 +124,6 @@ struct imap {
 
 struct imap_store {
 	struct store gen;
-	int uidvalidity;
 	struct imap *imap;
 	const char *prefix;
 };
-- 
1.8.0.3
