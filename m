Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D9D20281
	for <e@80x24.org>; Fri, 29 Sep 2017 23:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbdI2XkH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 19:40:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:55060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752505AbdI2XkF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 19:40:05 -0400
Received: (qmail 12544 invoked by uid 109); 29 Sep 2017 23:40:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 23:40:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9318 invoked by uid 111); 29 Sep 2017 23:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 29 Sep 2017 19:40:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Sep 2017 19:40:03 -0400
Date:   Fri, 29 Sep 2017 19:40:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170929234002.3fzaksoarz75p7e2@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
 <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
 <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
 <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
 <CAL21Bmma8gOYx9u4kxRaHJKcF3YsfrQP9=wdAiQX14f9uSPRAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bmma8gOYx9u4kxRaHJKcF3YsfrQP9=wdAiQX14f9uSPRAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 11:38:27PM +0300, Оля Тележная wrote:

> > About minor issues ( "tmp" vs "p2", variable scope, space indentation)
> > - fully agree, I will fix it.
> > ...
> > So finally I think that I need to fix that minor issues and that's
> > all.
> 
> I forgot about leak. I also need to add checking in mru_clear. That's
> not beautiful solution but it works reliably.

I'm not sure what you mean about checking in mru_clear(). It may make
sense to just send your v2 patch and I can see there what you do.

> Question remains the same - do you see something more to fix in this patch?

I think that's it. Think about writing a bit in the commit message about
the "why" of this. Like I said earlier, the rationale for this commit is
perhaps obvious, but it never hurts to be explicit (and it may be good
practice, since part of the point of this task is getting you familiar
with the patch submission process).

-Peff
