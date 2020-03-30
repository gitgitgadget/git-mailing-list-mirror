Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF9C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C152073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgC3OEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:04:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:55642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727191AbgC3OEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:04:14 -0400
Received: (qmail 15189 invoked by uid 109); 30 Mar 2020 14:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:04:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18781 invoked by uid 111); 30 Mar 2020 14:14:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:14:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:04:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] oidset: stop referring to sha1-array
Message-ID: <20200330140413.GG2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ths has been oid_array for some time, though the source only recently
moved from sha1-array.[ch] to oid-array.[ch]. In either case, we should
say "oid-array" here.

Signed-off-by: Jeff King <peff@peff.net>
---
 oidset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/oidset.h b/oidset.h
index d8a106b127..3a2d9d1115 100644
--- a/oidset.h
+++ b/oidset.h
@@ -4,7 +4,7 @@
 #include "khash.h"
 
 /**
- * This API is similar to sha1-array, in that it maintains a set of object ids
+ * This API is similar to oid-array, in that it maintains a set of object ids
  * in a memory-efficient way. The major differences are:
  *
  *   1. It uses a hash, so we can do online duplicate removal, rather than
-- 
2.26.0.597.g7e08ed78ff
