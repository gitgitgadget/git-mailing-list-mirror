Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A661FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 21:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935006AbdJQVrL (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 17:47:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:55980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934943AbdJQVrK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 17:47:10 -0400
Received: (qmail 18686 invoked by uid 109); 17 Oct 2017 21:47:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 21:47:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27601 invoked by uid 111); 17 Oct 2017 21:47:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 17:47:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Oct 2017 17:47:08 -0400
Date:   Tue, 17 Oct 2017 17:47:08 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] mention git stash push first in the man page
Message-ID: <20171017214708.ixc2hnut2virarzh@sigill.intra.peff.net>
References: <20171005200049.GF30301@hank>
 <20171005201029.4173-1-t.gummerer@gmail.com>
 <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net>
 <20171017214515.GG15399@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171017214515.GG15399@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 10:45:15PM +0100, Thomas Gummerer wrote:

> > Seems reasonable, though if we are deprecating "save" should we demote
> > it from being in the synopsis entirely?
> 
> I saw that as a next step, with the "official" deprecation of "save".
> I thought we might want to advertise "push" a bit more before actually
> officially deprecating "save" and sending the deprecation notice out
> in the release notes.

Right, my thinking was that it would still be documented in the manpage,
just lower down. And that would probably say something like "save is a
historical synonym for push, except that it differs in these ways...".

> OTOH, dropping it from the synopsis in the man page probably wouldn't
> cause much issue, as "push" directly replaces it, and is easily
> visible.  Not sure how slow we want to take the deprecation?

I don't think there's any reason to go slow in marking something as
deprecated. It's the part where we follow up and remove or change the
feature that must take a while.

-Peff
