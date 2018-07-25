Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFAF1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 12:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeGYOD2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 10:03:28 -0400
Received: from siwi.pair.com ([209.68.5.199]:25507 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbeGYOD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 10:03:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B28D23F4042;
        Wed, 25 Jul 2018 08:51:54 -0400 (EDT)
Received: from [192.168.1.6] (43.sub-174-231-167.myvzw.com [174.231.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 149B13F4024;
        Wed, 25 Jul 2018 08:51:53 -0400 (EDT)
Subject: Re: [PATCH v1] config.c: fix msvc compile error
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180724153010.6693-1-git@jeffhostetler.com>
 <20180724195637.GA97109@syl.attlocal.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ca10e6f5-91be-e2a9-19a8-37b67217d134@jeffhostetler.com>
Date:   Wed, 25 Jul 2018 08:51:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180724195637.GA97109@syl.attlocal.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/24/2018 3:56 PM, Taylor Blau wrote:
> On Tue, Jul 24, 2018 at 03:30:10PM +0000, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> In commit fb0dc3bac135e9f6243bd6d293e8c9293c73b9cd code was added
>> to builtin/config.c to define a new function and a forward declaration
>> for an array of unknown size.  This causes a compile error under MSVC.
> 
> Thanks for spending time fixing that. fb0dc3bac1 (builtin/config.c:
> support `--type=<type>` as preferred alias for `--<type>`, 2018-04-18)
> is from me, so I owe you an extra thanks for patching up mistakes :-).
> 
> As others have noted in this thread, another patch was sent into similar
> effect, which has already been queued, and I agree that we should prefer
> that, since it's further along.
> 
> 
> Thanks,
> Taylor
> 

Yes, the other version is further along.  Let's take it.
Jeff
