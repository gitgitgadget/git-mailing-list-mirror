Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEADC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D984D61166
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhF3RJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:37514 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232335AbhF3RJD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:09:03 -0400
Received: (qmail 24353 invoked by uid 109); 30 Jun 2021 17:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 17:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8903 invoked by uid 111); 30 Jun 2021 17:06:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 13:06:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 13:06:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
Message-ID: <YNykmFejFG8cEjue@coredump.intra.peff.net>
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
 <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
 <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
 <87eecmgrnx.fsf@evledraar.gmail.com>
 <YNvT+tUlW98dQY3B@coredump.intra.peff.net>
 <xmqq5yxvvq7k.fsf@gitster.g>
 <YNwd6wmt4FTyySgH@coredump.intra.peff.net>
 <874kdfg32w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kdfg32w.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 10:27:16AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I'm not sure. I think the topic would have graduated if either you had
> > just applied the squash and merged it down, or if the original author
> > had checked back in over the intervening year to say "hey, what happened
> > to my patch" (either by reading "what's cooking" or manually).
> >
> > I suspect drive-by contributors might not realize they need to do the
> > latter in some cases, but I wouldn't have counted 2014-era Ævar in that
> > boat. So I dunno.
> 
> Or maybe the moral of the story that it's a net addition of complexity
> to git-add--interactive.perl. If I didn't care enough to remember or
> notice the issue again maybe it wasn't all that important to begin with.
> 
> Likewise when it got ejected nobody else seemed to notice/care enough to
> say "hey I liked that feature" & to pick it up.

Yeah, that's probably a fair interpretation, too. :)

> I'd entirely forgotten I wrote that. Now that I'm reminded of it I don't
> care enough myself to rebase it, test it again, and especially not to
> figure out if/how it's going to interact with the new C implementation /
> add and adjust a test for the two.
> 
> But maybe someone else will, it would be neat if someone has more of an
> itch from the lack of that feature & wants to pick it up.

I can probably save you a little time/mental energy here: the C version
already does what your patch was trying to do. Once we switch to it as
the default, your patch would be obsolete anyway. :)

-Peff
