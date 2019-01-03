Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6989D1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 04:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfACEyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 23:54:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:53420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726058AbfACEyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 23:54:01 -0500
Received: (qmail 18422 invoked by uid 109); 3 Jan 2019 04:54:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 04:54:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7493 invoked by uid 111); 3 Jan 2019 04:53:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 02 Jan 2019 23:53:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jan 2019 23:53:59 -0500
Date:   Wed, 2 Jan 2019 23:53:59 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] test-lib: parse some --options earlier
Message-ID: <20190103045359.GC20047@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181209225628.22216-3-szeder.dev@gmail.com>
 <20181211110919.GC8452@sigill.intra.peff.net>
 <20181211124245.GT30222@szeder.dev>
 <20181217214436.GB14251@sigill.intra.peff.net>
 <20181230190419.GB6120@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181230190419.GB6120@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 30, 2018 at 08:04:19PM +0100, SZEDER Gábor wrote:

> > (in fact, given that this is just
> > the internal tests, I am tempted to say that we should just make it
> > "-r<arg>" for the sake of simplicity and consistency. But maybe somebody
> > would be annoyed. I have never used "-r" ever myself).
> 
> I didn't even know what '-r' does...

I had to look it up, too. :)

> And I agree that changing it to '-r<arg>' would be the best, but this
> patch series is about adding '--stress', so changing how '-r' gets its
> mandatory argument (and potentially annoying someone) is beyond the
> scope, I would say.

OK, I'm fine with that (though once we've built the infrastructure to
handle its unstuck form, I don't know if there's much point in changing
it, so we can probably just let it live on forever).

-Peff
