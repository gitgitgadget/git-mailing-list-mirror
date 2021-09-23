Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12EC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3859A60F48
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 14:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbhIWONG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 10:13:06 -0400
Received: from siwi.pair.com ([209.68.5.199]:40602 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241304AbhIWONG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 10:13:06 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7F2A23F4095;
        Thu, 23 Sep 2021 10:11:34 -0400 (EDT)
Received: from WIN10-A.eucom.mil (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 520343F4090;
        Thu, 23 Sep 2021 10:11:34 -0400 (EDT)
Subject: Re: [PATCH 1/5] fsmonitor: enhance existing comments
To:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
 <6be687ba39d49f56a0729d3197ecbf3a64041357.1631822063.git.gitgitgadget@gmail.com>
 <2b7f0885-bb76-d695-941d-3160a8d62ccc@gmail.com> <xmqqr1dnitve.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f24512e5-2828-2bf1-67c8-493ecb3d73b6@jeffhostetler.com>
Date:   Thu, 23 Sep 2021 10:11:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1dnitve.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/17/21 2:44 AM, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> On 17/09/21 02.54, Jeff Hostetler via GitGitGadget wrote:
>>> -		/* If we're going to check every file, ensure we save the results */
>>> +		/*
>>> +		 * If we're going to check every file, ensure we save
>>> +		 * the results.
>>> +		 */
>>
>> Why did you split the comment above?
> 
> I would guess that the reason why it is done is because the original
> line is overly long it (extends to 84 columns, if I am counting
> correctly).
> 

Yes, I just wrapped it because it was too long and the commit
was focused on improving other nearby comments (and no code),
so it seemed like a good opportunity to cleanup this one too.

Jeff
