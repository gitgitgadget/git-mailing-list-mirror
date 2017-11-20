Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4FB9202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 15:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbdKTP4N (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 10:56:13 -0500
Received: from siwi.pair.com ([209.68.5.199]:34860 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbdKTP4M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 10:56:12 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BA8EF844E6;
        Mon, 20 Nov 2017 10:56:11 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6C097844E2;
        Mon, 20 Nov 2017 10:56:11 -0500 (EST)
Subject: Re: [PATCH v4 07/10] introduce fetch-object: fetch one promisor
 object
To:     Stefan Beller <sbeller@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20171116181257.61673-1-git@jeffhostetler.com>
 <20171116181257.61673-8-git@jeffhostetler.com>
 <e7b5e42f-b13c-50c8-501c-0100d8c48d00@ramsayjones.plus.com>
 <798096fe-dd01-5351-94d3-949039c84e69@jeffhostetler.com>
 <CAGZ79kZCdxN8h-mJRY9fQy5W3HtqcvFoL1W5jVcb3=A3vvk_Ww@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <85b615eb-d152-ed7e-779c-8fc3e46d60e1@jeffhostetler.com>
Date:   Mon, 20 Nov 2017 10:56:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZCdxN8h-mJRY9fQy5W3HtqcvFoL1W5jVcb3=A3vvk_Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/17/2017 3:17 PM, Stefan Beller wrote:
> On Fri, Nov 17, 2017 at 11:49 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>>
>> On 11/16/2017 2:57 PM, Ramsay Jones wrote:
>>>
>>>
>>>
>>> On 16/11/17 18:12, Jeff Hostetler wrote:
>>>>
>>>> From: Jonathan Tan <jonathantanmy@google.com>
>>>>
>>>> Introduce fetch-object, providing the ability to fetch one object from a
>>>> promisor remote.
>>
>> [snip]
>>>>
>>>> +#include "transport.h"
>>>
>>>
>>> I note that this still does not #include "fetch_object.h".
>>> [If you recall, this suppresses a sparse warning].
>>>
>>
>> Sorry, I missed that.  I know I did a DEVELOPER=1 build and
>> I didn't see a warning, but I'll check again.
> 
> sparse is an extra tool, which you have to run/install;
> it is not included in the developer build.
> 
> https://en.wikipedia.org/wiki/Sparse
> 

ah, thanks!
Jeff
