Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF651202A3
	for <e@80x24.org>; Mon, 16 Oct 2017 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbdJPWmm (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 18:42:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:54642 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932361AbdJPWml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 18:42:41 -0400
Received: (qmail 12854 invoked by uid 109); 16 Oct 2017 22:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 22:42:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17874 invoked by uid 111); 16 Oct 2017 22:42:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Oct 2017 18:42:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Oct 2017 18:42:39 -0400
Date:   Mon, 16 Oct 2017 18:42:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171016224239.yhvivrcuzeezcz3t@sigill.intra.peff.net>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 16, 2017 at 03:44:08PM +0900, Junio C Hamano wrote:

> I threw this topic in stalled category, hoping that one or the other
> opinion eventually turns out to be more prevalent, but it didn't
> seem to have happened X-<.

I think it's sufficiently obscure that nobody really cares.

I admit that _I_ don't actually care myself. We should fix the BUG(),
obviously, but between the two I could live with it either way. Mostly I
didn't want to go to the work to write the patch for the direction that
I didn't think was right, and was hoping Jonathan would if he felt
strongly about it.

> So I think the right endgame in the longer term is:

I won't quote the rest of your message because I agree with it
completely, in terms of the endgame we'd like to see.

I'll address a few specific comments on your followup patch.

-Peff
