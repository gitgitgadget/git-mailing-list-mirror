Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3AE920A17
	for <e@80x24.org>; Mon, 16 Jan 2017 23:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdAPXt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 18:49:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:39947 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdAPXt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 18:49:28 -0500
Received: (qmail 31364 invoked by uid 109); 16 Jan 2017 23:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 23:49:27 +0000
Received: (qmail 13356 invoked by uid 111); 16 Jan 2017 23:50:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 18:50:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 18:49:25 -0500
Date:   Mon, 16 Jan 2017 18:49:25 -0500
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        kes-kes@yandex.ru
Subject: Re: [RFC] stash: support filename argument
Message-ID: <20170116234924.72aeqo6ltrgov54o@sigill.intra.peff.net>
References: <20170115142542.11999-1-t.gummerer@gmail.com>
 <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com>
 <c0d46a97-b1c0-d9c9-e475-28e0368ac61f@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0d46a97-b1c0-d9c9-e475-28e0368ac61f@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 01:41:02AM +0100, Stephan Beyer wrote:

> However, going further, the next feature to be requested could be "git
> stash --patch" ;D This leads me to think that the mentioned simulation
> of partial stashes might be something everyone might come up with who
> has basic understanding of git features and "git stash", and might be
> the more flexible and probably better solution to the problem.

Don't we have "git stash -p" already?[1]

I use it all the time, and it's very handy for picking apart changes. I
have often wanted "git stash -p <paths>" to work, though.

-Peff

[1] I had to double check that it was not something I hacked together
    locally and forgot about. :) It's from dda1f2a5c (Implement 'git
    stash save --patch', 2009-08-13). I also worked up a "git stash
    apply -p", but I remember it was buggy, and I haven't looked at it
    in years. It's at:

      https://github.com/peff/git/commit/2c4ed43987b20cfb1605fbd7648d81e454c45c71

    if anybody is curious. I don't even recall what the problems were at
    this point.
