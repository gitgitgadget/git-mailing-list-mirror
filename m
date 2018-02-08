Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9371F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBHQgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:36:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:45372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751706AbeBHQgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:36:49 -0500
Received: (qmail 25254 invoked by uid 109); 8 Feb 2018 16:36:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Feb 2018 16:36:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12107 invoked by uid 111); 8 Feb 2018 16:37:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 08 Feb 2018 11:37:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Feb 2018 11:36:47 -0500
Date:   Thu, 8 Feb 2018 11:36:47 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] 'test_i18ngrep'-related fixes and improvements
Message-ID: <20180208163647.GB13078@sigill.intra.peff.net>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 08, 2018 at 04:56:47PM +0100, SZEDER Gábor wrote:

> This is the second version of 'sg/test-i18ngrep'.
> 
> To recap, this patch series fixes a couple of bogus 'test_i18ngrep'
> invocations (patches 1-4), tries to prevent similar bugs in the future
> (patch 8), teaches 'test_i18ngrep' to be more informative on failure
> (patch 9), and a bit of cleanups in between (patches 5-7).
> 
> Changes since the previous version [1]:
> [...]

This round looks good to me. I left a very minor comment on patch 8, but
otherwise didn't find anything wrong. Thanks.

-Peff
