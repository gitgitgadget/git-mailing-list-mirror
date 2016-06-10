From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/6] t1404: rename file to t1404-update-ref-errors.sh
Date: Fri, 10 Jun 2016 10:14:44 +0200
Message-ID: <13a5d2e8b84bebaa6d826dd5b7cb78be057874c4.1465544913.git.mhagger@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHaz-0001QR-Le
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbcFJIPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:03 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57991 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900AbcFJIO6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:14:58 -0400
X-AuditID: 12074411-e2bff70000000955-4b-575a7700e508
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C3.F3.02389.0077A575; Fri, 10 Jun 2016 04:14:57 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD3028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:14:55 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465544913.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqMtYHhVuMPM4i0XXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M7o2x9ZcJ2t4vmMN0wNjPdZuxg5OSQETCT639xl
	72Lk4hAS2MooMXXLEyaQhJDASSaJhWtCQWw2AV2JRT3NYHERATWJiW2HWEAamAU6mSRO7HkD
	5HBwCAt4SDxeIwpisgioSvw6qABSzisQJbHz9UI2iF1yEpenPwCzOQUsJE5fn8AGscpc4t/s
	JvYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluilppRuYoSEl+AOxhkn5Q4x
	CnAwKvHwRuyKDBdiTSwrrsw9xCjJwaQkyrszMCpciC8pP6UyI7E4I76oNCe1+BCjBAezkgiv
	GEiONyWxsiq1KB8mJc3BoiTOy7dE3U9IID2xJDU7NbUgtQgmK8PBoSTBq1YG1ChYlJqeWpGW
	mVOCkGbi4AQZziUlUpyal5JalFhakhEPCv74YmD4g6R4gPa2l4LsLS5IzAWKQrSeYjTmWPDj
	9lomjiP7761lEmLJy89LlRLnXQRSKgBSmlGaB7cIllheMYoD/S3MuwGkigeYlODmvQJaxQS0
	avmRcJBVJYkIKakGxhWrLHv6X+hOZE//K1uaOt/yw9OG44FrF3rdacxw37dFbU37uZv3+oQs
	tp5V0VIyWPX+2dbvEz8fWqXz5P9pXoe/bEkWH1XEzvFafm4x/z1zfxr70YnXQqYU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296950>

I want to broaden the scope of this test file, so rename it accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/{t1404-update-ref-df-conflicts.sh => t1404-update-ref-errors.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t1404-update-ref-df-conflicts.sh => t1404-update-ref-errors.sh} (98%)

diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-errors.sh
similarity index 98%
rename from t/t1404-update-ref-df-conflicts.sh
rename to t/t1404-update-ref-errors.sh
index 6d869d1..2818460 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test git update-ref with D/F conflicts'
+test_description='Test git update-ref error handling'
 . ./test-lib.sh
 
 test_update_rejected () {
-- 
2.8.1
