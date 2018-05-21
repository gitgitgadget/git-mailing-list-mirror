Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FCA71F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754357AbeEUVwU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:52:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754303AbeEUVwS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:52:18 -0400
Received: (qmail 32714 invoked by uid 109); 21 May 2018 21:52:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 21:52:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32118 invoked by uid 111); 21 May 2018 21:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 21 May 2018 17:52:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2018 17:52:16 -0400
Date:   Mon, 21 May 2018 17:52:16 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180521215216.GB16623@sigill.intra.peff.net>
References: <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
 <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
 <20180507074843.GC31170@sigill.intra.peff.net>
 <3cefc6b3-3dbd-9cb1-20d0-193116191726@gmail.com>
 <nycvar.QRO.7.76.6.1805211153370.77@tvgsbejvaqbjf.bet>
 <CAGZ79kYcWuVorfk7eYjUuLi2XeMS8sPrJYE0OQmgiQi2NkuDZA@mail.gmail.com>
 <20180521202414.GA14250@sigill.intra.peff.net>
 <20180521214057.GB125693@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180521214057.GB125693@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 02:40:57PM -0700, Brandon Williams wrote:

> > > > Most fellow German software engineers (who seem to have a knack for
> > > > idiotically long variable/function names) would now probably suggest:
> > > >
> > > >         git compare-patch-series-with-revised-patch-series
> > > 
> > > or short:
> > > 
> > >   revision-compare
> > >   compare-revs
> > >   com-revs
> > > 
> > >   revised-diff
> > >   revise-diff
> > >   revised-compare
> > > 
> > >   diff-revise
> 
> I haven't really been following all of the discussion but from what I
> can tell the point of this command is to generate a diff based on two
> different versions of a series, so why not call it 'series-diff'? :)

That's OK with me, though I prefer "range" as I think we use that term
elsewhere ("series" is usually part of "patch series", but many people
do not use a workflow with that term).

-Peff
