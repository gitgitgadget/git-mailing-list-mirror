Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AF11F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932784AbcJTVks (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:60295 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbcJTVks (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:48 -0400
Received: (qmail 4283 invoked by uid 109); 20 Oct 2016 21:40:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 21:40:47 +0000
Received: (qmail 30348 invoked by uid 111); 20 Oct 2016 21:41:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 17:41:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 17:40:45 -0400
Date:   Thu, 20 Oct 2016 17:40:45 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
Message-ID: <20161020214045.gpe352xnw5oc36ur@sigill.intra.peff.net>
References: <580893d5a4736_4ed37b53181837@ss1435.mail>
 <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 10:05:38AM -0700, Stefan Beller wrote:

> Not sure what triggered the new finding of coverity as seen below as the
> parse_commit() was not touched. Junios series regarding the merge base
> optimization touches a bit of code nearby though.

I have noticed that "old" problems sometimes reappear when nearby code
changes. I assume that they have some kind of heuristic to identify the
location of a defect, that it probably includes the line number in the
file, and that it can be fooled by too much code appearing nearby.

-Peff
