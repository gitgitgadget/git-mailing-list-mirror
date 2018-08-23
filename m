Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E09A1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 05:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeHWIcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 04:32:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:52766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726267AbeHWIcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 04:32:10 -0400
Received: (qmail 21143 invoked by uid 109); 23 Aug 2018 05:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 05:04:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7655 invoked by uid 111); 23 Aug 2018 05:04:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 01:04:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 01:04:19 -0400
Date:   Thu, 23 Aug 2018 01:04:19 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823050418.GB318@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823034707.GD535143@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 03:47:07AM +0000, brian m. carlson wrote:

> I expect that's going to be the case as well.  I have patches that
> wire up actual SHA-256 support in my hash-impl branch.
> 
> However, having said that, I'm happy to defer to whatever everyone else
> thinks is best for 2.19.  The assert solution would be fine with me in
> this situation, and if we need to pull it out in the future, that's okay
> with me.
> 
> I don't really have a strong opinion on this either way, so if someone
> else does, please say so.  I have somewhat more limited availability
> over the next couple days, as I'm travelling on business, but I'm happy
> to review a patch (and it seems like Peff has one minus the actual
> commit message).

I just posted the patch elsewhere in the thread. I think you can safely
ignore the rest of it if you are otherwise occupied. Even if v2.19 ships
without some mitigation, I don't know that it's all that big a deal,
given the numbers I generated (which for some reason are less dramatic
than Stolee's).

-Peff
