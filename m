Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0CBEC8750
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 19:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjIGTLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjIGTLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 15:11:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E49D
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 12:11:09 -0700 (PDT)
Received: (qmail 27180 invoked by uid 109); 7 Sep 2023 08:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 08:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24440 invoked by uid 111); 7 Sep 2023 08:04:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 04:04:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 04:04:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 5/8] builtin/repack.c: extract
 `has_existing_non_kept_packs()`
Message-ID: <20230907080428.GE1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <e2cf87bb94da1a777f6b87ae3f32e036832839a6.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2cf87bb94da1a777f6b87ae3f32e036832839a6.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:51PM -0400, Taylor Blau wrote:

> But a following change will store cruft- and non-cruft packs separately,
> meaning this check would break as a result. Prepare for this by
> extracting this part of the check into a new helper function called
> `has_existing_non_kept_packs()`.
> 
> This patch does not introduce any functional changes, but prepares us to
> make a more isolated change in a subsequent patch.

OK, that makes sense.

-Peff
