Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0882C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 14:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJTOmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJTOmO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 10:42:14 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6DF28716
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 07:42:13 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4FADDCA123B;
        Thu, 20 Oct 2022 10:42:13 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 05620CC8319;
        Thu, 20 Oct 2022 10:42:12 -0400 (EDT)
Subject: Re: [PATCH v2 6/7] trace2: add stopwatch timers
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
 <dd6d8e2841b424ba89672b4d94306f9ec882a868.1665600750.git.gitgitgadget@gmail.com>
 <xmqq8rlje8cu.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <aeb07c4f-f3f2-4965-6b6b-3ba3b10b2103@jeffhostetler.com>
Date:   Thu, 20 Oct 2022 10:42:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rlje8cu.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/13/22 5:12 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Add stopwatch timer mechanism to Trace2.
[...]
> It was irritating to count zeros in the same constant 1000000000.0
> spelled out 9 times.  Perhaps something like
> 
> #define NS_TO_SECONDS(ns) ((double)(ns) / (1000*1000*1000.))
> 
> would have helped?

good point.  i'll resend.

thanks
jeff
