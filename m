Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0F4C11F66
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574D461284
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 22:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhGMWeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 18:34:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:48388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234665AbhGMWeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 18:34:18 -0400
Received: (qmail 13419 invoked by uid 109); 13 Jul 2021 22:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 22:31:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15249 invoked by uid 111); 13 Jul 2021 22:31:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 18:31:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 18:31:26 -0400
From:   Jeff King <peff@peff.net>
To:     Jason Hatton <jhatton@globalfinishing.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] doc/rev-list-options: fix duplicate word typo
Message-ID: <YO4UPsFWp/nivr6A@coredump.intra.peff.net>
References: <CY4PR16MB1655C5F8225B32A2029EADE2AF039@CY4PR16MB1655.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR16MB1655C5F8225B32A2029EADE2AF039@CY4PR16MB1655.namprd16.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 10:21:26PM +0000, Jason Hatton wrote:

> I believe I found a documentation typo.
> 
> Documentation/rev-list-options.txt
> 
> 898: The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
> 899: specification contained in the blob (or blob-expression) '<blob-ish>'
> 900: to omit blobs that would **not be not** required for a sparse checkout on
> 901: the requested refs.
> 
> I emphasized the "not be not" on line 900. I hope this is the correct place
> to report this.

Yep, it definitely looks like a typo. Thanks for reporting it!

-- >8 --
Subject: [PATCH] doc/rev-list-options: fix duplicate word typo

Reported-by: Jason Hatton <jhatton@globalfinishing.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5bf2a85f69..5200f18d2c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -897,7 +897,7 @@ which are not of the requested type.
 +
 The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
 specification contained in the blob (or blob-expression) '<blob-ish>'
-to omit blobs that would not be not required for a sparse checkout on
+to omit blobs that would not be required for a sparse checkout on
 the requested refs.
 +
 The form '--filter=tree:<depth>' omits all blobs and trees whose depth
-- 
2.32.0.663.g932e3f012f

