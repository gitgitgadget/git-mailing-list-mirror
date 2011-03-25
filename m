From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] t7607: mark known breakage in test 11 as fixed
Date: Fri, 25 Mar 2011 14:08:36 -0400
Message-ID: <20110325180836.GA14898@sigill.intra.peff.net>
References: <20110325180644.GA30838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: "igor.mikushkin" <igor.mikushkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:08:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3BRG-00051a-B8
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab1CYSIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 14:08:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50402
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab1CYSIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 14:08:40 -0400
Received: (qmail 16218 invoked by uid 107); 25 Mar 2011 18:09:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 14:09:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 14:08:36 -0400
Content-Disposition: inline
In-Reply-To: <20110325180644.GA30838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170008>

This was fixed by 1d718a51 (do not overwrite untracked
symlinks, 2011-02-20).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7607-merge-overwrite.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 5f731a1..691c5fd 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -122,7 +122,7 @@ test_expect_success 'will not overwrite untracked file in leading path' '
 	rm -f sub sub2
 '
 
-test_expect_failure SYMLINKS 'will not overwrite untracked symlink in leading path' '
+test_expect_success SYMLINKS 'will not overwrite untracked symlink in leading path' '
 	git reset --hard c0 &&
 	rm -rf sub &&
 	mkdir sub2 &&
-- 
1.7.4.33.gb8855.dirty
