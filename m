Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A381F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeJ2XKB (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:10:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:58970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725930AbeJ2XKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:10:01 -0400
Received: (qmail 20268 invoked by uid 109); 29 Oct 2018 14:21:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:21:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17901 invoked by uid 111); 29 Oct 2018 14:20:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:20:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:21:08 -0400
Date:   Mon, 29 Oct 2018 10:21:08 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: introduce the '-V' short option for
 '--verbose-log'
Message-ID: <20181029142108.GD17668@sigill.intra.peff.net>
References: <20181029121359.7323-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181029121359.7323-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 01:13:59PM +0100, SZEDER Gábor wrote:

> '--verbose-log' is one of the most useful and thus most frequently
> used test options, but due to its length it's a pain to type on the
> command line.
> 
> Let's introduce the corresponding short option '-V' to save some
> keystrokes.

Interesting. I'm not opposed to something like this, but I added
"--verbose-log" specifically for scripted cases, like running an
unattended "prove" that needs to preserve stdout. When running
individual tests, I'd just use "-v" itself, and possibly redirect the
output.

For my curiosity, can you describe your use case a bit more?

>  t/README      | 1 +
>  t/test-lib.sh | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

The patch itself looks good to me.

-Peff
