Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF521F404
	for <e@80x24.org>; Wed, 29 Aug 2018 05:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeH2I5I (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 04:57:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726188AbeH2I5I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 04:57:08 -0400
Received: (qmail 14849 invoked by uid 109); 29 Aug 2018 05:02:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 05:02:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10127 invoked by uid 111); 29 Aug 2018 05:02:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 01:02:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 01:02:03 -0400
Date:   Wed, 29 Aug 2018 01:02:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Contributor Summit planning
Message-ID: <20180829050203.GC15274@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1808280046300.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1808280046300.73@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 12:49:55AM +0200, Johannes Schindelin wrote:

> On Mon, 13 Aug 2018, Ævar Arnfjörð Bjarmason wrote:
> 
> >  * Re the second half of "Not everyone can travel or can afford to do
> >    so" from Derrick, there's been travel sponsorships in past years.
> 
> Just to make sure that you understand: there are many more reasons than
> just travel costs involved. Just to name a few:
> 
> - visa issues.
> 
> - some people have to take care of family members and are not at liberty
>   to leave for even so much as half a day.
> 
> - conflicting schedules.
> 
> - mental health. As a friend of mine once put it: nobody is completely
>   "healthy", we all suffer, on a spectrum, from anxiety, trauma, and other
>   issues. The more inclusive we are, the more we can benefit from
>   everybody's talents and contributions.
> 
> Just saying. Money is sometimes not the solution.

Thanks for bringing this up. It's very easy to forget that not everybody
is in exactly the same situation.

It's actually one of the things I worry _most_ about having an in-person
meeting: that it ends up widening the gap between people whose employer
is sponsoring their work on Git, and people who have to carve their Git
time out of the rest of their busy lives.

Your virtual meeting idea is obviously meant to help with that. But
fundamentally I think allowing people to participate asynchronously is
the most important part, and we need to make sure there's some kind of
artifact summarizing any real-time meetings (for virtual stuff,
recordings or IRC logs are probably fine; for the in-person one, I was
very happy with the notes you took last year).

-Peff
