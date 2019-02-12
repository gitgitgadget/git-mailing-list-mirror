Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF58211B5
	for <e@80x24.org>; Tue, 12 Feb 2019 06:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfBLGdG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 01:33:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:41370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725972AbfBLGdG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 01:33:06 -0500
Received: (qmail 6299 invoked by uid 109); 12 Feb 2019 06:33:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 06:33:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22834 invoked by uid 111); 12 Feb 2019 06:33:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Feb 2019 01:33:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2019 01:33:04 -0500
Date:   Tue, 12 Feb 2019 01:33:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] RelNotes/2.21: misc typo/English fixups
Message-ID: <20190212063304.GB21872@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These are just some small fixes I noticed doing a complete read-through
(there are a few cases I left that are incomplete or abbreviated
sentences, but I think those are OK in this sort of bullet-list style).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/RelNotes/2.21.0.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.21.0.txt b/Documentation/RelNotes/2.21.0.txt
index 77b8d9d221..702ebfcdc3 100644
--- a/Documentation/RelNotes/2.21.0.txt
+++ b/Documentation/RelNotes/2.21.0.txt
@@ -26,7 +26,7 @@ UI, Workflows & Features
    the fast-export side has been made.
 
  * "git push $there $src:$dst" rejects when $dst is not a fully
-   qualified refname and not clear what the end user meant.  The
+   qualified refname and it is not clear what the end user meant.  The
    codepath has been taught to give a clearer error message, and also
    guess where the push should go by taking the type of the pushed
    object into account (e.g. a tag object would want to go under
@@ -88,7 +88,7 @@ Performance, Internal Implementation, Development Support etc.
    (non-)existence of loose objects.
 
  * More codepaths have become aware of working with in-core repository
-   instance other than the default "the_repository".
+   instances other than the default "the_repository".
 
  * The "strncat()" function is now among the banned functions.
 
@@ -125,13 +125,13 @@ Performance, Internal Implementation, Development Support etc.
  * The in-core repository instances are passed through more codepaths.
 
  * Update the protocol message specification to allow only the limited
-   use of scaled quantities.  This is ensure potential compatibility
-   issues will not go out of hand.
+   use of scaled quantities.  This is to ensure potential compatibility
+   issues will not get out of hand.
 
  * Micro-optimize the code that prepares commit objects to be walked
    by "git rev-list" when the commit-graph is available.
 
- * "git fetch" and "git upload-pack" learned to send all exchange over
+ * "git fetch" and "git upload-pack" learned to send all exchanges over
    the sideband channel while talking the v2 protocol.
 
  * The codepath to write out commit-graph has been optimized by
-- 
2.21.0.rc0.568.gbf84974d35
