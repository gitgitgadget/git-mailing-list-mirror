From: Jeff King <peff@peff.net>
Subject: [PATCH] t2107: mark passing test as success
Date: Sat, 18 Dec 2010 22:53:58 -0500
Message-ID: <20101219035357.GA12158@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 04:54:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUALq-0008JE-QL
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 04:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab0LSDyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 22:54:03 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42527 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756026Ab0LSDyB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 22:54:01 -0500
Received: (qmail 18489 invoked by uid 111); 19 Dec 2010 03:54:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 19 Dec 2010 03:54:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Dec 2010 22:53:58 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163952>

This failed on the branch where it was introduced, but was fixed
by merging with 6e67619 (Merge branch 'jn/parse-options-extra').

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t2107-update-index-basic.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index 33f8be0..809fafe 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -13,7 +13,7 @@ test_expect_success 'update-index --nonsense fails' '
 	test -s msg
 '
 
-test_expect_failure 'update-index --nonsense dumps usage' '
+test_expect_success 'update-index --nonsense dumps usage' '
 	test_expect_code 129 git update-index --nonsense 2>err &&
 	grep "[Uu]sage: git update-index" err
 '
-- 
1.7.3.4.761.g98ad5
