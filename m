Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48325C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2508613C8
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhD3Oej (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:34:39 -0400
Received: from siwi.pair.com ([209.68.5.199]:15682 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232910AbhD3Oei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:34:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0F4623F4135;
        Fri, 30 Apr 2021 10:33:50 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D38203F4129;
        Fri, 30 Apr 2021 10:33:49 -0400 (EDT)
Subject: Re: [PATCH 06/23] fsmonitor--daemon: implement client command options
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <77170e521f67ce92587d833334f6951a9f375d4d.1617291666.git.gitgitgadget@gmail.com>
 <098e4123-676e-2ea0-4c16-dbeaa1198b46@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b0fe4d10-1205-39e4-72c9-d33d1f023730@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 10:33:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <098e4123-676e-2ea0-4c16-dbeaa1198b46@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 11:12 AM, Derrick Stolee wrote:
> On 4/1/21 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Implement command options `--stop`, `--is-running`, `--query`,
>> `--query-index`, and `--flush` to control and query the status of a
>> `fsmonitor--daemon` server process (and implicitly start a server
>> process if necessary).
>>
>> Later commits will implement the actual server and monitor
>> the file system.
> 
> As mentioned before, I think the "query", "query-index", and
> "flush" commands are better served in a test helper. Luckily,
> the implementation you give here seems rather straightforward
> and could fit into a test helper without a lot of duplicated
> boilerplate. That's a good sign for the API presented here.
> 
> As a bonus, you could delay the implementation of those test
> helpers until they are going to be used in a test.
> 
> Thanks,
> -Stolee
> 

Good point.  I'll take a look at this.

Thanks
Jeff
