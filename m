Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFFF20286
	for <e@80x24.org>; Fri, 15 Sep 2017 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbdIOLUb (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 07:20:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:39926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751194AbdIOLUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 07:20:31 -0400
Received: (qmail 12046 invoked by uid 109); 15 Sep 2017 11:20:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 11:20:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6600 invoked by uid 111); 15 Sep 2017 11:21:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 07:21:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Sep 2017 07:20:29 -0400
Date:   Fri, 15 Sep 2017 07:20:29 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t6010: test actual test output
Message-ID: <20170915112028.ksrpv637jsd7giox@sigill.intra.peff.net>
References: <cover.1505394278.git.git@grubix.eu>
 <80f7dcfaa9162dc795f8c072effea44fa83ea196.1505394278.git.git@grubix.eu>
 <20170914143450.tmomqf2vs55tk3nz@sigill.intra.peff.net>
 <089cdbf6-7556-6fba-21f2-6602c5ca8920@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <089cdbf6-7556-6fba-21f2-6602c5ca8920@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 12:01:27PM +0200, Michael J Gruber wrote:

> Jeff King venit, vidit, dixit 14.09.2017 16:34:
> > On Thu, Sep 14, 2017 at 03:15:18PM +0200, Michael J Gruber wrote:
> > 
> >> 4f21454b55 ("merge-base: handle --fork-point without reflog",
> >> 2016-10-12) introduced a fix for merge-base --fork-point without reflog
> >> and a test. While that test is fine, it did not update expected nor actual
> >> output and tested that of the previous test instead.
> > 
> > Oops. The use of the existing "expect3" was intentional (the idea being
> > that we are repeating the identical step from the previous test with the
> > slight tweak of not having a reflog). But obviously failing to write to
> > "actual" at all was a mistake.
> > 
> > That said, I'm OK with reiterating the expected output.
> 
> expect3 had a different content, too ;)

Oh, then it was just horribly broken, then. Oops. :)

Thanks for fixing.

-Peff
