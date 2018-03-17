Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73971F404
	for <e@80x24.org>; Sat, 17 Mar 2018 15:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCQPQw (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 11:16:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:60836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752077AbeCQPQv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 11:16:51 -0400
Received: (qmail 21002 invoked by uid 109); 17 Mar 2018 15:16:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 17 Mar 2018 15:16:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6069 invoked by uid 111); 17 Mar 2018 15:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 17 Mar 2018 11:17:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Mar 2018 11:16:49 -0400
Date:   Sat, 17 Mar 2018 11:16:49 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc
 job
Message-ID: <20180317151648.GA15772@sigill.intra.peff.net>
References: <20180303014605.10603-1-pclouds@gmail.com>
 <20180316193355.20161-1-pclouds@gmail.com>
 <20180316212208.GC12333@sigill.intra.peff.net>
 <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
 <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 03:29:31PM +0100, Lars Schneider wrote:

> >> Why isn't this just turning on DEVELOPER=1 if we know we have a capable
> >> compiler?
> > 
> > DEVELOPER=1 is always set even before this patch. It's set and
> > exported in lib-travisci.sh.
> 
> I interpreted Peff's comment like this:
> 
> If DEVELOPER=1 is set and we detect a gcc-6 in the makefile, 
> then we could set your additional flags in the makefile.
> 
> This way every developer with a new compiler would run these
> flags locally (if DEVELOPER=1 is set).

Actually, I was mostly just confused, and didn't realize that these were
going above and beyond what's in DEVELOPER.

But that said, now that I understand, I agree completely with your
suggestion. :)

-Peff
