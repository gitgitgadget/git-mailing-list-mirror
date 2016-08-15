Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751801F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 12:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcHOMEp (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 08:04:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:55337 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752746AbcHOMEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 08:04:45 -0400
Received: (qmail 12450 invoked by uid 109); 15 Aug 2016 12:04:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 12:04:44 +0000
Received: (qmail 13582 invoked by uid 111); 15 Aug 2016 12:04:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 08:04:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 08:04:41 -0400
Date:	Mon, 15 Aug 2016 08:04:41 -0400
From:	Jeff King <peff@peff.net>
To:	Arkady Shapkin <arkady.shapkin@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Git shallow clone branch doesn't work with recursive submodules
 cloning
Message-ID: <20160815120441.nwtdqfgcv3ljt4vl@sigill.intra.peff.net>
References: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB-zwL28qUBO5PrRznH9KmLJZUHO65_J-DxvPP+NHZEuofKh9Q@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 02:20:27PM +0300, Arkady Shapkin wrote:

> I am trying clone repository by tag with recursive submodules init,
> but for one submodule it doesn't work.
> What I'm doing wrong?

Nothing. See 18a74a0 (clone: do not let --depth imply
--shallow-submodules, 2016-06-19).

> >git --version
> git version 2.9.0.windows.1

The fix is in v2.9.1.

-Peff
