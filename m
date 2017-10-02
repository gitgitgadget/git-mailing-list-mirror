Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B4E202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 08:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbdJBIWQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 04:22:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:57414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750715AbdJBIWP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 04:22:15 -0400
Received: (qmail 14376 invoked by uid 109); 2 Oct 2017 08:22:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 08:22:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27040 invoked by uid 111); 2 Oct 2017 08:22:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 04:22:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 04:22:13 -0400
Date:   Mon, 2 Oct 2017 04:22:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20171002082213.bpnhql4rfl523p3t@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <20170928224244.pi34zwifnornssqk@sigill.intra.peff.net>
 <CAP8UFD13obkLWyuCGUpFxryr8DWfQ8W4JNn04ajO50PvF0SnXQ@mail.gmail.com>
 <20170929072354.fw4eclt56dmfj4a5@sigill.intra.peff.net>
 <CAP8UFD1-9dYSX-VKZSPN9Ei75V8mGC-wusieL45ArxxJ08tO9Q@mail.gmail.com>
 <CAL21BmkcVSEhEK+tAE-RNVabb0pnokYwbagueUrp9giZ3zqT8A@mail.gmail.com>
 <CAL21Bmma8gOYx9u4kxRaHJKcF3YsfrQP9=wdAiQX14f9uSPRAQ@mail.gmail.com>
 <20170929234002.3fzaksoarz75p7e2@sigill.intra.peff.net>
 <CAL21Bmk2oN61CxJA0eju=FtAh2Ei9dLqRMPZKonCND4sC504Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL21Bmk2oN61CxJA0eju=FtAh2Ei9dLqRMPZKonCND4sC504Sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 30, 2017 at 09:09:11PM +0300, Оля Тележная wrote:

> I added "v2" after "PATCH", but it does not appeared. Actually it was
> written automatically and it was "PATCH Outreachy v2". I rearranged it
> in the middle of the phrase.

That looks fine.

> > I'm not sure what you mean about checking in mru_clear(). It may make
> > sense to just send your v2 patch and I can see there what you do.
> 
> I realized that I said something strange before. I solved the problem
> with leak by deleting INIT in prepare_packed_git and adding init as
> you suggested here:
> https://github.com/telezhnaya/git/commit/7f8995835949f83e54efdfd88445feb6d54cb3e9#commitcomment-24576103

OK, that makes sense.

> By the way, I asked to edit FAQ for Linux kernel newbies about linked
> list that confused me a week ago, and that funny picture was deleted.
> https://kernelnewbies.org/FAQ/LinkedLists
> Maybe it will help to someone else :)

Thank you. :)

Remember (and this applies to other Outreachy folks, too) to submit your
application in the Outreachy system:

   https://outreachy.gnome.org

-Peff
