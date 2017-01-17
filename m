Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321B820756
	for <e@80x24.org>; Tue, 17 Jan 2017 15:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdAQPgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 10:36:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:40209 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdAQPgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 10:36:06 -0500
Received: (qmail 5543 invoked by uid 109); 17 Jan 2017 15:36:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:36:04 +0000
Received: (qmail 18227 invoked by uid 111); 17 Jan 2017 15:36:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 10:36:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 10:36:02 -0500
Date:   Tue, 17 Jan 2017 10:36:02 -0500
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v5 0/7] Add --format to tag verification
Message-ID: <20170117153602.qfit46fdc4j4rhao@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 01:46:58PM -0500, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> This is the fifth iteration of [1][2][3][4], and as a result of the
> discussion in [5]. The main goal of this patch series is to bring
> --format to git tag verification so that upper-layer tools can inspect
> the content of a tag and make decisions based on it.

Thanks for picking this back up.  I didn't see any bugs, but I had a few
interface nits, which I sent inline.

-Peff
