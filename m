Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F4F1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 18:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfIKSRo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 14:17:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:62434 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfIKSRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 14:17:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2A8623F40F4;
        Wed, 11 Sep 2019 14:17:43 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:f859:d84d:2974:d55a] (unknown [IPv6:2001:4898:a800:1012:a98d:d84d:2974:d55a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D50B23F40D5;
        Wed, 11 Sep 2019 14:17:42 -0400 (EDT)
Subject: Re: [PATCH 0/1] commit-graph: emit trace2 cmd_mode for each
 sub-command
To:     Garima Singh <garimasigit@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.323.git.gitgitgadget@gmail.com>
 <6d1e51c3-64a4-0075-5c9c-3302c5d07c50@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <da9a7ce5-736c-9d85-d655-cb19172063f8@jeffhostetler.com>
Date:   Wed, 11 Sep 2019 14:17:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6d1e51c3-64a4-0075-5c9c-3302c5d07c50@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/10/2019 9:54 AM, Garima Singh wrote:
> Ping :) Any thoughts on this?
> 
> On 8/27/2019 12:56 PM, Garima Singh via GitGitGadget wrote:
>> Emit trace2_cmd_mode() messages for each commit-graph sub-command.
>>
>> The commit graph commands were in flux when trace2 was making it's way to
>> git. Now that we have enough sub-commands in commit-graph, we can 
>> label the
>> various modes within them. Distinguishing between read, write and 
>> verify is
>> a great start.
>>
>> Signed-off-by: Garima Singh garima.singh@microsoft.com
>> [garima.singh@microsoft.com]
>>
>> CC: jeffhost@microsoft.com, stolee@gmail.com, garimasigit@gmail.com,
>> avarab@gmail.com
>>
>> Garima Singh (1):
>>    commit-graph: emit trace2 cmd_mode for each sub-command
>>
>>   builtin/commit-graph.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>>
>> base-commit: 745f6812895b31c02b29bdfe4ae8e5498f776c26
>> Published-As: 
>> https://github.com/gitgitgadget/git/releases/tag/pr-323%2Fgarimasi514%2FcoreGit-commit-graph-trace2-v1 
>>
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git 
>> pr-323/garimasi514/coreGit-commit-graph-trace2-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/323
>>

Looks good to me.  Thanks!

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
