From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] t1300: remove redundant test
Date: Tue, 23 Oct 2012 18:36:22 -0400
Message-ID: <20121023223622.GB17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn5S-0000Gm-2s
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933502Ab2JWWg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:36:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51676 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2JWWg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:36:26 -0400
Received: (qmail 23255 invoked by uid 107); 23 Oct 2012 22:37:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:37:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:36:22 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208263>

This test checks that git-config fails for an ambiguous
"get", but we check the exact same thing 3 tests beforehand.

Signed-off-by: Jeff King <peff@peff.net>
---
I update the matching test later in the series, and I didn't want to
have to do it twice.

 t/t1300-repo-config.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index e12dd4a..c6489dc 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -275,10 +275,6 @@ test_expect_success 'multivar replace' '
 	test_cmp expect .git/config
 '
 
-test_expect_success 'ambiguous value' '
-	test_must_fail git config nextsection.nonewline
-'
-
 test_expect_success 'ambiguous unset' '
 	test_must_fail git config --unset nextsection.nonewline
 '
-- 
1.8.0.3.g3456896
