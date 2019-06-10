Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFB5E1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 14:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbfFJOnh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 10:43:37 -0400
Received: from siwi.pair.com ([209.68.5.199]:28869 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389178AbfFJOnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 10:43:37 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 27D9D3F400D;
        Mon, 10 Jun 2019 10:43:37 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:7414:a9f:53d2:2961] (unknown [IPv6:2001:4898:a800:1010:254a:a9f:53d2:2961])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BFA053F400C;
        Mon, 10 Jun 2019 10:43:36 -0400 (EDT)
Subject: Re: [PATCH 0/1] Optimize run_diff_files()' rename detection
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.142.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bd404b8b-7747-3e29-8d14-ed2f04d12292@jeffhostetler.com>
Date:   Mon, 10 Jun 2019 10:43:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <pull.142.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/8/2019 10:42 AM, Johannes Schindelin via GitGitGadget wrote:
> Just another patch from Git for Windows' branch thicket...
> 
> Jeff Hostetler (1):
>    diffcore-rename: speed up register_rename_src
> 
>   diffcore-rename.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> 
> base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-142%2Fdscho%2Fregister_rename_src-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-142/dscho/register_rename_src-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/142
> 

For the sake of full disclosure, we added this patch
to Git for Windows in December 2016.

It was discussed on the mailing list in April 2017 [1] but
it was shelved for various reasons.

Let me put this one on hold while I dig up my notes from 2016
and re-review of the original mailing list suggestions and
see where I want to take this patch going forward.

Jeff


[1] 
https://public-inbox.org/git/20170418194421.22453-1-git@jeffhostetler.com/
