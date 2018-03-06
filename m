Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D2E1F576
	for <e@80x24.org>; Tue,  6 Mar 2018 06:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeCFGw7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 01:52:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:48440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753300AbeCFGw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 01:52:58 -0500
Received: (qmail 15465 invoked by uid 109); 6 Mar 2018 06:52:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Mar 2018 06:52:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1378 invoked by uid 111); 6 Mar 2018 06:53:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Mar 2018 01:53:49 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2018 07:52:54 +0100
Date:   Tue, 6 Mar 2018 07:52:54 +0100
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/4] Documentation: list all type specifiers in config
 prose
Message-ID: <20180306065253.GC3522@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180306021729.45813-3-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-3-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 06:17:27PM -0800, Taylor Blau wrote:

> The documentation for the `git-config(1)` builtin has not been recently
> updated to include new types, such as `--bool-or-int`, and
> `--expiry-date`. To ensure completeness when adding a new type
> specifier, let's update the existing documentation to include the new
> types.
> 
> This commit also prepares for the new type specifier `--color`, so that
> this section will not lag behind when yet more new specifiers are added.

Good catch. Thanks for cleaning this up.

> -The type specifier can be either `--int` or `--bool`, to make
> -'git config' ensure that the variable(s) are of the given type and
> -convert the value to the canonical form (simple decimal number for int,
> -a "true" or "false" string for bool), or `--path`, which does some
> -path expansion (see `--path` below).  If no type specifier is passed, no
> -checks or transformations are performed on the value.
> +The type specifier can be either `--int` or `--bool`, to make 'git config'
> +ensure that the variable(s) are of the given type and convert the value to the
> +canonical form (simple decimal number for int, a "true" or "false" string for
> +bool, either of for --bool-or-int), or `--path`, which does some path expansion
> +(see `--path` below), or `--expiry-date` (see `--expiry-date` below).  If no
> +type specifier is passed, no checks or transformations are performed on the
> +value.

Perhaps it's time to switch to a list format for these?

-Peff
