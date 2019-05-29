Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19BD1F462
	for <e@80x24.org>; Wed, 29 May 2019 19:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2Two (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 15:52:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:45223 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfE2Twn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 15:52:43 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BD3D03F413E;
        Wed, 29 May 2019 15:52:42 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:c90f:aaf8:aafe:c1ce] (unknown [IPv6:2001:4898:a800:1010:7a45:aaf8:aafe:c1ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 680213F4127;
        Wed, 29 May 2019 15:52:42 -0400 (EDT)
Subject: Re: [PATCH 1/2] trace2: rename environment variables to GIT_TRACE2*
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <20190510211502.GS14763@szeder.dev>
 <20190519144309.9597-1-szeder.dev@gmail.com>
 <xmqq36ky5ywr.fsf@gitster-ct.c.googlers.com>
 <f03e2ba6-36d8-d82b-3349-61341365b94e@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8077e893-ebaf-9a23-2bf0-ba0ab78e7bae@jeffhostetler.com>
Date:   Wed, 29 May 2019 15:52:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f03e2ba6-36d8-d82b-3349-61341365b94e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/28/2019 12:46 PM, Derrick Stolee wrote:
> On 5/28/2019 12:25 PM, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>
>>> For an environment variable that is supposed to be set by users, the
>>> GIT_TR2* env vars are just too unclear, inconsistent, and ugly.
>>
>> FWIW, I personally am in favor of this change and would prefer to see
>> this done before the use of the names with unguessable abbreviation
>> gets ingrained too deeply.
>>
>> I do not see any objections around these two patches after waiting
>> for a week or so, but I do not see any Yay!s, either, so ...
> 
> Talking with Jeff offline, we have no objections to the new names.
> 
> We'll need to do some follow-up work on our side as we update our
> version of Git, but that's not an issue.
> 
> Thanks,
> -Stolee
> 


Just to close the loop.  Yes, I'm OK with changing the names.

Jeff
