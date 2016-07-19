Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29691F744
	for <e@80x24.org>; Tue, 19 Jul 2016 11:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbcGSL3P (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 07:29:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:46859 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752965AbcGSL3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 07:29:14 -0400
Received: (qmail 6766 invoked by uid 102); 19 Jul 2016 11:29:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jul 2016 07:29:13 -0400
Received: (qmail 11437 invoked by uid 107); 19 Jul 2016 11:29:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jul 2016 07:29:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jul 2016 05:29:07 -0600
Date:	Tue, 19 Jul 2016 05:29:07 -0600
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160719112907.GA12916@sigill.intra.peff.net>
References: <20160713083044.GB18144@sigill.intra.peff.net>
 <20160713082653.GA18144@sigill.intra.peff.net>
 <20160713105216.GB16000@teco.navytux.spb.ru>
 <20160717170649.GA3830@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160717170649.GA3830@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 17, 2016 at 08:06:49PM +0300, Kirill Smelkov wrote:

> > Anyway, please find below updated patch according to your suggestion.
> > Hope it is ok now.
> 
> Ping. Is the patch ok or something needs to be improved still?

Sorry, I'm traveling and haven't carefully reviewed it yet. It's still
on my list, but it may be a few days.

-Peff
