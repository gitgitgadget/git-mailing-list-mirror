Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750411F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbcJERzQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 13:55:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:52943 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753768AbcJERzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 13:55:15 -0400
Received: (qmail 3818 invoked by uid 109); 5 Oct 2016 17:55:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 17:55:15 +0000
Received: (qmail 19614 invoked by uid 111); 5 Oct 2016 17:55:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 13:55:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 13:55:13 -0400
Date:   Wed, 5 Oct 2016 13:55:13 -0400
From:   Jeff King <peff@peff.net>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 4/6] Documentation/git-merge.txt: improve short
 description in NAME
Message-ID: <20161005175512.aruzndaow3g2jmt7@sigill.intra.peff.net>
References: <cover.1475678515.git.sorganov@gmail.com>
 <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a33dd3ec3da0dc2dad72ed85edd29ff01f898831.1475678515.git.sorganov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 05:46:22PM +0300, sorganov@gmail.com wrote:

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 216d2f4..cc0329d 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -3,7 +3,8 @@ git-merge(1)
>  
>  NAME
>  ----
> -git-merge - Join two or more development histories together
> +
> +git-merge - Merge one or more branches to the current branch

I wonder if we should be more clear that you don't have to merge a
branch; you can merge any commit. I do agree that the original was
unnecessarily general. And I think "the current branch" is accurate
(technically it can be to a detached HEAD, but that is pedantry that
doesn't need to make it into the synopsis).

So maybe "Merge one or more commits into the current branch".  I guess
that is a bit vague, too. It is really "commit tips" or "lines of
development" that we are merging. Bringing them in of course brings in
many commits, but the "or more" there is meant to hint at multi-parent
merges.

So perhaps "one or more branches", while not completely accurate, is the
best we can do. I dunno.

-Peff
