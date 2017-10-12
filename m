Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF03120372
	for <e@80x24.org>; Thu, 12 Oct 2017 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754877AbdJLNG5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 09:06:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50876 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753375AbdJLNG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 09:06:56 -0400
Received: (qmail 14254 invoked by uid 109); 12 Oct 2017 13:06:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 13:06:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15378 invoked by uid 111); 12 Oct 2017 13:06:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 09:06:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 09:06:49 -0400
Date:   Thu, 12 Oct 2017 09:06:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171012130649.b4tmofbvdgkevmnn@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012044724.GD155740@aiede.mtv.corp.google.com>
 <xmqqa80x0xcw.fsf@gitster.mtv.corp.google.com>
 <20171012054049.GF155740@aiede.mtv.corp.google.com>
 <xmqq1sm828pi.fsf@gitster.mtv.corp.google.com>
 <xmqqwp40zwc5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp40zwc5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 03:58:18PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > We need to be able to answer "why does '-c color.ui=always' work
> > only from the command line?", but I doubt we want to actively
> > encourage the use of it, though, so I dunno.
> 
> For today's pushout, I've queued this as [PATCH 3/2]
> 
> Thanks..
> 
> -- >8 --
> From: Jonathan Nieder <jrnieder@gmail.com>
> Subject: color: document that "git -c color.*=always" is a bit special
> Date: Wed, 11 Oct 2017 21:47:24 -0700

This looks reasonable to me to ship in v2.15. I assume we're going to
leave any "git --default-color=..." options to post-release, since we're
already in -rc1.

-Peff
