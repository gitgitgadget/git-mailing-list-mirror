Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138A81FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 13:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbcLENMX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 08:12:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:51727 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750849AbcLENMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 08:12:21 -0500
Received: (qmail 22931 invoked by uid 109); 5 Dec 2016 13:12:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 13:12:21 +0000
Received: (qmail 4383 invoked by uid 111); 5 Dec 2016 13:12:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 08:12:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 08:12:19 -0500
Date:   Mon, 5 Dec 2016 08:12:19 -0500
From:   Jeff King <peff@peff.net>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: warn about possible '=' in clean/smudge filter
 process values
Message-ID: <20161205131219.kdq4zafith26vro2@sigill.intra.peff.net>
References: <20161203194516.12879-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161203194516.12879-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 03, 2016 at 08:45:16PM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> A pathname value in a clean/smudge filter process "key=value" pair can
> contain the '=' character (introduced in edcc858). Make the user aware
> of this issue in the docs, add a corresponding test case, and fix the
> issue in filter process value parser of the example implementation in
> contrib.

Yeah, I just naturally assumed it would work this way, as it's pretty
standard in our other key=value protocols. But certainly it's reasonable
to document it (and to keep the t0021 filter as a good example).

-Peff
