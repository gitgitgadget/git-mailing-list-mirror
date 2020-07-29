Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78CC433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F8E206D7
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgG2UL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:11:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:41510 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2UL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:11:29 -0400
Received: (qmail 8838 invoked by uid 109); 29 Jul 2020 20:11:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:11:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7863 invoked by uid 111); 29 Jul 2020 20:11:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:11:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:11:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 5/7] doc/git-log: drop "-r" diff option
Message-ID: <20200729201127.GE2989342@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has been the default since 170c04383b (Porcelain level "log" family
should recurse when diffing., 2007-08-27). There's not even a way to
turn it off, so you'd never even want "-r" to override that.

It's not the default for plumbing like diff-tree, of course, but the
option is documented separately there.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-log.txt | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index fb3998d8e0..2cbe636b2b 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -146,11 +146,8 @@ below can be used to show the changes made by each commit.
 	in that case, the output represents the changes the merge
 	brought _into_ the then-current branch.
 
--r::
-	Show recursive diffs.
-
 -t::
-	Show the tree objects in the diff output. This implies `-r`.
+	Show the tree objects in the diff output.
 
 :git-log: 1
 include::diff-options.txt[]
-- 
2.28.0.465.gd2839157e3

