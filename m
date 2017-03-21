Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD9E20960
	for <e@80x24.org>; Tue, 21 Mar 2017 22:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757425AbdCUWUE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 18:20:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:49056 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756830AbdCUWUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 18:20:04 -0400
Received: (qmail 28174 invoked by uid 109); 21 Mar 2017 22:20:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 22:20:03 +0000
Received: (qmail 21700 invoked by uid 111); 21 Mar 2017 22:20:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 18:20:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Mar 2017 18:19:59 -0400
Date:   Tue, 21 Mar 2017 18:19:59 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] stash: pass the pathspec argument to git reset
Message-ID: <20170321221959.dtkz2i33jyojwzca@sigill.intra.peff.net>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
 <20170321221219.28041-3-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321221219.28041-3-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 10:12:18PM +0000, Thomas Gummerer wrote:

> For "git stash -p --no-keep-index", the pathspec argument is currently
> not passed to "git reset".  This means that changes that are staged but
> that are excluded from the pathspec still get unstaged by git stash -p.
> 
> Make sure that doesn't happen by passing the pathspec argument to the
> git reset in question, bringing the behaviour in line with "git stash --
> <pathspec>".
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  git-stash.sh           | 2 +-
>  t/t3904-stash-patch.sh | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

This one looks good to me.

-Peff
