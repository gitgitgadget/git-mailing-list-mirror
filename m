Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB3C1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbcHOSJJ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:09:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:55602 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752966AbcHOSJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:09:09 -0400
Received: (qmail 1237 invoked by uid 109); 15 Aug 2016 18:09:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 18:09:08 +0000
Received: (qmail 17080 invoked by uid 111); 15 Aug 2016 18:09:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 14:09:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 14:09:05 -0400
Date:	Mon, 15 Aug 2016 14:09:05 -0400
From:	Jeff King <peff@peff.net>
To:	Andreas Schwab <schwab@linux-m68k.org>
Cc:	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
Message-ID: <20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
 <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
 <8737m63phh.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8737m63phh.fsf@linux-m68k.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 07:34:50PM +0200, Andreas Schwab wrote:

> On Aug 15 2016, Jeff King <peff@peff.net> wrote:
> 
> > And implicit in your test is the other bug, which is that deleting the
> > last key in a section leaves the empty header. I think it's related to
> > the same issue.
> 
> Indiscriminately removing empty section headers may break comments that
> have been put there on purpose.

I know, but we do not even do so discriminately.

-Peff
