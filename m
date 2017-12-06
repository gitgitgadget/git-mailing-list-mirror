Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F4620C11
	for <e@80x24.org>; Wed,  6 Dec 2017 21:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbdLFVHh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 16:07:37 -0500
Received: from siwi.pair.com ([209.68.5.199]:24918 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbdLFVHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 16:07:37 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B3F24844D7;
        Wed,  6 Dec 2017 16:07:36 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6CE66844D5;
        Wed,  6 Dec 2017 16:07:36 -0500 (EST)
Subject: Re: partial_clone_get_default_filter_spec has no callers
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <ec83f2d9-0d87-9d6b-4860-f4cd7c19984e@ramsayjones.plus.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <89d06941-9bee-9334-d737-11ef7801cba2@jeffhostetler.com>
Date:   Wed, 6 Dec 2017 16:07:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <ec83f2d9-0d87-9d6b-4860-f4cd7c19984e@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/6/2017 12:39 PM, Ramsay Jones wrote:
> Hi Jeff,
> 
> commit f1862e8153 ("partial-clone: define partial clone settings
> in config", 2017-12-05), which is part of your 'jh/partial-clone'
> branch, introduces the partial_clone_get_default_filter_spec()
> function without any callers. Could you please confirm that this
> is intentional and that, presumably, a future series will include
> a call to this function.

I'll double check.  Thanks.

BTW is there another tool that you're using to find these?
I know I ran make DEVELOPER=1 and make sparse on everything
and didn't see that come up.

Jeff

