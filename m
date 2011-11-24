From: Jeff King <peff@peff.net>
Subject: [PATCH 02/13] t5550: fix typo
Date: Thu, 24 Nov 2011 05:59:15 -0500
Message-ID: <20111124105914.GB6195@sigill.intra.peff.net>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 11:59:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTX1W-00036v-Gw
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 11:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428Ab1KXK7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 05:59:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49633
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1KXK7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 05:59:17 -0500
Received: (qmail 10062 invoked by uid 107); 24 Nov 2011 10:59:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Nov 2011 05:59:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Nov 2011 05:59:15 -0500
Content-Disposition: inline
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185897>

This didn't have an impact, because it was just setting up
an "expect" file that happened to be identical to the one in
the test before it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5550-http-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 311a33c..3d6e871 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -66,7 +66,7 @@ test_expect_success 'cloning password-protected repository can fail' '
 
 test_expect_success 'http auth can use user/pass in URL' '
 	>askpass-query &&
-	echo wrong >askpass-reponse &&
+	echo wrong >askpass-response &&
 	git clone "$HTTPD_URL_USER_PASS/auth/repo.git" clone-auth-none &&
 	test_cmp askpass-expect-none askpass-query
 '
-- 
1.7.7.4.5.gb32a5
