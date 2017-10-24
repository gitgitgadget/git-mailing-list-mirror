Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDB4202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 01:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdJXBci (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 21:32:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:33530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751220AbdJXBch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 21:32:37 -0400
Received: (qmail 21453 invoked by uid 109); 24 Oct 2017 01:32:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 01:32:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6732 invoked by uid 111); 24 Oct 2017 01:32:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 21:32:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Oct 2017 18:32:35 -0700
Date:   Mon, 23 Oct 2017 18:32:35 -0700
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 0/3] making test-suite tracing more useful
Message-ID: <20171024013234.ogma2sf37c7hfpib@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1710231302480.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710231302480.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 01:04:45PM +0200, Johannes Schindelin wrote:

> > Johannes, I've seen that you do "-x" in the tests that the
> > git-for-windows bot uses to comment on GitHub. You may have seen the
> > bogus failure in t5615, which this series should fix (you may also have
> > seen the "set +x" cruft at the end of each test, which is fixed here,
> > too).
> 
> Surprisingly enough, I did not see any test failure in that test. I do
> re-run failed tests after the complete test run to make sure that the
> failure is not due to any resource scarcity, and that re-run is performed
> with -x (to double as documentation what really went wrong).

Ah, OK, that explains it. If t5615 never failed in the non-x run, then you
wouldn't have run into it. So it was waiting to bite you, but that test
script is simple enough that it never failed. :)

-Peff
