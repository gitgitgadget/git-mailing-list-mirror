Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E957AC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC916108E
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFJKtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:49:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJKtj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:49:39 -0400
Received: (qmail 7249 invoked by uid 109); 10 Jun 2021 10:47:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 10:47:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28411 invoked by uid 111); 10 Jun 2021 10:47:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 06:47:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 06:47:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #02; Sun, 6)
Message-ID: <YMHtzZe+cDW8KKoY@coredump.intra.peff.net>
References: <xmqq4kebxj2d.fsf@gitster.g>
 <87sg1t4usb.fsf@evledraar.gmail.com>
 <YMCMixVw+2G59yQH@coredump.intra.peff.net>
 <87fsxr2vwd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fsxr2vwd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 12:06:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > BTW, Ævar, are you planning to fix other -O3 problems? I happened to
> > notice some today. One is new in pu (and I sent a message in that
> > thread), but two are older. See this message from last year:
> >
> >   https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.peff.net/
> >
> > (amusingly, it also mentions your trace2 one!). I'm happy to send
> > patches, but I hadn't written them yet, and it occurred to me you might
> > already have done so.
> 
> There hasn't been much of anything new in pu for a while :)

Heh, you wouldn't believe the number of times I've typed "git checkout
origin/pu" in the last year. :)

> But no, please beat me to it. That trace2 one was a one-off I was
> tackling because I ran into it when compiling revisions under -O3 with
> t/perf/.

Thanks, I'll see if I can work something up.

-Peff
