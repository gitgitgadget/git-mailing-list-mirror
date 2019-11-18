Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C571F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 11:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKRLow (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 06:44:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:49972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726910AbfKRLov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 06:44:51 -0500
Received: (qmail 15226 invoked by uid 109); 18 Nov 2019 11:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Nov 2019 11:44:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13329 invoked by uid 111); 18 Nov 2019 11:48:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Nov 2019 06:48:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Nov 2019 06:44:49 -0500
From:   Jeff King <peff@peff.net>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     git@vger.kernel.org
Subject: Re: Multiple empty "remote:" lines during remote update
Message-ID: <20191118114449.GA12766@sigill.intra.peff.net>
References: <c6b51eaf-79b1-6fb9-6085-2d1a45b739a6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6b51eaf-79b1-6fb9-6085-2d1a45b739a6@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 18, 2019 at 09:34:46AM +0100, Jiri Slaby wrote:

> since some time (weeks or months), I am seeing this:
> $ git --version
> git version 2.24.0
> $ git remote update
> Fetching origin
> remote:
>         remote:

This was a bug in v2.22.1, which has been fixed in v2.24.0. However, the
bug is on the remote side, so whether you see it depends on which
version of Git the server has installed.

-Peff
