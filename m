Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56EE020C32
	for <e@80x24.org>; Fri,  8 Dec 2017 09:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdLHJDv (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 04:03:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:51856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751800AbdLHJDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 04:03:49 -0500
Received: (qmail 29627 invoked by uid 109); 8 Dec 2017 09:03:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 09:03:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30200 invoked by uid 111); 8 Dec 2017 09:04:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 04:04:10 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 04:03:46 -0500
Date:   Fri, 8 Dec 2017 04:03:46 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] hashmap: adjust documentation to reflect reality
Message-ID: <20171208090346.GB26199@sigill.intra.peff.net>
References: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
 <20171130030727.GA24732@sigill.intra.peff.net>
 <xmqqindojrw1.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbDevUjjAzvfa-Un6=fnFZu+kLx7bF3vuheXZdxJWvaRw@mail.gmail.com>
 <alpine.DEB.2.21.1.1712072244040.4318@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1712072244040.4318@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 10:47:43PM +0100, Johannes Schindelin wrote:

> > We could add that example to the test helper as then we have a good (tested)
> > example for that case, too.
> 
> What we could *also* do, and what would probably make *even more* sense,
> is to simplify the example drastically, to a point where testing it in
> test-hashmap is pointless, and where a reader can gather *very* quickly
> what it takes to use the hashmap routines.

Yes, I'd be in favor of that, too.

> In any case, I would really like to see my patch applied first, as it is a
> separate concern from what you gentle people talk about: I simply want
> that incorrect documentation fixed. The earlier, the better.

Definitely. I think it is in "next" already.

-Peff
