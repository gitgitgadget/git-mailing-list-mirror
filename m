Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7BE1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 12:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbcFPMhA (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 08:37:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:55632 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754234AbcFPMgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 08:36:47 -0400
Received: (qmail 17779 invoked by uid 102); 16 Jun 2016 12:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 08:36:47 -0400
Received: (qmail 16081 invoked by uid 107); 16 Jun 2016 12:36:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 08:36:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 08:36:45 -0400
Date:	Thu, 16 Jun 2016 08:36:44 -0400
From:	Jeff King <peff@peff.net>
To:	Elia Pinto <gitter.spiros@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2016, #04; Tue, 14)
Message-ID: <20160616123644.GD15988@sigill.intra.peff.net>
References: <xmqqtwgv77az.fsf@gitster.mtv.corp.google.com>
 <CA+EOSBm5DLkv2RyovSrOuvqDS6OR15g5Z_JuGthwQr2t=R8vdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+EOSBm5DLkv2RyovSrOuvqDS6OR15g5Z_JuGthwQr2t=R8vdg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 09:35:20AM +0200, Elia Pinto wrote:

> > * ep/http-curl-trace (2016-05-24) 2 commits
> >  - imap-send.c: introduce the GIT_TRACE_CURL enviroment variable
> >  - http.c: implement the GIT_TRACE_CURL environment variable
> >
> >  HTTP transport gained an option to produce more detailed debugging
> >  trace.
> >
> >  Rerolled.  Is everybody happy with this version?
> >
> The refs is there
> http://git.661346.n2.nabble.com/PATCH-v7-0-2-Implement-the-GIT-TRACE-CURL-environment-variable-td7657079.html
> 
> If  kindly someone who has reviewed and helped me to do the patch
> could give an ack (or a nack eventually). Thanks in advance

I gave another look at what is queued in pu, and I think it is OK. I
still find the output a little verbose, but I think we should ship it
and see how it fares in practice while debugging. I don't think its
exact format needs to be set in stone, so we can tweak it later if we
choose.

-Peff

PS Please trim your quotes to just the relevant bits.
