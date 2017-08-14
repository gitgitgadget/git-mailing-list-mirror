Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0DD520899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbdHNWse (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:48:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:38622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752643AbdHNWse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:48:34 -0400
Received: (qmail 29251 invoked by uid 109); 14 Aug 2017 22:48:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 22:48:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6652 invoked by uid 111); 14 Aug 2017 22:48:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 18:48:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 18:48:31 -0400
Date:   Mon, 14 Aug 2017 18:48:31 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peartben@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
Message-ID: <20170814224831.qhs7b44bg7v7tryx@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170814213046.107576-2-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 02:30:45PM -0700, Brandon Williams wrote:

> +# Align escaped newlines as far left as possible
> +# #define A   \
> +#   int aaaa; \
> +#   int b;    \
> +#   int cccccccc;
> +AlignEscapedNewlines: Left

I get:

  $ git clang-format-5.0 --style file -p --extensions c,h
  YAML:34:23: error: unknown key 'AlignEscapedNewlines'
  AlignEscapedNewlines: Left
                        ^~~~
  Error reading /home/peff/compile/git/.clang-format: Invalid argument

Same with clang-format-3.8.

-Peff
