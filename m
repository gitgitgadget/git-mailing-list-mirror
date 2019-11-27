Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F46C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848D321555
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfK0UZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:25:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60338 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfK0UZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:25:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D65B61F463;
        Wed, 27 Nov 2019 20:25:31 +0000 (UTC)
Date:   Wed, 27 Nov 2019 20:25:31 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Git at SFC <git@sfconservancy.org>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>
Subject: Re: This list is now also archived on lore.kernel.org/git
Message-ID: <20191127202531.GA12201@dcvr>
References: <20191120154347.x6w4v7cdzy4yrx6q@chatter.i7.local>
 <20191120195556.GA25189@dcvr>
 <87woblnxnc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87woblnxnc.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Nov 20 2019, Eric Wong wrote:
> > Yup,  .org TLD renewal costs will likely go up and I won't pay
> > higher costs to keep .org domains.
> >
> > The system running public-inbox.org (and the recommended
> > onions(*)) will stay running and will have bleeding edge
> > code on it.
> >
> >
> > * Accessible via Tor, no need to depend on registrars:
> >   http://hjrcffqmbrq6wope.onion/
> >   http://ou63pmih66umazou.onion/
> >   http://czquwvybam4bgbro.onion/
> 
> I think it would make sense for the Git SFC arm of things[1] to consider
> taking over the public-inbox.org domain rather than letting it expire
> (of course contingent on your approval) and turning it into a CNAME (or
> other redirect) for lore.kernel.org.

There's also https://public-inbox.org/meta/ and other (FLOSS-related)
mirrors and the root landing page itself.

> We have a lot of mailing list and some (~130 commits) git.git commit
> references to that domain. It seems like a worthwhile expense to me to
> pay for the renewal of it rather than having it turn into e.g. some spam
> landing page as the registration expires.

One feature I'd like to see in public-inbox and even git
porcelain and web viewers is the ability to rewrite URLs on the
client-side, similar to .mailmap.  It would make sense they all
share the same configuration.

> 1. Disclaimer: I'm one of the people who'd vote on making that decision
>    if it came to that, but this E-Mail is, as they say, just like, my
>    opinion, man :)

Fwiw, I intentionally keep the branding of the public-inbox
project weak (no trademarks, logos, real homepage) because I
believe strong branding and consolidation of influence/identity
leads to centralization.  It's easier to fork projects when
there's no logos, trademarks or other branding to deal with.

I also believe the term "public inbox" is a much more powerful
idea than any project could be.  To that end, I'm happy
SourceHut (and maybe others) also use that term.  The
"public-inbox" project is just one cheapskate's anti-consumerist
interpretation of that idea :>

I pretty much say whatever I can to sabotage my own credibility
as a result.  I'm also shy and introverted, so branding and good
marketing does not compute :P
