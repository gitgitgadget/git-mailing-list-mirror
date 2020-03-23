Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D252CC54FCE
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5DD20735
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 15:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgCWP2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:28:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:46607 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCWP2U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 11:28:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A2F613F40F0;
        Mon, 23 Mar 2020 11:28:19 -0400 (EDT)
Received: from [IPv6:2600:1700:840:e760:d176:7e02:3c1a:eb95] (unknown [IPv6:2600:1700:840:e760:d176:7e02:3c1a:eb95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 46B283F4047;
        Mon, 23 Mar 2020 11:28:19 -0400 (EDT)
Subject: Re: [PATCH] trace2: teach Git to log environment variables
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <0f5607a4242cc7b61ad36d0782c9d1250c4d4d7d.1584737973.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <aa4d22be-3710-1377-97aa-8ce8cfde0e20@jeffhostetler.com>
Date:   Mon, 23 Mar 2020 11:28:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0f5607a4242cc7b61ad36d0782c9d1250c4d4d7d.1584737973.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/20/20 5:06 PM, Josh Steadmon wrote:
> Via trace2, Git can already log interesting config parameters (see the
> trace2_cmd_list_config() function). However, this can grant an
> incomplete picture because many config parameters also allow overrides
> via environment variables.
>
> To allow for more complete logs, we add a new trace2_cmd_list_env_vars()
> function and supporting implementation, modeled after the pre-existing
> config param logging implementation.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> As I mentioned in the commit message, I modeled this pretty closely on
> the config parameter reporting code. It may make sense to split some of
> this out into its own file, particularly the parts in trace2/tr2_cfg.c.
> Alternatively, we could also just make the env var reporting part of the
> config param reporting. Let me know if you have a preference either way.
>
Looks good to me.

Jeff


