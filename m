Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DC601F462
	for <e@80x24.org>; Fri, 14 Jun 2019 15:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfFNPxh (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 11:53:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:50748 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNPxh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 11:53:37 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5B0273F4842;
        Fri, 14 Jun 2019 11:53:36 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:31f7:1de2:546:4d13] (unknown [IPv6:2001:4898:a800:1012:e32a:1de2:546:4d13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2AE923F40EB;
        Fri, 14 Jun 2019 11:53:36 -0400 (EDT)
Subject: Re: [RFC PATCH 1/3] trace2: correct trace2 field name documentation
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <cover.1560295286.git.steadmon@google.com>
 <8bcd72a762f0fd349f8bf7d0b134cc7033ae6f00.1560295286.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b1b08df1-3b4d-9d5a-f052-a21cacb2c2cd@jeffhostetler.com>
Date:   Fri, 14 Jun 2019 11:53:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8bcd72a762f0fd349f8bf7d0b134cc7033ae6f00.1560295286.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/11/2019 7:31 PM, Josh Steadmon wrote:
> Correct the api-trace2 documentation, which lists "signal" as an
> expected field for the signal event type, but which actually outputs
> "signo" as the field name.
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>   Documentation/technical/api-trace2.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 23c3cc7a37..fd1e628944 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -668,7 +668,7 @@ completed.)
>   	"event":"signal",
>   	...
>   	"t_abs":0.001227,  # elapsed time in seconds
> -	"signal":13        # SIGTERM, SIGINT, etc.
> +	"signo":13         # SIGTERM, SIGINT, etc.
>   }
>   ------------
>   
> 

Nice!

Thanks,
Jeff
