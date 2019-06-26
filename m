Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25421F461
	for <e@80x24.org>; Wed, 26 Jun 2019 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZUOs (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 16:14:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:43900 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfFZUOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 16:14:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D8FE23F48C2;
        Wed, 26 Jun 2019 16:14:47 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:6539:9c95:c83:2e4f] (unknown [IPv6:2001:4898:a800:1010:166f:9c95:c83:2e4f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8A6CC3F48E4;
        Wed, 26 Jun 2019 16:14:47 -0400 (EDT)
Subject: Re: [PATCH] trace2: correct typo in technical documentation
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, szeder.dev@gmail.com
References: <20190626200303.9834-1-carenas@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fbe5f66f-6e3e-751c-78af-7c73fa1fac25@jeffhostetler.com>
Date:   Wed, 26 Jun 2019 16:14:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626200303.9834-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/26/2019 4:03 PM, Carlo Marcelo Arenas Belón wrote:
> an apparent typo for the environment variable was included with 81567caf87
> ("trace2: update docs to describe system/global config settings",
> 2019-04-15), and was missed when renamed variables by e4b75d6a1d
> ("trace2: rename environment variables to GIT_TRACE2*", 2019-05-19)
> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   Documentation/technical/api-trace2.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 23c3cc7a37..f7ffe7d599 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -35,7 +35,7 @@ Format details are given in a later section.
>   === The Normal Format Target
>   
>   The normal format target is a tradition printf format and similar
> -to GIT_TRACE format.  This format is enabled with the `GIT_TR`
> +to GIT_TRACE format.  This format is enabled with the `GIT_TRACE2`
>   environment variable or the `trace2.normalTarget` system or global
>   config setting.
>   
> 

Good catch!

Thanks,
Jeff
