Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF281F731
	for <e@80x24.org>; Tue,  6 Aug 2019 13:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbfHFN1b (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 09:27:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:35282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726036AbfHFN1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 09:27:31 -0400
Received: (qmail 16969 invoked by uid 109); 6 Aug 2019 13:27:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 13:27:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1761 invoked by uid 111); 6 Aug 2019 13:29:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 09:29:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 09:27:30 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>
Subject: Re: RFC - Git Developer Blog
Message-ID: <20190806132730.GC18442@sigill.intra.peff.net>
References: <20190806014935.GA26909@google.com>
 <xmqqlfw7klwk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD1XNGWf8=_LvrEsFswZdw5pydk2VyVWxWvwALfhVbBOsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1XNGWf8=_LvrEsFswZdw5pydk2VyVWxWvwALfhVbBOsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 06:59:21AM +0200, Christian Couder wrote:

> When Git Rev News was started I thought that there could be such a
> group effort to encourage each other to publish articles in it, but I
> must say that outside the group of editors (currently Jakub, Markus,
> Gabriel and me) it hasn't happened much.
> 
> Each month though there are a small number of people helping on
> smaller things like short news, typos, releases, etc. And people who
> are interviewed are doing a great job when they accept to be
> interviewed.
> 
> Maybe it's also not clear that we could accept other kind of articles
> than just articles focused on what happens on the mailing list. I
> think we have generally tried to highlight articles by Git developers
> that were published on their blogs or their company's blog though.

I think the audience may be a bit different for Rev News versus a blog.
I'd expect the blog to be written for people who use Git, and want to
learn how to use new features, or maybe broaden their understanding of
it. Rev News seems a lot more technical to me, and mostly of interest to
people who are part of the development community.

Which isn't to say those two things can't co-exist on a site[1] or a
blog. But I think there needs to be some way for people to subscribe to
one but not the other. Because I suspect that too many posts about the
development process would drive away users who would be interested in
the less-technical posts.

-Peff

[1] By the way, Rev News lives over at git.github.io, but there's no
    reason it couldn't be integrated (from the user's perspective) with
    the git-scm.org site.

    I wouldn't want it in the same repo for technical reasons, but it
    could be revnews.git-scm.com or similar (and possibly styled in a
    similar way).

    If you're happy with it separate, I have no objections. I just
    wanted to make it clear it's an option.
