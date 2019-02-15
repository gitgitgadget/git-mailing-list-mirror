Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23ED61F453
	for <e@80x24.org>; Fri, 15 Feb 2019 16:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbfBOQsP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 11:48:15 -0500
Received: from siwi.pair.com ([209.68.5.199]:23463 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfBOQsP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 11:48:15 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BC1CC3F401D;
        Fri, 15 Feb 2019 11:48:14 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8ED5B3F401C;
        Fri, 15 Feb 2019 11:48:14 -0500 (EST)
Subject: Re: [PATCH 1/1] fixup! trace2: collect Windows-specific process
 information
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.123.git.gitgitgadget@gmail.com>
 <6af9ad6fbbd9ebeb4077ad2167e4e60674b1df75.1549912358.git.gitgitgadget@gmail.com>
 <xmqqy36lgbfq.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1d5423df-9f2e-dab6-b0b3-ed332915ce58@jeffhostetler.com>
Date:   Fri, 15 Feb 2019 11:48:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqy36lgbfq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/11/2019 6:19 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Guard against infinite loop while computing the parent process hierarchy.
...
>> ---
>>   compat/win32/trace2_win32_process_info.c | 32 ++++++++++++++++++------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> Thanks.  Will queue for now, but shortly after the final, I expect
> the whole topic to be eligible to graduate to the 'master' track.
> At that point, you may want to help rephrase the log message of the
> original when this gets squashed in.  Alternatively, we could leave
> these two separate patches.

I'll squash this into the next version of my main patch series
and update the in-code comments to explain.

I thought I saw a note that you were moving my V6 into "next" and
didn't want this patch to "cross in the mail" if I quickly re-rolled
a V7.

Thanks,
Jeff



