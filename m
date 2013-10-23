From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/15] t5510: use the correct tag name in test
Date: Wed, 23 Oct 2013 17:50:34 +0200
Message-ID: <1382543448-2586-2-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:51:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0j0-0001v8-K0
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579Ab3JWPvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:51:54 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42189 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab3JWPvx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:51:53 -0400
X-AuditID: 12074414-b7fb46d000002a4d-2c-5267f09580b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 56.D2.10829.590F7625; Wed, 23 Oct 2013 11:51:49 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLss009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:47 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqDv1Q3qQwYslihbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xtMXH5gKHrBVtM/7wtbAeJK1i5GTQ0LARGLWxA4WCFtM4sK99WxdjFwcQgKXGSW27/jH
	DuFcYZKYMWkVWAebgK7Eop5mJhBbREBNYmLbIRaQImaBicwSx6cvAhslLGAncW7vVDYQm0VA
	VWLP/YtAkzg4eAWcJRr3uYOYEgJyEg+/xYJUcAq4SFw4Ph1svBBQxYSFU9knMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iREStCI7GI+clDvEKMDBqMTD+6AlLUiI
	NbGsuDL3EKMkB5OSKO+cd+lBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4d9wFyvGmJFZWpRbl
	w6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfC6vgdqFCxKTU+tSMvMKUFIM3Fwgggu
	kA08QBtiQAp5iwsSc4sz0yGKTjEqSonzNoAkBEASGaV5cANg6eUVozjQP8K8iSBVPMDUBNf9
	CmgwE9DgKUvSQAaXJCKkpBoYBe6Ui7EwPrDisv2X/urWphkC8fon7IMi9x77e3WaTZ3LkuoN
	rU7WfLdrKwWd3s2fKPTxsreJ2GWfqAedX7eKejdN3BA4bXNLp7rf9V+3zZiKVn0P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236514>

Fix an apparent copy-paste error: A few lines earlier, a tag
"refs/tags/sometag" is created.  Check for the (non-)existence of that
tag, not "somebranch", which is otherwise never mentioned in the
script.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 1f0f8e6..c5e5dfc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -121,7 +121,7 @@ test_expect_success 'fetch --prune --tags does not delete the remote-tracking br
 
 	git fetch --prune --tags origin &&
 	git rev-parse origin/master &&
-	test_must_fail git rev-parse somebranch
+	test_must_fail git rev-parse sometag
 '
 
 test_expect_success 'fetch --prune --tags with branch does not delete other remote-tracking branches' '
-- 
1.8.4
