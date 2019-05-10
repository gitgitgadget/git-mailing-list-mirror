Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822A71F45F
	for <e@80x24.org>; Fri, 10 May 2019 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfEJPKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 11:10:42 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:36656 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJPKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 11:10:42 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id P7AVhhwc1draxP7AVhwmig; Fri, 10 May 2019 16:10:40 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20 a=EDlGl3OzOG1hMp6laB0A:9
 a=QEXdDO2ut3YA:10 a=APqgjxcRD6nqXdMuohh7:22
Subject: Re: How to exchange rerere/redo resolutions?
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org>
 <20190510140539.77elozdmfnlkys3v@tb-raspi4>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <744473e7-14e6-fed0-664b-ac0a75e80919@iee.org>
Date:   Fri, 10 May 2019 16:10:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510140539.77elozdmfnlkys3v@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGFPSG3CXdMigRpMKPIq+0S0+Y9tA4o+oYNcC5+8CGWUI6HqNvXPR0XwwgFMjTCvfkLPZAFy3gAA1FRcAVTgR9ReGzTvTnnHSC6/HWfLxafZiMs/pfC4
 aaXO4aNZ8hDb+fTkYhfUrmRgqdWXJnPsvr2aUUr1Cqpg2umkWyKYV+kyAmT5eYBBafKyXLDvDE9zalx3sWixh1avi81bid04cwPOEiEDBJaM1ulqbYTXgzAZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

On 10/05/2019 15:05, Torsten Bögershausen wrote:
> On Fri, May 10, 2019 at 12:23:28AM +0100, Philip Oakley wrote:
>> Hi,
>>
>> Is there a mechanism for exchanging the rerere resolutions, so that future
>> fixups, e.g. future clashes on pu rather than master, can be sent with patch
>> series?
>>
>> My current use case that there is a large patch [1] for updating long to
>> size_t for use on Windows, which notes that it will have clashes with pu,
>> but doesn't appear to have any method  of sending a rerere resolution (which
>> the author is already aware of) to the list. Being able to flag up such
>> fixes should simplify such conflict resolutions.
>>
>> I had some very rough ideas about how the resolutions should look rather
>> similar to three-way conflict markers, with the resolution as the 'base'
>> (between the ||| - ||| marks), which would be resolved via a --base merge
>> strategy.
>>
>> However if there is already a method for exchanging resolutions, where
>> should I look?
>>
>> Philip
>>
>> [1] <20190413151850.29037-1-tboegi@web.de> [PATCH v3 1/1] Use size_t instead
>> of 'unsigned long' for data in memory
>>
>> --
>> Philip
>>
> That is not an answer to the question.
> If it helps, I can rebase the first patch onto git.git/master, and the
> cherry-pick the next patches. That can happen next week or so.
> And then let it go through the normal pu->next->master->git-for-windows workflow.
>
Thanks for the offer, but I should be OK. dscho has already asked that 
for testing on Git for Windows I rebase my series back onto master, 
rather than pu. The series is at 
https://github.com/git-for-windows/git/pull/2179#issuecomment-491095412
--
Philip
