Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2A51F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHXA0Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:26:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:56335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeHXA0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:26:16 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lk8CY-1gPWIB2yZm-00cC7C; Thu, 23
 Aug 2018 22:54:45 +0200
Date:   Thu, 23 Aug 2018 22:54:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kyle Meyer <kyle@kyleam.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
In-Reply-To: <20180823023955.12980-1-kyle@kyleam.com>
Message-ID: <nycvar.QRO.7.76.6.1808232254260.73@tvgsbejvaqbjf.bet>
References: <20180823023955.12980-1-kyle@kyleam.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:myr2cPtgmU6EGeHYWPWjeUeYCYg10anspWB3F7+nlg7duEoOvDZ
 UtzEgeEDw4Shr1umRrkozU/eN3Z5gTjn0bW28UDsy2TERJHwq1Gpw6xM4ypgx0TNXr8pzU8
 pJQ/XhdJgDPYmmbmQ7QrSZcnurSHElsp+OmgpoWa3Y/j01vz7mAfKQja/3qq3y6ifnQyCZz
 31H6YH2EZibb2TNhBsP1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oP4HdjhjheA=:6lql9eBDwI00NkYHSi7Zts
 xAg/kruuFiE4aK3hGq/r1y5C0KaSDfuk15BP6VREHDsjWrNp9t/sZP1440LptBwTW1zEf9O/1
 UrNNmLwG/LGT7GUjTYKcPrRq9CfxV6Ce6F1V2GHdozmy/7Y5WEhPoTR41R2lOGKv0SpAdeWvj
 IkDaqFQ3+lGJp6ExAMJHKv7ZcvqvRUpw7aWb4Znx2Lz8AwLeQ4PBkI/gOjw8hr43fcQ8ddNf3
 ZXN3vXdwrIb5ASBWF8GwJ2uuQmXAia9Jg3nS4fenAmiZo+Ym/07O1QhxYnwA0IOwrWTm6dBSK
 /o5UwZYzqjRnQ+3Y/cCDa6PKuInIhIXKFeLftqfIs0nzVShRhW/K9eTxAPaN1kXMLws/Kt78s
 TlaG2XjHSp+HFriuloBa1xPuZ5oYxKQyFQDZ2rlPnQX5zAB2o+wOpA7EAV5NpgYfC4H3oszKA
 5KYCneKLGwIEINUvNAP8Nu5tXlYotO7gN7rBgROI5nh0mE/0J1rFuEwklmrSFGw6Ef9oBaGfE
 WVPvMIAC8gHxN3qAPXOb6EUiu+kCfyLL/N/xF8hwxBrNvhvF4jiH2oP5UObIKNCA0VRi3Gz3u
 9nwiagvlfw83xS+66ta51Rq4ENhcCYeuZ1e15AO6GccrlzBCSWRSvRmSY2ykf/apALvhShJzN
 zEgG0ocSmF0e4fCVL6lG8I+usa+xtkkHXC3vcejOr78k/2YhbdyqMFnjOpc/2e8zjR9WV0cOv
 mVEzaY+JMftYimpHw0Z24ogwbxyorW3g7uicV9MZiMxyTqOmRD1sA/lp/edYLZOAGbyCJaeqd
 3d3ebpc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyle,

On Wed, 22 Aug 2018, Kyle Meyer wrote:

> 275267937b (range-diff: make dual-color the default mode, 2018-08-13)
> replaced --dual-color with --no-dual-color but left the option's
> summary untouched.  Rewrite the summary to describe --no-dual-color
> rather than dual-color.
> 
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  builtin/range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index f52d45d9d6..7dc90a5ec3 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("Percentage by which creation is weighted")),
>  		OPT_BOOL(0, "no-dual-color", &simple_color,
> -			    N_("color both diff and diff-between-diffs")),
> +			    N_("restrict coloring to outer diff markers")),

How about "use simple diff colors" instead?

Ciao,
Johannes
