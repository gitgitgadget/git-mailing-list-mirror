Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD14EE0213
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 00:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjINAH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 20:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjINAH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 20:07:57 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF66E6B
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 17:07:52 -0700 (PDT)
Received: (qmail 25457 invoked by uid 109); 14 Sep 2023 00:07:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 00:07:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1579 invoked by uid 111); 14 Sep 2023 00:07:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Sep 2023 20:07:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Sep 2023 20:07:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
Message-ID: <20230914000750.GA1709736@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
 <cover.1694632644.git.me@ttaylorr.com>
 <xmqqa5tpluyj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5tpluyj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2023 at 12:44:04PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Here is a small reroll of my series to clean up some of the internals of
> > 'git repack' used to track the set of existing packs.
> >
> > Much is unchanged from the last round, save for some additional clean-up
> > on how we handle the '->util' field for each pack's string_list_item in
> > response to very helpful review from those CC'd.
> 
> The change to [7/8] was as expected and looking good.  Let's see if
> we see additional reviews from others, plan to declare victory and
> merge it to 'next' by early next week at the latest, if not sooner.

This looks great to me. The motivation in the revised patch 7 is much
easier to follow, and the end result is much nicer to read. :)

-Peff
