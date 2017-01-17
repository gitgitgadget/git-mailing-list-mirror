Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB4420756
	for <e@80x24.org>; Tue, 17 Jan 2017 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdAQPfK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 10:35:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:40206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbdAQPfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 10:35:10 -0500
Received: (qmail 5467 invoked by uid 109); 17 Jan 2017 15:35:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:35:09 +0000
Received: (qmail 18205 invoked by uid 111); 17 Jan 2017 15:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 10:36:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 10:35:07 -0500
Date:   Tue, 17 Jan 2017 10:35:07 -0500
From:   Jeff King <peff@peff.net>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v5 7/7] t/t7004-tag: Add --format specifier tests
Message-ID: <20170117153507.vr3i6k5hl3whjorf@sigill.intra.peff.net>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-8-santiago@nyu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170115184705.10376-8-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 15, 2017 at 01:47:05PM -0500, santiago@nyu.edu wrote:

> From: Santiago Torres <santiago@nyu.edu>
> 
> tag -v now supports --format specifiers to inspect the contents of a tag
> upon verification. Add two tests to ensure this behavior is respected in
> future changes.
> 
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  t/t7004-tag.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 07869b0c0..b2b81f203 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -874,6 +874,22 @@ test_expect_success GPG 'verifying a forged tag should fail' '
>  	test_must_fail git tag -v forged-tag
>  '
>  
> +test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
> +	cat >expect <<-\EOF 

Trailing whitespace after "EOF" here (and below). Otherwise the tests
look reasonable to me.

-Peff
