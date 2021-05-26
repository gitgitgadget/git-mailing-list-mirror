Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4812C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8569F613D8
	for <git@archiver.kernel.org>; Wed, 26 May 2021 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhEZPzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 11:55:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:37582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhEZPzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 11:55:08 -0400
Received: (qmail 31427 invoked by uid 109); 26 May 2021 15:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 May 2021 15:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24933 invoked by uid 111); 26 May 2021 15:53:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 May 2021 11:53:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 May 2021 11:53:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>,
        Avar =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: CI: 'seen' minus a few passes tests, eh, almost
Message-ID: <YK5u/qxFJUr9d/qS@coredump.intra.peff.net>
References: <xmqqcztecuy7.fsf@gitster.g>
 <xmqqzgwiawm4.fsf@gitster.g>
 <YK5dubBcSwm9c4Ta@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YK5dubBcSwm9c4Ta@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 10:39:53AM -0400, Taylor Blau wrote:

> On Wed, May 26, 2021 at 02:32:19PM +0900, Junio C Hamano wrote:
> > Just with a hunch, I further excluded tb/multi-pack-bitmaps from
> > 'seen', in addition to these four topics.  It seems to pass the
> > whole test suite on both 32- and 64-bit build combinations.
> >
> >     https://github.com/git/git/actions/runs/877225207
> >
> > Except that vs-build sometimes fails to download the sdk, that is.
> 
> Thanks for letting me know. I have accumulated a few local changes that
> I wanted to include in a reroll of that topic, but I was waiting on
> other reviewer eyes before sending it.

I think the best thing in a situation like this (where reviewers like me
have been very slow to respond) is to repost it explaining the
situation. That makes it clear what the current state is, and brings it
to the forefront of the list's attention (both reviewers you'd expect to
look at it, but people in general). Doing that too often can be
obnoxious, of course, but after 6-8 weeks saying "hey, this didn't get
attention; can anybody take a look at it?" is perfectly reasonable.

> I should be able to spend some more time pushing that topic forward
> after the release. There are a few other patch series waiting on it from
> GitHub, too.

But yeah, waiting until after the release is good, to keep attention on
regression fixes in the meantime.

-Peff
