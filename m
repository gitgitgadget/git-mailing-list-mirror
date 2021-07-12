Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E39C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C454A61106
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhGLVob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 17:44:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:47136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhGLVo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 17:44:28 -0400
Received: (qmail 23103 invoked by uid 109); 12 Jul 2021 21:41:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 21:41:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2843 invoked by uid 111); 12 Jul 2021 21:41:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 17:41:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 17:41:38 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
Message-ID: <YOy3Eo+NuODKDjXf@coredump.intra.peff.net>
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
 <YOx43fqGyQMy7+tR@coredump.intra.peff.net>
 <CABPp-BEdUmxXVCx=5pb0=LN-0YBtrEB-wngPC5vys6fjVctgaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEdUmxXVCx=5pb0=LN-0YBtrEB-wngPC5vys6fjVctgaQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 01:23:38PM -0700, Elijah Newren wrote:

> > > * The feedback about the limit is better today than when we last changed
> > >   the limits, and folks can configure a higher limit relatively easily.
> > >   Many already have.
> >
> > I can't remember the last time I saw the limit kick in in practice, but
> > then I don't generally work with super-large repos (and my workflows
> > typically do not encourage merging across big segments of history).
> > Nor do I remember the topic coming up on the list after the last bump.
> > So maybe that means that people are happily bumping the limits
> > themselves via config.
> 
> It might also mean that you're missing more emails than you used to,
> or just forgot them.  :-)
> 
> e.g.:
> https://lore.kernel.org/git/20171129201154.192379-1-jonathantanmy@google.com/
> https://lore.kernel.org/git/20171113201600.24878-1-newren@gmail.com/
> 
> But I do certainly suspect it's come up less often than it would have before.

Oh, indeed. Thanks for some counterexamples. :)

-Peff
