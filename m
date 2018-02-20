Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5E31F404
	for <e@80x24.org>; Tue, 20 Feb 2018 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBTVIZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 16:08:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:58650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750799AbeBTVIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 16:08:24 -0500
Received: (qmail 9327 invoked by uid 109); 20 Feb 2018 21:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Feb 2018 21:08:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17031 invoked by uid 111); 20 Feb 2018 21:09:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Feb 2018 16:09:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Feb 2018 16:08:22 -0500
Date:   Tue, 20 Feb 2018 16:08:22 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
Message-ID: <20180220210822.GA15010@sigill.intra.peff.net>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
 <20180214215637.6462-1-martin.agren@gmail.com>
 <20180219212937.GB9748@sigill.intra.peff.net>
 <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 09:44:51PM +0100, Martin Ågren wrote:

> For finding this sort of low-hanging fruit (windfall?) any local
> scripting and greping will do. I sort of hesitate wasting community CPU
> cycles on something which might be appreciated, in theory, but that
> doesn't have enough attention to move beyond "every now and then,
> something is fixed, but just as often, tests gain leaks and the
> blacklist gains entries".
> 
> To sum up: I probably won't be looking into Travis-ing such a blacklist
> in the near future.

Yeah, I think that's the right path for now. Hopefully we can get close
to zero leaks at some point, and then think about adding this kind of
infrastructure. Thanks for talking it through.

-Peff
