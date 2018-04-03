Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A5B1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 23:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeDCXTG (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 19:19:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:52888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753747AbeDCXTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 19:19:05 -0400
Received: (qmail 25311 invoked by uid 109); 3 Apr 2018 23:19:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 23:19:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 445 invoked by uid 111); 3 Apr 2018 23:20:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 19:20:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 19:19:03 -0400
Date:   Tue, 3 Apr 2018 19:19:03 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
Message-ID: <20180403231903.GA9107@sigill.intra.peff.net>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403165143.80661-3-dstolee@microsoft.com>
 <20180403180536.GB100220@google.com>
 <20180403182800.GA8377@sigill.intra.peff.net>
 <08d3c9dd-3589-5c1c-4cea-982e8ed28f3e@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08d3c9dd-3589-5c1c-4cea-982e8ed28f3e@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 12:17:06AM +0100, Ramsay Jones wrote:

> >> Is there any reason to believe this would be too small of a value in the
> >> future?  Or is a 32 bit unsigned good enough?
> > 
> > The linux kernel took ~10 years to produce 500k commits. Even assuming
> > those were all linear (and they're not), that gives us ~80,000 years of
> > leeway. So even if the pace of development speeds up or we have a
> > quicker project, it still seems we have a pretty reasonable safety
> > margin.
> 
> I didn't read the patches closely, but isn't it ~20,000 years?
> 
> Given that '#define GENERATION_NUMBER_MAX 0x3FFFFFFF', that is. ;-)

What, I'm supposed to read the patches before responding? Heresy.

-Peff
