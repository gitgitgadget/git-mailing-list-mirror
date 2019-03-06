Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4536420248
	for <e@80x24.org>; Wed,  6 Mar 2019 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfCFUD7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 15:03:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729844AbfCFUD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 15:03:58 -0500
Received: (qmail 30439 invoked by uid 109); 6 Mar 2019 20:03:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 20:03:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16824 invoked by uid 111); 6 Mar 2019 20:04:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 15:04:16 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 15:03:56 -0500
Date:   Wed, 6 Mar 2019 15:03:56 -0500
From:   Jeff King <peff@peff.net>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190306200356.GB23315@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
 <20190304204007.GA32691@sigill.intra.peff.net>
 <20190305191519.GA12791@sigill.intra.peff.net>
 <1551902320.1727.1.camel@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551902320.1727.1.camel@libero.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 08:58:40PM +0100, Fabio Aiuto wrote:

> Yes the fetch command wasn't written at that time, right? I didn't
> understand why should be better to work with the git code from github.
> There's something I misunderstood?

I just mean that it is an interesting fact that modern Git and Git v1.0
can still interact seamlessly over the network. I.e., you could still
collaborate with somebody using an ancient version of Git (hopefully
nobody is using v1.0, but logically it extends to all of the
intermediate versions).

-Peff
