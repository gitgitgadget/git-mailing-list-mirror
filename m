Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF113C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782AA23406
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLGTLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:11:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:55232 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgLGTLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:11:11 -0500
Received: (qmail 8990 invoked by uid 109); 7 Dec 2020 19:10:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Dec 2020 19:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25645 invoked by uid 111); 7 Dec 2020 19:10:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Dec 2020 14:10:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Dec 2020 14:10:30 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/9] oid-array.h: drop sha1 mention from header guard
Message-ID: <X85+Jlz/bjbuqTJq@coredump.intra.peff.net>
References: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When this file was moved from sha1-array.h, we forgot to update the
preprocessor header guard to match the new name.

Signed-off-by: Jeff King <peff@peff.net>
---
 oid-array.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/oid-array.h b/oid-array.h
index f28d322c90..2c8b64c393 100644
--- a/oid-array.h
+++ b/oid-array.h
@@ -1,5 +1,5 @@
-#ifndef SHA1_ARRAY_H
-#define SHA1_ARRAY_H
+#ifndef OID_ARRAY_H
+#define OID_ARRAY_H
 
 /**
  * The API provides storage and manipulation of sets of object identifiers.
@@ -106,4 +106,4 @@ void oid_array_filter(struct oid_array *array,
 		      for_each_oid_fn want,
 		      void *cbdata);
 
-#endif /* SHA1_ARRAY_H */
+#endif /* OID_ARRAY_H */
-- 
2.29.2.980.g762a4e4ed3

