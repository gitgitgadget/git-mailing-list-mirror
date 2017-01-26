Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 400CA1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbdAZO0x (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:26:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:45312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbdAZO0w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:26:52 -0500
Received: (qmail 4425 invoked by uid 109); 26 Jan 2017 14:26:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:26:51 +0000
Received: (qmail 23358 invoked by uid 111); 26 Jan 2017 14:26:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:26:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:26:49 -0500
Date:   Thu, 26 Jan 2017 09:26:49 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
Message-ID: <20170126142648.7jjewr42okngawdd@sigill.intra.peff.net>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
 <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
 <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251800120.3469@virtualbox>
 <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net>
 <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com>
 <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net>
 <xmqq7f5i92jk.fsf@gitster.mtv.corp.google.com>
 <D9F0976B-9F78-44BE-B9DD-CAB6506FA3A9@gmail.com>
 <8141FBB4-ACD0-42F5-9B5A-DA8DF1693972@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8141FBB4-ACD0-42F5-9B5A-DA8DF1693972@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 10:48:30AM +0100, Lars Schneider wrote:

> Oh. I must have made a mistake on my very first test run. I can reproduce
> the failure with ZSH and my plugins... looks like it's a Mac OS problem
> and no TravisCI only problem after all.

Thanks for digging into it. If it's really /bin/mv that causes the
problem, then I doubly think the "mv -f" patch is the right fix.

-Peff
