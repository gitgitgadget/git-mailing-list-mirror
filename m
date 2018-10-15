Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040B81F453
	for <e@80x24.org>; Mon, 15 Oct 2018 17:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJPBGv (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 21:06:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:41242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726585AbeJPBGv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 21:06:51 -0400
Received: (qmail 17839 invoked by uid 109); 15 Oct 2018 17:20:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Oct 2018 17:20:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1464 invoked by uid 111); 15 Oct 2018 17:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Oct 2018 13:19:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2018 13:20:41 -0400
Date:   Mon, 15 Oct 2018 13:20:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jacques Bodin-Hullin <j.bodinhullin@monsieurbiz.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Typo `dashes ?` -> `dashes?`
Message-ID: <20181015172041.GC1301@sigill.intra.peff.net>
References: <01020166741c381f-bd183f7f-725d-4b4f-9f5f-804560b2b00b-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020166741c381f-bd183f7f-725d-4b4f-9f5f-804560b2b00b-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 07:44:58PM +0000, Jacques Bodin-Hullin wrote:

> diff --git a/parse-options.c b/parse-options.c
> index 3b874a83a0c89..88512212392ae 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -352,7 +352,7 @@ static void check_typos(const char *arg, const struct option *options)
>  		return;
>  
>  	if (starts_with(arg, "no-")) {
> -		error ("did you mean `--%s` (with two dashes ?)", arg);
> +		error ("did you mean `--%s` (with two dashes?)", arg);

I agree the extra space in the original is stylistically weird, and your
suggestion is an improvement. However, I think this is really a question
"did you mean..." with a parenthetical phrase. Most style guides would
recommend putting the punctuation outside, like:

  error: did you mean `--foo` (with two dashes)?

Speaking of style, the extra space between "error" and "(" does not
match our usual coding style. It might be worth removing while we're
touching these lines.

-Peff
