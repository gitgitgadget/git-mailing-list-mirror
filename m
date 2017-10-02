Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497DA20281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdJBRQg (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:16:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:65370 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751065AbdJBRQf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:16:35 -0400
Received: from [192.168.178.43] ([88.70.159.90]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk3f-1dngZh1KTj-00Xrh8; Mon, 02
 Oct 2017 19:16:30 +0200
Subject: Re: [PATCH v3] clang-format: add a comment about the meaning/status
 of the
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
 <20171001154425.5568-1-s-beyer@gmx.net>
 <xmqqpoa6tp79.fsf_-_@gitster.mtv.corp.google.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <ce2267e3-21af-dbfc-5b20-45e272a775fb@gmx.net>
Date:   Mon, 2 Oct 2017 19:16:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoa6tp79.fsf_-_@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:n0ufYRYtFdiHHW0VW5kC7XkkPIC7umf+RJXbMG7TpGpXjSUahPT
 bqC3xDsv4OAqwzq0F4+MHBcHLC0Sr+I8H9Snrc5lZG8PUX8YwgCgjfYGZo5rzZ+o1BD658a
 E5IlQ/ZHy3GxDImdEGA8I/Svn0rvfRC2ofB5jlIMbZ8LRAA/BVFMt6lr6rGmLcXfQjgaPRP
 S6SXPiOQYM54CxQH+c1KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XZED60GF4T8=:zJYWrs7U527aujp5b3hezK
 wqGE0iDoNwcY61hf3r4Ie4CN2vIJw0phzdlXerWjtYRI6z/CxNJGYbOZvXSK42PjhEpxYHBmU
 9JA4JgQiwIsbCZTnjvmQHdaFqv4dYziLGxeKf90nZkttuoNcyJJqO70kNF36njKOcVSpXaJes
 DpITvj3bRdm2zqlaCKljppV3Hl9ElTmcygKZ+PBr3uc/+oYrQXkR9UDSo+gnxTs2skuXB+8lX
 THoZki31ZtxbXwlYKuTnCKfp/+reVL4ep8wZsiy9ox7kmBFKyHdA9UEIdSJ4LQEdO8SdIih4A
 7asmMUC/ndhOXPtj8FFml6FkWXvDYizMr9u2kf/XcXrTGFY4GzduzddXosz+uv3V3ckBdZeW2
 BuyVrjgcNXkLtEJ8bxZfkNzoLIRs2zf54HeoUH8coAmWkjsDORtHZI1V95OeWxb6FOraSCSUv
 B82qQjxMLC90HxJUamRJbTLQC8a+p4Ys+dplzn4ASyA6HmzNwUufJ02fp6ffVlAphBgKmDIFt
 mOMwGH704QzL6EXz/L1P1TcNargl9zBCiRT50p19Bxbjj70iIb6C1riAdRNp//bMbf/gr/H8X
 aTs3ezUcxX5yz8mZGM8WhQZS8qOQ3Ed+qtM4umB73zXuFzvPYgh1CmhPzd8N2MBC7psYv0dgw
 rOBBhM02feXPb79Ol1pC7R8uy7DBvXU/8jLdj8RBf65DcWy+ssah730095+g1aFJR/7u5P2rR
 dDHhKckqsSz5STIvgQGfGI7NncUAZ121N1s2QWNV5vajh12Y3Tvs7gq/jIBwvq6djPPSjVfvj
 BC2/GCr/YlUCiLyXxhYZf9PqFxpgTrh8vGbusp6xfUHReZMeh0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/02/2017 01:37 AM, Junio C Hamano wrote:
> diff --git a/.clang-format b/.clang-format
> index 56822c116b..7670eec8df 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -1,4 +1,8 @@
> -# Defaults
> +# This file is an example configuration for clang-format 5.0.
> +#
> +# Note that this style definition should only be understood as a hint
> +# for writing new code. The rules are still work-in-progress and does
> +# not yet exactly match the style we have in the existing code.

I'm totally fine with this.

Stephan
