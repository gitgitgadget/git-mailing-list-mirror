Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE30C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF830650A5
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEVem (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:34:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:18886 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhCEVeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 16:34:36 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B0DFD3F40D9;
        Fri,  5 Mar 2021 16:34:35 -0500 (EST)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 84F993F4096;
        Fri,  5 Mar 2021 16:34:35 -0500 (EST)
Subject: Re: [PATCH 0/8] Simple IPC Cleanups
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.893.git.1614889047.gitgitgadget@gmail.com>
 <xmqqlfb2bg6c.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8ea6401c-6ee6-94cb-4e33-9dfffaf466e8@jeffhostetler.com>
Date:   Fri, 5 Mar 2021 16:34:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfb2bg6c.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/4/21 7:24 PM, Junio C Hamano wrote:
> sparse failed seen, so I tentatively added this on top of your
> series.
> 
> Thanks.
> 
>   t/helper/test-simple-ipc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
> index 4da63fd30c..42040ef81b 100644
> --- a/t/helper/test-simple-ipc.c
> +++ b/t/helper/test-simple-ipc.c
> @@ -227,7 +227,7 @@ struct cl_args
>   	char bytevalue;
>   };
>   
> -struct cl_args cl_args = {
> +static struct cl_args cl_args = {
>   	.subcommand = NULL,
>   	.path = "ipc-test",
>   	.token = NULL,
> 

Thanks!!

I'll update my copy.

Since things are settling down on the whole simple-ipc series and
we are waiting for the current release cycle to complete before
going any further, I'm going to let this series rest for a bit
in case there are any more comments.

Then I'll combine the 2 parts and rebase/re-roll all of this into
a single series that we can re-eval for "next" post 2.31.

Jeff
