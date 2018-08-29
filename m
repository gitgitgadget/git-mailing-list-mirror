Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3BC1F428
	for <e@80x24.org>; Wed, 29 Aug 2018 10:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeH2N6u (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 09:58:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33506 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbeH2N6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 09:58:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2BD091F404;
        Wed, 29 Aug 2018 10:02:43 +0000 (UTC)
Date:   Wed, 29 Aug 2018 10:02:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180829100243.GA28180@dcvr>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829050745.GD15274@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> I've thought about mirroring it to a public server as well, just for
> redundancy. But without the same domain, I'm not sure it would be all
> that useful as a community resource.

I wouldn't get too attached to the domain, "public-inbox.org" is
too long for my tastes anyways.  "peff.net/git/$MESSAGE_ID"
would actually be more user-friendly :>

A generic Message-ID redirection/finding service would be good,
(maybe some DHT thing, but... has that taken off for git blobs, yet?)

Anyways I hope to teach public-inbox to auto-linkify Message-ID-looking
strings "<XXXXXXXXXXX@XXXXXXXX>" into URLs for domain-portability,
(but it's ambiguous with email addresses).  But yeah, I don't
like things being tied to domain names.

I've also been considering setting up a parallel instance
on 80x24.org to use the more-scalable "v2" repository format
developed for https://lore.kernel.org/lkml/

Speaking of lore, Konstantin confirmed he'll be getting more
vger lists up: https://public-inbox.org/meta/20180827205811.GA1611@chatter
