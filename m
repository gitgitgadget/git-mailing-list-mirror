Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C1A1FF6D
	for <e@80x24.org>; Thu, 15 Dec 2016 19:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbcLOT1C (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 14:27:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:57193 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752312AbcLOT1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 14:27:02 -0500
Received: (qmail 15519 invoked by uid 109); 15 Dec 2016 19:20:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 19:20:20 +0000
Received: (qmail 4913 invoked by uid 111); 15 Dec 2016 19:21:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 14:21:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 14:20:17 -0500
Date:   Thu, 15 Dec 2016 14:20:17 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 07/34] sequencer (rebase -i): add support for the
 'fixup' and 'squash' commands
Message-ID: <20161215192016.qhbcyo7vb7petuwp@sigill.intra.peff.net>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <ae521f75a105c6b9e54595d68bda3c5b62f313b6.1481642927.git.johannes.schindelin@gmx.de>
 <20161215190351.as76panrcz5rgibj@sigill.intra.peff.net>
 <CAGZ79kZ3i-eoxMsVMsb+VBtEVQf2-Fovh_YM5NBN2pSOBHajBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ3i-eoxMsVMsb+VBtEVQf2-Fovh_YM5NBN2pSOBHajBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 11:07:34AM -0800, Stefan Beller wrote:

> On Thu, Dec 15, 2016 at 11:03 AM, Jeff King <peff@peff.net> wrote:
> > wonder if it would be helpful to send that output to the list.
> 
> Sure we can try.
> 
> Another project I used to run through coverity (Gerrit), shows
> similar characteristics w.r.t. false positives, so people complained
> when I was force feeding them the niceties of static analysis.
> 
> I'll just try to set it up and see how the mailing list reacts.
> (Not sure if you can just add emails there or if the email has
> to be verified or such.)

I see you added it, but I don't see the confirmation email on the list.
I wonder if it was HTML mail and vger ate it.

-Peff
