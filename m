From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] t1300: add missing &&-chaining
Date: Thu, 16 Feb 2012 03:02:18 -0500
Message-ID: <20120216080218.GA11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:02:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwIL-0007a8-Kh
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310Ab2BPICV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:02:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38561
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2BPICU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:02:20 -0500
Received: (qmail 27923 invoked by uid 107); 16 Feb 2012 08:09:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:09:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:02:18 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190876>

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1300-repo-config.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0690e0e..6de46bb 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -451,7 +451,7 @@ test_expect_success 'refer config from subdirectory' '
 	mkdir x &&
 	(
 		cd x &&
-		echo strasse >expect
+		echo strasse >expect &&
 		git config --get --file ../other-config ein.bahn >actual &&
 		test_cmp expect actual
 	)
-- 
1.7.9.1.4.g8ffed
