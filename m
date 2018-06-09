Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41BB91F403
	for <e@80x24.org>; Sat,  9 Jun 2018 07:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeFIHbf (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 03:31:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:39888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753019AbeFIHbf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 03:31:35 -0400
Received: (qmail 22889 invoked by uid 109); 9 Jun 2018 07:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 07:31:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1496 invoked by uid 111); 9 Jun 2018 07:31:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 03:31:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 03:31:32 -0400
Date:   Sat, 9 Jun 2018 03:31:32 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180609073132.GA1554@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
 <CACsJy8BPhzs5M4peHN2HczmDxGmAuKZ0corzT66i+rJ2UQRTHQ@mail.gmail.com>
 <20180609065132.GD30224@sigill.intra.peff.net>
 <208bcf92-cc23-d63d-3dfc-441e960e1e02@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <208bcf92-cc23-d63d-3dfc-441e960e1e02@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 09:04:16AM +0200, Johannes Sixt wrote:

> > AFAICT this telemetry data is the same thing, but for performance. When
> > somebody says "why does this command take so long", wouldn't it be nice
> > for us to be able to tell them to flip a switch that will collect data
> > on which operations are taking a long time?
> 
> Why do we need long-term survaillance to answer this question and why can it
> not be made a mode of GIT_TRACE?

I guess I don't see how this isn't simply a mode of GIT_TRACE.

-Peff
