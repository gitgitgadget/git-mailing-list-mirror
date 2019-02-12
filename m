Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D392E211B5
	for <e@80x24.org>; Tue, 12 Feb 2019 06:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfBLGcu (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 01:32:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:41354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725976AbfBLGcu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 01:32:50 -0500
Received: (qmail 6280 invoked by uid 109); 12 Feb 2019 06:32:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 06:32:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22800 invoked by uid 111); 12 Feb 2019 06:33:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Feb 2019 01:33:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2019 01:32:48 -0500
Date:   Tue, 12 Feb 2019 01:32:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/2] RelNotes/2.21: tweak "--date=auto" mention
Message-ID: <20190212063247.GA21872@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the feature that was eventually committed, "--date=auto" doesn't do
anything. It was generalized to "--date=auto:<format>".

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/RelNotes/2.21.0.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes/2.21.0.txt b/Documentation/RelNotes/2.21.0.txt
index 8a9a8dd496..77b8d9d221 100644
--- a/Documentation/RelNotes/2.21.0.txt
+++ b/Documentation/RelNotes/2.21.0.txt
@@ -77,9 +77,9 @@ UI, Workflows & Features
 
  * A new date format "--date=human" that morphs its output depending
    on how far the time is from the current time has been introduced.
-   "--date=auto" can be used to use this new format when the output is
-   going to the pager or to the terminal and otherwise the default
-   format.
+   "--date=auto:human" can be used to use this new format (or any
+   existing format) when the output is going to the pager or to the
+   terminal, and otherwise the default format.
 
 
 Performance, Internal Implementation, Development Support etc.
-- 
2.21.0.rc0.568.gbf84974d35

