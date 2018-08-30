Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE7D91F404
	for <e@80x24.org>; Thu, 30 Aug 2018 03:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH3HQI (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 03:16:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:33408 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727417AbeH3HQI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 03:16:08 -0400
Received: (qmail 1971 invoked by uid 109); 30 Aug 2018 03:16:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 03:16:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22033 invoked by uid 111); 30 Aug 2018 03:16:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 23:16:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 23:16:08 -0400
Date:   Wed, 29 Aug 2018 23:16:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180830031607.GB665@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <8736uxe2pm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736uxe2pm.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 03:12:37PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >   2. To get our landing page and list of projects in order (and also
> >      micro-projects for applicants). This can probably build on the
> >      previous round at:
> >
> >        https://git.github.io/Outreachy-15/
> >
> >      and on the project/microprojects lists for GSoC (which will need
> >      some updating and culling).
> [...]
> I just have a "yes" to the first one of those. Which tells you how much
> skin I have in the game (and how much you should(n't) listen to me) :)

Yes, if nobody steps up to do 2, then it won't happen. :)

For myself, I don't think I have time to commit to mentoring this round.
And IMHO the people signing up to mentor should be the ones contributing
to the project list (since they will ultimately be on the hook for
working on those projects with the intern).

> Just a question: It seems to me that #1 and #2 is not tied up to the
> Outreachy process. I agree that finding a qualified intern to work on
> Git would be a good use of project funds.
> 
> What's not clear to me is if/how tied up this needs to be to a specific
> external program such as Outreachy. I.e. do we as a project need to go
> through that organization, or can that be just one of the ways in which
> we send out a call for interns?

It doesn't need to be. As far as I know, the main reasons (from the
perspective of a project) to do it through Outreachy are:

 - being part of a larger program generates attention and gets the
   interest of intern candidates (free advertising, if you will)

 - Outreachy handles payment, invoicing for external funds, and any
   legal stuff

 - it's possibly easier to external funding if it's earmarked for a
   program like Outreachy, since that program provides a framework with
   particular goals, conditions, oversight, etc.

I think there's some general value in having a group, too. Because there
are many interns all participating at the same time, they can offer each
other support or advice, show off their work to each other via blog
posts, etc. And it may be easier for them to communicate about their
accomplishments and status for future work, since it's part of an
established program that can easily be explained.

As for reasons _not_ to do it, I don't think the requirements are particularly
onerous. Mostly it's:

  - it has to happen at a specific time, which might not be convenient
    for mentors or interns (last year I found it hard to get focused
    starting in December, with all of the holidays)

  - it naturally limits the candidate pool to under-represented groups
    (which is the whole point of the program, but if you don't
    actually care about that, then it's just a complication)

So IMHO it's easily worth the trouble.

> With GSoC we don't have a choice in the matter, since Google's paying
> the bills and runs the show, but it sounds like in this case we at least
> partially do.

I think that the autonomy and level of responsibility for the
mentors/project is about the same between GSoC and Outreachy. The main
difference is just the funding model (but again, I suspect we would not
have too much trouble securing external funding).

-Peff
