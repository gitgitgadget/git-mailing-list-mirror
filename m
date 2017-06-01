Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9669520D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbdFAPxY (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:53:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:33239 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbdFAPxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:53:18 -0400
Received: (qmail 24263 invoked by uid 109); 1 Jun 2017 15:53:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 15:53:11 +0000
Received: (qmail 18767 invoked by uid 111); 1 Jun 2017 15:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 11:53:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 11:53:12 -0400
Date:   Thu, 1 Jun 2017 11:53:12 -0400
From:   Jeff King <peff@peff.net>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] docs: fix formatting and grammar
Message-ID: <20170601155311.urqaxmjagqgiogmh@sigill.intra.peff.net>
References: <20170601095520.GA25777@dinwoodie.org>
 <20170601103703.12216-1-adam@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170601103703.12216-1-adam@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 11:37:03AM +0100, Adam Dinwoodie wrote:

> When compiling the documentation, asciidoc thinks a backtick surrounded
> by whitespace shouldn't be interpreted as marking the start or end of a
> literal.  In most cases, that's useful behaviour, but in the git-pull
> documentation it means asciidoc is failing to correctly detect which
> text should be monospaced and which shouldn't.
> 
> To avoid this, remove the extraneous spaces from the text to be
> monospaced.  It would also be possible to fix the formatting by
> switching to asciidoc's ++ monospace format markers and still have the
> space characters included in the monospace text, but the spaces aren't
> necessary and not having them keeps the markup simpler.
> 
> Also include a minor grammar fix suggested by Jeff while we're changing
> these lines.
> 
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> Helped-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git-pull.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks fine, although...

>  In order to determine what URL to use to fetch from, the value
>  of the configuration `remote.<origin>.url` is consulted
> -and if there is not any such variable, the value on `URL: ` line
> +and if there is not any such variable, the value on the `URL:` line
>  in `$GIT_DIR/remotes/<origin>` file is used.

...I should have read to the end of the sentence. It should also be "in
the `$GIT_DIR/remotes/<origin>` file". Or just drop "file".

-Peff
