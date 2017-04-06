Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA01209F1
	for <e@80x24.org>; Thu,  6 Apr 2017 09:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756584AbdDFJVb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 05:21:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:57412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755666AbdDFJVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 05:21:25 -0400
Received: (qmail 31411 invoked by uid 109); 6 Apr 2017 09:21:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 09:21:24 +0000
Received: (qmail 24427 invoked by uid 111); 6 Apr 2017 09:21:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Apr 2017 05:21:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Apr 2017 05:21:22 -0400
Date:   Thu, 6 Apr 2017 05:21:22 -0400
From:   Jeff King <peff@peff.net>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170406092122.titsfyxpucj6xoe4@sigill.intra.peff.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2017 at 11:33:37AM +0200, Tom G. Christensen wrote:

> FWIW I maintain freely available updated git packages for RHEL 3, 4, 5, 6
> and 7.
> 
> They can be found here:
> https://jupiterrise.com/blog/jrpms/
> 
> And direct access here:
> https://jupiterrise.com/jrpms/ (for el3,el4,el5)
> https://jupiterrise.com/jrpmsplus/ (for el6, el7)
> 
> They are built against system versions of curl though a few patches are
> required for 7.10.6 (el3) and 7.12.1 (el4) support.
> Patches can be found in the src.rpm, though I can also post them here as
> patch series, they cover more than just curl.
> 
> I don't use the el3 and el4 versions much any more and el5 use will also
> drop of now as I'm busy converting machines from el5 to el7.

Thanks for sharing, that's a really interesting data point.

I'm not quite sure what to take away from it, though. Either "yes,
somebody really is using Git with antique versions of curl". Or "even
the antique people are giving up el4, and it might be reasonable to
start requiring curl >= 7.11.0".

-Peff
