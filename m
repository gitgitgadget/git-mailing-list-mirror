Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13801C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhL0SvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 13:51:10 -0500
Received: from siwi.pair.com ([209.68.5.199]:34054 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhL0SvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 13:51:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 586B13F4095;
        Mon, 27 Dec 2021 13:51:09 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2791E3F4090;
        Mon, 27 Dec 2021 13:51:09 -0500 (EST)
Subject: Re: [PATCH 3/9] trace2: defer free of TLS CTX until program exit.
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
 <e0c41e1fc7895ba67d7536115cd8c1598439ded1.1640012469.git.gitgitgadget@gmail.com>
 <xmqqlf0equs3.fsf@gitster.g>
 <a6f2a38b-926a-4b47-fd3f-b1327a7c3fcb@jeffhostetler.com>
 <xmqqwnjwdz9j.fsf@gitster.g> <84bce2d2-b6ff-547d-2d1f-a79200eb79a3@kdbg.org>
 <xmqqee63chi3.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9ec28546-beb1-8cf6-c870-cbb613581a4c@jeffhostetler.com>
Date:   Mon, 27 Dec 2021 13:51:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqee63chi3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/23/21 1:18 PM, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 22.12.21 um 23:56 schrieb Junio C Hamano:
>>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>>
>>>> I hadn't really thought about the term "TLS" in the context
>>>> of crypto -- I had "thread local storage" on the brain.  I guess
>>>> I've spent too much of my youth using Win32 thread APIs. :-)
>>>>
>>>> Let me take a look at removing those terms.
>>>
>>> Nah, it may be just me.  As long as what TLS stands for is clear in
>>> the context, it is fine.
>>
>> No, really, my first reaction was, too: what the hack has crypto to do
>> with trace2? Are we now sending around trace output by email?
> 
> Ok, then it is not just me ;-)
>>
>> Please use "TLS" next to "CTX" only when it means "Transport Layer
>> Security".

I'll make a note to go thru and remove/change these
terms in a future series rather than mix it in with
this one.

Jeff
