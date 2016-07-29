Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC531F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbcG2ASB (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:18:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:50688 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbcG2ASA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:18:00 -0400
Received: (qmail 12444 invoked by uid 102); 29 Jul 2016 00:18:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:18:01 -0400
Received: (qmail 29914 invoked by uid 107); 29 Jul 2016 00:18:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 20:18:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 20:17:57 -0400
Date:	Thu, 28 Jul 2016 20:17:57 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160729001756.GB9646@sigill.intra.peff.net>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160728235316.GB3676@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160728235316.GB3676@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 04:53:16PM -0700, Josh Triplett wrote:

> I can think of aesthetic reasons to want the non-"--from" format (for
> instance, sticking patch files into a non-git-based tool like quilt or a
> distribution packaging system, and not wanting your own email address
> included), but I can't think of any tool that would produce incorrect
> results if handed the --from format.  That seems like an argument for
> switching the default, and adding a --from-author option or similar to
> get the current output.

I covered most of my view elsewhere in the thread, but I want to be
clear that I also do not know of any widespread tool that would have a
problem. I am mostly worried about breaking people's private scripts.

-Peff
