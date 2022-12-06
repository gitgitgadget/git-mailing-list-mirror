Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD776C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 17:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiLFRZd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 12:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiLFRZc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 12:25:32 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03722D107
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 09:25:30 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 387B9CA126D;
        Tue,  6 Dec 2022 12:25:30 -0500 (EST)
Received: from [192.168.1.65] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CFAABCC8322;
        Tue,  6 Dec 2022 12:25:29 -0500 (EST)
Message-ID: <638298b2-4f63-a0b7-c783-b2a4fd4f2266@jeffhostetler.com>
Date:   Tue, 6 Dec 2022 12:25:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
 <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
 <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
 <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
 <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
 <1b090929-f2da-f075-01d4-458804fc0717@github.com>
 <xmqq1qphuwj6.fsf@gitster.g> <xmqqv8mqsm2g.fsf@gitster.g>
 <de558eb7-8931-a5b5-d711-459ae3f52216@jeffhostetler.com>
 <xmqqsfhtphpl.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqsfhtphpl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/5/22 6:13 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> I like this new text.  Let's do this and call it done.
> 
> Good. Thanks.
> 
>> Since I see that you have already added it to the commit message
>> in the branch, so I won't resubmit it unless there are further
>> technical review comments to address.
>>
>> Thanks all,
> 
> Thanks for working on this.  Let's mark it for 'next'.  Even though
> we'll see -rc2 very soonish, being in 'next' this early would mean
> it will be part of the first (if we need brown paper bag fixes) or
> the second batch in the next cycle.
> 


Great! Thanks!  And yes, there's nothing urgent for this fix,
so that would be fine.

Jeff
