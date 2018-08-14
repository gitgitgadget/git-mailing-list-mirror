Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502F21F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeHNWzB (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:55:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:55252 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728034AbeHNWzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:55:01 -0400
Received: (qmail 3553 invoked by uid 109); 14 Aug 2018 20:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 20:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25686 invoked by uid 111); 14 Aug 2018 20:06:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 16:06:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 16:06:11 -0400
Date:   Tue, 14 Aug 2018 16:06:11 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit
 planning)
Message-ID: <20180814200611.GG28452@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
 <20180813210617.GA19738@sigill.intra.peff.net>
 <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>
 <20180813215431.GB16006@sigill.intra.peff.net>
 <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>
 <20180814193646.GC28452@sigill.intra.peff.net>
 <CAGZ79kZYx-BOpx8SWeaP2Zskw0-OsSSVPZB4QJerAu9ST2swaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZYx-BOpx8SWeaP2Zskw0-OsSSVPZB4QJerAu9ST2swaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 12:47:59PM -0700, Stefan Beller wrote:

> On Tue, Aug 14, 2018 at 12:36 PM Jeff King <peff@peff.net> wrote:
> 
> > Thanks, it was nice to see a more comprehensive list in one spot.
> >
> > It would be neat to have a tool that presents all of these
> > automatically, but I think the email ones are pretty tricky (most people
> > don't have the whole list archive sitting around).
> 
> With the advent of public inbox, this is easy to obtain?

For our project, yes. But I was thinking of a tool that could be used
for other projects, too.

> > At one point I sent a patch series that would let shortlog group by
> > trailers. Nobody seemed all that interested and I didn't end up using it
> > for its original purpose, so I didn't polish it further.  But I'd be
> > happy to re-submit it if you think it would be useful.
> 
> I would think it is useful. Didn't Linus also ask for a related thing?
> https://public-inbox.org/git/CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com/

He wanted grouping by committer, which we ended up adding as a separate
feature. I think there's some discussion of the trailer thing in that
thread.

-Peff
