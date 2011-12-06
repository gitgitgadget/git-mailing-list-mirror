From: Jeff King <peff@peff.net>
Subject: [PATCHv2 02/13] t5550: fix typo
Date: Tue, 6 Dec 2011 01:22:32 -0500
Message-ID: <20111206062232.GB29233@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:22:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoQI-0004Yy-BW
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970Ab1LFGWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:22:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40041
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908Ab1LFGWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:22:34 -0500
Received: (qmail 1089 invoked by uid 107); 6 Dec 2011 06:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:29:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:22:32 -0500
Content-Disposition: inline
In-Reply-To: <20111206062127.GA29046@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186320>

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
1.7.8.rc4.4.g884ec
