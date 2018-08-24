Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF501F404
	for <e@80x24.org>; Fri, 24 Aug 2018 06:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHXKS2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 06:18:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:54296 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726198AbeHXKS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 06:18:28 -0400
Received: (qmail 13924 invoked by uid 109); 24 Aug 2018 06:45:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 06:45:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24202 invoked by uid 111); 24 Aug 2018 06:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 Aug 2018 02:45:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2018 02:45:13 -0400
Date:   Fri, 24 Aug 2018 02:45:13 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git mailing list <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180824064512.GA10521@sigill.intra.peff.net>
References: <20180823034707.GD535143@genre.crustytoothpaste.net>
 <20180823050418.GB318@sigill.intra.peff.net>
 <f854aba0-6d28-7f2b-aad2-858983c4af36@gmail.com>
 <20180823161451.GB29579@sigill.intra.peff.net>
 <CA+P7+xqbt_BVi9+1-4=ha64LW_07dJB84F0gjKd9TRE1R-Ld7A@mail.gmail.com>
 <20180823234049.GA3855@sigill.intra.peff.net>
 <20180824000637.GA10847@sigill.intra.peff.net>
 <20180824001643.GA14259@sigill.intra.peff.net>
 <CA+P7+xpm-gsjCpPOZ=2z03Peb1Jb6axKo2nTp=UUpAFgWNureg@mail.gmail.com>
 <20180824025955.GA24535@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824025955.GA24535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 10:59:55PM -0400, Jeff King wrote:

> So I think we have a winner. I'll polish that up into patches and send
> it out later tonight.

Oof. This rabbit hole keeps going deeper and deeper. I wrote up my
coccinelle findings separately in:

  https://public-inbox.org/git/20180824064228.GA3183@sigill.intra.peff.net/

which is possibly a coccinelle bug (there I talked about oidcmp, since
it can be demonstrated with the existing transformations, but the same
thing happens with my hasheq patches). I'll wait to see how that
discussion plays out, but I do otherwise have hasheq() patches ready to
go, so it's probably not worth anybody else digging in further.

-Peff
