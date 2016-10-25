Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9D220193
	for <e@80x24.org>; Tue, 25 Oct 2016 00:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbcJYAa1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 20:30:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:33703 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755062AbcJYAa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 20:30:26 -0400
Received: (qmail 10455 invoked by uid 109); 25 Oct 2016 00:30:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 00:30:25 +0000
Received: (qmail 28568 invoked by uid 111); 25 Oct 2016 00:30:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Oct 2016 20:30:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Oct 2016 20:30:23 -0400
Date:   Mon, 24 Oct 2016 20:30:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
Message-ID: <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net>
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
 <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
 <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
 <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
 <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
 <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
 <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
 <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 04:53:50PM -0700, Junio C Hamano wrote:

> > So how about this?  It gets rid of magic number 3 and works for array
> > size that's not a power of two.  And as a nice side effect it can't
> > trigger a signed overflow anymore.
> 
> Looks good to me.  Peff?

Any of the variants discussed in this thread is fine by me.

-Peff
