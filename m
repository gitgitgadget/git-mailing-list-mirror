Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EC6202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 12:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932068AbdCLMjt (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 08:39:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:42827 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755739AbdCLMjr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 08:39:47 -0400
Received: (qmail 30007 invoked by uid 109); 12 Mar 2017 12:39:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 12:39:46 +0000
Received: (qmail 12427 invoked by uid 111); 12 Mar 2017 12:39:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 08:39:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 08:39:44 -0400
Date:   Sun, 12 Mar 2017 08:39:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-walker: fix buffer underflow processing remote
 alternates
Message-ID: <20170312123944.2de33av45aqvgrdr@sigill.intra.peff.net>
References: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170312123853.55ehe2jurozb6zad@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 08:38:53AM -0400, Jeff King wrote:

> I posted this last week in the middle of another thread[1], but it
> didn't get any attention. So here it is again.

Oops, that [1] should be:

  http://public-inbox.org/git/20170304034914.cgyvz735lxhe2cno@sigill.intra.peff.net/

-Peff
