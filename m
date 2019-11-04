Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9D61F454
	for <e@80x24.org>; Mon,  4 Nov 2019 22:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfKDW0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 17:26:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:38760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730342AbfKDW0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 17:26:36 -0500
Received: (qmail 5225 invoked by uid 109); 4 Nov 2019 22:26:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Nov 2019 22:26:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7045 invoked by uid 111); 4 Nov 2019 22:29:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2019 17:29:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Nov 2019 17:26:34 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] Documentation for common user misconceptions
Message-ID: <20191104222634.GC22367@sigill.intra.peff.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191102192615.10013-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 02, 2019 at 07:26:11PM +0000, brian m. carlson wrote:

> This series includes four patches that update the documentation to
> address common user misconceptions.
> 
> Changes from v2:
> * Move author and committer information to git-commit(1) where people
>   will look for it.
> * Move guidance on user.name format to git-commit(1) as well and mention
>   a shortened form of the advice in the `user.name` description.
> * Use a parenthetical to describe a "personal name" without contrasting
>   it with a username.
> * Offer a potential solution for people who want to ignore tracked
>   files by recommending a templating mechanism.
> * Be slightly more verbose about why memory is wasted with
>   http.postBuffer.

Thanks. I think this is an improvement over v1, but I'm still a little
iffy on some of the other movement in the first patch.

TBH, I don't think it's making anything _worse_, but I think it
highlights how some of our documentation is a mish-mash of low-level and
high-level details. ;) So it might be a good opportunity to at least
clean up the documentation around ident environment variables.

-Peff
