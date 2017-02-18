Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32E0201A8
	for <e@80x24.org>; Sat, 18 Feb 2017 06:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750844AbdBRG3r (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 01:29:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:57957 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdBRG3q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 01:29:46 -0500
Received: (qmail 26653 invoked by uid 109); 18 Feb 2017 06:29:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 06:29:45 +0000
Received: (qmail 12457 invoked by uid 111); 18 Feb 2017 06:29:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 01:29:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2017 01:29:43 -0500
Date:   Sat, 18 Feb 2017 01:29:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/5] A series of performance enhancements in the memihash
 and name-cache area
Message-ID: <20170218062943.j2llxuuylqs2qemy@sigill.intra.peff.net>
References: <cover.1487071883.git.johannes.schindelin@gmx.de>
 <20170214220332.753i4tgclm62er4f@sigill.intra.peff.net>
 <16b1259c-4cdc-8f4d-db47-d724386a3d2b@jeffhostetler.com>
 <xmqqo9y0m45e.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9y0m45e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 09:58:21PM -0800, Junio C Hamano wrote:

> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
> > I'll try to put together a before/after perf-test to better
> > demonstrate this.
> 
> I didn't pick up the series while watching these exchanges, as I
> didn't know how quick your turnaround would be, but now a few days
> have passed.  Just to make sure we won't forget this topic, I'll
> pick up these 5 patches in the meantime.

Yeah, to be clear my question was not an objection, but mostly
curiosity and interest.

-Peff
