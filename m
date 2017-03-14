Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A201420373
	for <e@80x24.org>; Tue, 14 Mar 2017 18:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdCNSBG (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:01:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:44061 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751509AbdCNSBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:01:05 -0400
Received: (qmail 20749 invoked by uid 109); 14 Mar 2017 18:01:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 18:01:04 +0000
Received: (qmail 21322 invoked by uid 111); 14 Mar 2017 18:01:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 14:01:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 14:01:01 -0400
Date:   Tue, 14 Mar 2017 14:01:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v6 00/12] Fix the early config
Message-ID: <20170314180101.q7xwn2sekawx7ryv@sigill.intra.peff.net>
References: <cover.1489098170.git.johannes.schindelin@gmx.de>
 <cover.1489435755.git.johannes.schindelin@gmx.de>
 <xmqq7f3sn70s.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f3sn70s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 03:31:15PM -0700, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > These patches are an attempt to make Git's startup sequence a bit less
> > surprising.
> 
> I think this is ready for 'next', so let's ask reviewers to really
> pay attention to this round, wait for a few days and merge it by the
> end of the week at the latest.

I gave it another read-through and didn't find anything worth
mentioning. I agree it's probably ready for 'next'.

-Peff
