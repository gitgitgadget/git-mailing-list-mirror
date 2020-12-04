Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4581AC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD6122CA1
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgLDSuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:50:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:51774 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgLDSuF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 13:50:05 -0500
Received: (qmail 31736 invoked by uid 109); 4 Dec 2020 18:49:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 18:49:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13967 invoked by uid 111); 4 Dec 2020 18:49:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 13:49:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 13:49:24 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/9] t0064: drop sha1 mention from filename
Message-ID: <X8qEtPrZCTrMiX/t@coredump.intra.peff.net>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The data type is an oid_array these days, and we are using "test-tool
oid-array", so let's name the test script appropriately.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/{t0064-sha1-array.sh => t0064-oid-array.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t0064-sha1-array.sh => t0064-oid-array.sh} (96%)

diff --git a/t/t0064-sha1-array.sh b/t/t0064-oid-array.sh
similarity index 96%
rename from t/t0064-sha1-array.sh
rename to t/t0064-oid-array.sh
index 45685af2fd..71034a8007 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-oid-array.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='basic tests for the SHA1 array implementation'
+test_description='basic tests for the oid array implementation'
 . ./test-lib.sh
 
 echoid () {
-- 
2.29.2.896.g080220a959

