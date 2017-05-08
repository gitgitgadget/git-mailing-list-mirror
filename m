Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E3A21FC44
	for <e@80x24.org>; Mon,  8 May 2017 20:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756772AbdEHUIl (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 16:08:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47597 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753888AbdEHUIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 16:08:39 -0400
Received: (qmail 18831 invoked by uid 109); 8 May 2017 20:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 20:08:39 +0000
Received: (qmail 16174 invoked by uid 111); 8 May 2017 20:09:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 16:09:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 16:08:37 -0400
Date:   Mon, 8 May 2017 16:08:37 -0400
From:   Jeff King <peff@peff.net>
To:     Luciano Moreira <lucianomx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Commits messages numbered only until 10 when squashed
Message-ID: <20170508200836.ijarpzoqdyk4m4jb@sigill.intra.peff.net>
References: <CAPmMLfj9NYP8LBt8KrMq3-dyTeCvUCheRaUiXtrGv2CG_fGQTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPmMLfj9NYP8LBt8KrMq3-dyTeCvUCheRaUiXtrGv2CG_fGQTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 04:13:51PM -0300, Luciano Moreira wrote:

> Git version: 2.11.0
> 
> THE CASE:
> I have 15 commit to be squashed (the hashes are real, but the commit
> messages were changed for privacy). When it's rebase interactively
> squashing all the 15 commits, the numbering goes from 1 to 10 and
> after it starts again from 1 to 5.

This is fixed already by 356b8ecff (rebase--interactive: count squash
commits above 10 correctly, 2017-01-07). It's in v2.11.1.

-Peff
