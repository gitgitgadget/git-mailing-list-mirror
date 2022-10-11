Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4507C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJKBgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJKBfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:35:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFBF84E42
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:35:31 -0700 (PDT)
Received: (qmail 30026 invoked by uid 109); 11 Oct 2022 01:35:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 01:35:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16249 invoked by uid 111); 11 Oct 2022 01:35:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 21:35:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 21:35:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 6/7] shortlog: implement `--group=committer` in terms of
 `--group=<format>`
Message-ID: <Y0TIWhr9PCcZQfK4@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <814ee4b8d8055269d9206847b0faf839816abf59.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <814ee4b8d8055269d9206847b0faf839816abf59.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:34:18PM -0400, Taylor Blau wrote:

> In the same spirit as the previous commit, reimplement
> `--group=committer` as a special case of `--group=<format>`, too.

Makes sense. This all looks as expected, but the same HAS_MULTI_BITS()
comment applies.

-Peff
