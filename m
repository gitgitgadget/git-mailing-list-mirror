Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637761F855
	for <e@80x24.org>; Sat, 30 Jul 2016 05:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbcG3Frr (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 01:47:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:51542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750747AbcG3Frq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 01:47:46 -0400
Received: (qmail 4476 invoked by uid 102); 30 Jul 2016 05:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jul 2016 01:47:47 -0400
Received: (qmail 9000 invoked by uid 107); 30 Jul 2016 05:48:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jul 2016 01:48:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jul 2016 01:47:42 -0400
Date:	Sat, 30 Jul 2016 01:47:42 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160729001618.GA9646@sigill.intra.peff.net>
 <20160729020801.GA14892@x>
 <20160729225800.GA23268@sigill.intra.peff.net>
 <20160730045055.e3t6tpgi6zch4epo@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160730045055.e3t6tpgi6zch4epo@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 09:50:55PM -0700, Josh Triplett wrote:

> I would propose the following then:
> 
> - I'll write a patch adding a config option format.from, along with
>   documentation, without changing the default.
> - The release notes for the version of git introducing that config
>   option should mention, prominently, the plan to change the default in
>   a future version of git.
> - A subsequent release can change the default.  No major rush to do
>   this.
> 
> Does that sound reasonable?

That sounds fine to me.

I do have to admit that after reading through the "format.*" section of
git-config(1), there is quite a bit that is configurable in it. So
perhaps we do not need to be as careful about behavior changes as I
thought.

So if you wanted to squish steps 2 and 3 together, that would also be OK
by me.

-Peff
