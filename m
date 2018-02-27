Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97EB11F404
	for <e@80x24.org>; Tue, 27 Feb 2018 13:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeB0Nt0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 08:49:26 -0500
Received: from siwi.pair.com ([209.68.5.199]:47314 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbeB0NtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 08:49:25 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5995E3F4043;
        Tue, 27 Feb 2018 08:49:24 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 340AF3F403F;
        Tue, 27 Feb 2018 08:49:24 -0500 (EST)
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <29bd960d-80e4-8bd6-c8f2-aa2860de183b@jeffhostetler.com>
Date:   Tue, 27 Feb 2018 08:49:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/21/2018 7:31 PM, Junio C Hamano wrote:
> 
> * jh/status-no-ahead-behind (2018-01-24) 4 commits
>   - status: support --no-ahead-behind in long format
>   - status: update short status to respect --no-ahead-behind
>   - status: add --[no-]ahead-behind to status and commit for V2 format.
>   - stat_tracking_info: return +1 when branches not equal
> 
>   "git status" can spend a lot of cycles to compute the relation
>   between the current branch and its upstream, which can now be
>   disabled with "--no-ahead-behind" option.
> 
>   At v5; is this ready for 'next'?

yes, i believe so.

thanks
jeff

