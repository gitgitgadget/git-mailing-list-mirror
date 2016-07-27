Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863F51F621
	for <e@80x24.org>; Wed, 27 Jul 2016 19:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041AbcG0T53 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:57:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:50099 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757475AbcG0T53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 15:57:29 -0400
Received: (qmail 5584 invoked by uid 102); 27 Jul 2016 19:57:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 15:57:29 -0400
Received: (qmail 20343 invoked by uid 107); 27 Jul 2016 19:57:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 15:57:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 15:57:25 -0400
Date:	Wed, 27 Jul 2016 15:57:25 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Phil Pennock <phil@pennock-tech.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t4205: indent here documents
Message-ID: <20160727195725.GB8141@sigill.intra.peff.net>
References: <20160727185256.GA11657@sigill.intra.peff.net>
 <20160727185523.GB6626@sigill.intra.peff.net>
 <xmqqbn1ix4mp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn1ix4mp.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 12:28:14PM -0700, Junio C Hamano wrote:

> > Some of the tests actually care quite a bit about
> > whitespace, but none of them do so at the beginning of the
> > line (because they things like qz_to_tab_space to avoid
> 
> I'll do s/they things/they use things/ here while queuing.

Whoops, thanks.

-Peff
