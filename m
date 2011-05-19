From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] Makefile: sort TEST_PROGRAMS list
Date: Thu, 19 May 2011 17:24:24 -0400
Message-ID: <20110519212424.GA29584@sigill.intra.peff.net>
References: <20110519212349.GA28589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:24:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAhr-0000ZZ-Ee
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933415Ab1ESVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:24:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47070
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932665Ab1ESVY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:24:26 -0400
Received: (qmail 20725 invoked by uid 107); 19 May 2011 21:26:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:26:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:24:24 -0400
Content-Disposition: inline
In-Reply-To: <20110519212349.GA28589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174006>

We usually keep these lists in sorted order, but the last
few entries were just tacked on the end.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5379aaa..d09ee70 100644
--- a/Makefile
+++ b/Makefile
@@ -415,8 +415,10 @@ TEST_PROGRAMS_NEED_X += test-date
 TEST_PROGRAMS_NEED_X += test-delta
 TEST_PROGRAMS_NEED_X += test-dump-cache-tree
 TEST_PROGRAMS_NEED_X += test-genrandom
+TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-match-trees
+TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-obj-pool
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
@@ -427,8 +429,6 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
-TEST_PROGRAMS_NEED_X += test-index-version
-TEST_PROGRAMS_NEED_X += test-mktemp
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
-- 
1.7.5.8.ga95ab
