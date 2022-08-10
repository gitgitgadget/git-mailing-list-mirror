Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0044EC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 07:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiHJHTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 03:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHJHS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 03:18:58 -0400
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29483F0A
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 00:18:57 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4M2hBP17Pzz5tlB;
        Wed, 10 Aug 2022 09:18:52 +0200 (CEST)
Message-ID: <4e54c11d-d01d-7777-89e7-8799180c2931@kdbg.org>
Date:   Wed, 10 Aug 2022 09:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] rev-list: support human-readable output for
 `--disk-usage`
Content-Language: en-US
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Li Linchao <lilinchao@oschina.cn>
References: <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
 <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.08.22 um 08:01 schrieb Li Linchao via GitGitGadget:
>  --disk-usage::
> +--disk-usage=human::
>  	Suppress normal output; instead, print the sum of the bytes used
> -	for on-disk storage by the selected commits or objects. This is
> +	for on-disk storage by the selected commits or objects.
> +	When it accepts a value `human`, like: `--disk-usage=human`, this
> +	means to print objects size in human readable format. This is
>  	equivalent to piping the output into `git cat-file
>  	--batch-check='%(objectsize:disk)'`, except that it runs much
>  	faster (especially with `--use-bitmap-index`). See the `CAVEATS`

The original paragraph flows very well and explains what the option does
and how it computes the result. Please do not interrupt the flow of the
text with a whole sentence that should be just a parenthetical remark,
but add a sentence at the end, not in the middle.

You added a new feature, and I understand that it is important *to you*.
But do make it a habit to ask yourself if it is also important for the
general audience. Generally, a new feature is not as important as
existing features, otherwise, it would have been added earlier, wouldn't it?

-- Hannes
