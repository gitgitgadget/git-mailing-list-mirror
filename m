Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEED1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeAZSvj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:51:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:59106 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751378AbeAZSvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:51:38 -0500
Received: (qmail 16445 invoked by uid 109); 26 Jan 2018 18:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Jan 2018 18:51:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17514 invoked by uid 111); 26 Jan 2018 18:52:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Jan 2018 13:52:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jan 2018 13:51:36 -0500
Date:   Fri, 26 Jan 2018 13:51:36 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] 'test_i18ngrep'-related fixes and improvements
Message-ID: <20180126185136.GH27618@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 01:36:58PM +0100, SZEDER Gábor wrote:

> When 'test_i18ngrep' can't find the expected pattern, it exits
> completely silently; when its negated form does find the pattern that
> shouldn't be there, it prints the matching line(s) but otherwise exits
> without any error message.  This leaves the developer puzzled about
> what could have gone wrong.  Well, at least it left me puzzled...
> 
> Initially all I wanted to do was to make 'test_i18ngrep' more
> informative on failure, but then skeletons started to fall out of the
> closet^Wour test suite, and BAM! before I knew it I had 10 patches:

I know the feeling. :)

The series overall looks good to me. I left some comments on the
approach in the final few patches, but I could live with it as-is, or
with the approach Junio suggested.

-Peff
