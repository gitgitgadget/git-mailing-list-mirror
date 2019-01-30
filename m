Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE5C1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 18:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbfA3SqB (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 13:46:01 -0500
Received: from siwi.pair.com ([209.68.5.199]:26249 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733116AbfA3SqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 13:46:01 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2E7363F404C;
        Wed, 30 Jan 2019 13:46:00 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B543C3F401C;
        Wed, 30 Jan 2019 13:45:59 -0500 (EST)
Subject: Re: [PATCH 00/14] Trace2 tracing facility
To:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.git.gitgitgadget@gmail.com>
 <20190125200309.GB72177@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <731e57f4-3474-9fd4-8b3e-812f648a8bed@jeffhostetler.com>
Date:   Wed, 30 Jan 2019 13:45:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190125200309.GB72177@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/25/2019 3:03 PM, Josh Steadmon wrote:
> On 2019.01.22 13:22, Jeff Hostetler via GitGitGadget wrote:
>> This patch series contains a greatly refactored version of my original
>> Trace2 series [1] from August 2018.
>>
>> A new design doc in Documentation/technical/api-trace2.txt (in the first
>> commit) explains the relationship of Trace2 to the current tracing facility.
>> Calls to the current tracing facility have not been changed, rather new
>> trace2 calls have been added so that both continue to work in parallel for
>> the time being.
>>
...
> 
> Several patches in this series have many style diffs as reported by
> clang-format. Not all the diffs actually improve readability, but many
> do. If you have clang-format installed, you can run:
> 
> git clang-format --style file --diff --extensions c,h ${commit}^ ${commit}
> 
> for each commit in the series to see what it thinks needs to be changed.

Thanks for the pointer.  I'll address this in my V3 version.
Yes, there were lots of complaints.  Some were more noise than
anything else, but there were some good ones in there.


> 
> Other than that, I don't have any comments apart from what the other
> reviewers have already mentioned.
> 
> Thanks for the series!
> 

Thanks,
Jeff
