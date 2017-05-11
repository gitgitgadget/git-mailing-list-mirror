Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EF92018D
	for <e@80x24.org>; Thu, 11 May 2017 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756559AbdEKQrc (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 12:47:32 -0400
Received: from avasout07.plus.net ([84.93.230.235]:47742 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755996AbdEKQrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 12:47:31 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id K4nU1v0021keHif014nVdg; Thu, 11 May 2017 17:47:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=HP2zLslv c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=2qf7H4-Y0uIwZZparVoA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/4] docs/config: clarify include/includeIf relationship
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <20170511090905.tvkb4bk2ddjzjip4@sigill.intra.peff.net>
 <20170511091047.2dw52pnriulhjky3@sigill.intra.peff.net>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0013fb73-12f2-a365-963e-ed517ea53dc7@ramsayjones.plus.com>
Date:   Thu, 11 May 2017 17:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170511091047.2dw52pnriulhjky3@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/05/17 10:10, Jeff King wrote:
> The "includeIf" directives behave exactly like include ones,
> except they only kick in when the conditional is true. That
> was mentioned in the "conditional" section, but let's make
> it more clear for the whole "includes" section, since people
> don't necessarily read the documentation top to bottom.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d5..d5a453ed3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -79,14 +79,20 @@ escape sequences) are invalid.
>  Includes
>  ~~~~~~~~
>  
> +The `include` and `includeIf` sections allow you include config

s/you include/you to include/

ATB,
Ramsay Jones
