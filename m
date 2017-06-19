Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B5C1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdFSU4i (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 16:56:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:45040 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751736AbdFSU4i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:56:38 -0400
Received: (qmail 25948 invoked by uid 109); 19 Jun 2017 20:51:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 20:51:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31764 invoked by uid 111); 19 Jun 2017 20:56:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 16:56:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 16:56:36 -0400
Date:   Mon, 19 Jun 2017 16:56:36 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: Better usability of stash refs
Message-ID: <20170619205636.7adzgolilpfch3ux@sigill.intra.peff.net>
References: <CAHd499C8x_zWJyRNXO-410gxudk897-okJaA3uOPYr38QNHjpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499C8x_zWJyRNXO-410gxudk897-okJaA3uOPYr38QNHjpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 03:32:54PM -0500, Robert Dailey wrote:

> To drop a stash, I have to do this (example):
> 
> $ git stash drop stash@{3}
> 
> Using the full "stash@{N}" seems superfluous since the documentation
> states it must be a stash in the first place. It would make more sense
> (and be quicker to type) to do:
> 
> $ git stash drop 3
> 
> Is there a trick I can use to make this shorthand possible? I thought
> about creating a "s" script for "stash" that intercepted the
> parameters for only a couple of stash sub-commands and created the
> ref, but that seems a lot of work.
> 
> Any productivity tips here? Thanks in advance.

Junio mentioned that this is already possible. I suspect the problem may
be that your Git is not recent enough. It was added in a56c8f5aa (stash:
allow stashes to be referenced by index only, 2016-10-24), which is in
v2.11.0.

-Peff
