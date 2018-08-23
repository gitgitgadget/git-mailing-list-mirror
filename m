Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FF91F954
	for <e@80x24.org>; Thu, 23 Aug 2018 18:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeHWWYU (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 18:24:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:53684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726925AbeHWWYU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 18:24:20 -0400
Received: (qmail 19913 invoked by uid 109); 23 Aug 2018 18:53:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 18:53:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20034 invoked by uid 111); 23 Aug 2018 18:53:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 14:53:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 14:53:17 -0400
Date:   Thu, 23 Aug 2018 14:53:17 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180823185317.GA12534@sigill.intra.peff.net>
References: <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <814549a01074e89a4b26cb0cf13e4dddeb3a040a.camel@mad-scientist.net>
 <20180822152306.GC32630@sigill.intra.peff.net>
 <20180823012343.GB92374@aiede.svl.corp.google.com>
 <20180823021618.GA12052@sigill.intra.peff.net>
 <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 06:26:58AM -0400, Derrick Stolee wrote:

> > I think you can safely
> > ignore the rest of it if you are otherwise occupied. Even if v2.19 ships
> > without some mitigation, I don't know that it's all that big a deal,
> > given the numbers I generated (which for some reason are less dramatic
> > than Stolee's).
> My numbers may be more dramatic because my Linux environment is a virtual
> machine.

If you have a chance, can you run p0001 on my patch (compared to
2.19-rc0, or to both v2.18 and v2.19-rc0)? It would be nice to double
check that it really is fixing the problem you saw.

-Peff
