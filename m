Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B67C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721D86113A
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 14:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhIKOxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 10:53:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:44972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhIKOxx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 10:53:53 -0400
Received: (qmail 12552 invoked by uid 109); 11 Sep 2021 14:52:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 14:52:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20950 invoked by uid 111); 11 Sep 2021 14:52:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 10:52:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 10:52:40 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gwyneth Morgan <gwymor@tilde.club>, Fangyi Zhou <me@fangyi.io>,
        git@vger.kernel.org
Subject: Re: [PATCH] .mailmap: Update mailmap
Message-ID: <YTzCuAWCJESyxIfU@coredump.intra.peff.net>
References: <20210910130236.40101-1-me@fangyi.io>
 <YTt4RymWg+TOEmUf@tilde.club>
 <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
 <xmqqa6kkosst.fsf@gitster.g>
 <87czpfc2j6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czpfc2j6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[culling cc list as earlier]

On Sat, Sep 11, 2021 at 03:31:49AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Whereas most if not all edits to this file are likely to be janitorial
> work such as de-duplicating E-Mail addresses, or cases where the people
> involved even if they can't be contacted have already shared this
> information unambiguously with the world, it just happens to be in the
> mailing list archive, not in .mailmap.
> 
> E.g. I'd think these were fine, even assuming you can't contact the
> parties involved:
> 
>  * The ML history reveals someone who's clearly the same person was
>    using N E-Mail addresses in succession, we should probably map it all
>    to the latest one, unclutters shortlog and the like.

Just playing devil's advocate for a moment. What about people who have
used two different identities because they were contributing in two
different capacities (say, one from a work email, where they want to
continue to credit that entity, and then later from a personal email).

That works against the goal of "you can easily email the person from an
old commit". But it seems reasonable to respect their wishes there
(e.g., they may not _want_ to deal with old contributions submitted
as part of work).

The root of the problem is that we don't know their wishes, so we are
making an assumption when a third party proposes the change.

-Peff
