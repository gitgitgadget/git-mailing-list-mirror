From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] t1404: rename file to t1404-update-ref-errors.sh
Date: Tue,  7 Jun 2016 13:50:06 +0200
Message-ID: <13a5d2e8b84bebaa6d826dd5b7cb78be057874c4.1465299118.git.mhagger@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:51:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFWl-0004Ls-OE
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbcFGLuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:50:20 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61998 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161079AbcFGLuS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:50:18 -0400
X-AuditID: 1207440f-8bbff700000008e4-2f-5756b4f9cebf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 51.26.02276.9F4B6575; Tue,  7 Jun 2016 07:50:17 -0400 (EDT)
Received: from michael.fritz.box (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BoCa0014544
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:50:15 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465299118.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqPtzS1i4wcb5LBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WF2YPP4+/4Dk8fOWXfZPZ717mH0uHhJ2WPB8/vsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ/Ttjyy4zlbxfMYbpgbG+6xdjJwcEgImEv/vzmUBsYUEtjJK7Fhp
	1cXIBWQfY5JY8vIyG0iCTUBXYlFPMxOILSIQIdHwqoURpIhZYB+jxMl188G6hQVcJc797AVr
	YBFQlZi3fCcjiM0rECWx5dQrNohtchKXpz8AszkFLCROvFvJBrHZXOJiyybGCYw8CxgZVjHK
	JeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEhBP/Dsau9TKHGAU4GJV4eAW+h4YL
	sSaWFVfmHmKU5GBSEuV96B0WLsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN2EtUI43JbGyKrUo
	HyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJMFrDYwbIcGi1PTUirTMnBKENBMHJ8hw
	LimR4tS8lNSixNKSjHhQBMQXA2MAJMUDtPfVZpC9xQWJuUBRiNZTjLocC37cXsskxJKXn5cq
	Jc67DaRIAKQoozQPbgUsebxiFAf6WJh3L0gVDzDxwE16BbSECWjJsmvBIEtKEhFSUg2Mhq3/
	hadt8n5/Xm5l9U+hv/OXv2oMLt7o9P5LcvqryYfnP1neeSBjvhTX6RzvFZ8P3TmmmHaNbcXT
	XCbt9teZMj81vhekdX9pFuypjrscvDz/ziyJR+kCb+fZJ8wz9fipbm28gS3/53bm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296629>

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
