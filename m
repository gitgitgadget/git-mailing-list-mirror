Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A111F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 10:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbfJJKME (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 06:12:04 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42274 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJJKME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 06:12:04 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iIVQO-0005ej-C9; Thu, 10 Oct 2019 11:12:01 +0100
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our
 Azure Pipeline
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
 <pull.288.v3.git.gitgitgadget@gmail.com>
 <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
 <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet>
 <xmqqzhicnfmr.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910081423250.46@tvgsbejvaqbjf.bet>
 <9ccbdb9a-845f-a534-29b6-52cfe9eb3229@iee.email>
 <nycvar.QRO.7.76.6.1910101102280.46@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a41a083e-ed18-eaed-8305-b7cf82d92878@iee.email>
Date:   Thu, 10 Oct 2019 11:12:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910101102280.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,
On 10/10/2019 10:03, Johannes Schindelin wrote:
>>> So a better interpretation would have been:
>>>
>>>   The default creation factor is 60 (roughly speaking, it wants at
>>>   most 60% of the diffs' lines to differ, otherwise it considers
>>>   them not to be a match.
>>>
>>> This is still inaccurate, but at least it gets the idea of the
>>> range-diff across.
>>>
>>> Of course, I will never be able to amend the commit message in
>>> GitGitGadget anyway, as I have merged that PR already.
>>>
>>> Ciao,
>>> Dscho
>> Medium term, is this something that could go in the algorithms section of the
>> range-diff man page, especially if the upstream commit message is already in
>> place.
>>
>> #leftoverdocs ?
> Sure. How about giving it a try while our memory is still fresh? You
> would help me immensely if you could take that task off of my plate...
My sneak think was to introduce the new hash tag for useful explanations 
from the list that could be copied into the man/guide pages, especially 
for the project pages.

At the moment I'm trying to get the >4Gb on Window' series sorted, which 
though working has been a load of bear traps for testing and configs and 
VS compiling, etc.
But yes, it is on the back-list.
-- 
Philip
