Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CB0C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 23:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiCKXDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiCKXDe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:03:34 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BBBF94E0
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:59:20 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2AA153F47F8;
        Fri, 11 Mar 2022 16:01:59 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B7C3F3F4161;
        Fri, 11 Mar 2022 16:01:58 -0500 (EST)
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
 <1a060357-3296-81d5-bf23-a55263ef6d10@jeffhostetler.com>
 <xmqqk0d3kl73.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0e28579e-4ba8-eb7e-b979-f9e93b7c1e51@jeffhostetler.com>
Date:   Fri, 11 Mar 2022 16:01:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0d3kl73.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/22 1:57 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On 3/7/22 5:37 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>>>
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>> [...]
>> [...]
>>
>> Ævar sent feedback (thanks!) on 8 commits in the V6 version
>> on March 7.  I started responding to each as I got to them
>> in my inbox yesterday, but I'd like to take a break from
>> responding individually to each of them inside of Part 2.
>>
>> Since most of the feedback is for "general cleanup" and since
>> Part 2 V6 is already in "next", I'd like to revisit these
>> issues with a few "cleanup" commits on top of Part 3 (which
>> is still in active review), rather than re-rolling or
>> appending "fixup" commits onto Part 2.
> 
> Sounds good.  Prepending "preliminary clean-up" before part 3 would
> be even cleaner, I would suspect.
> 
> In any case, let's consider part 2 "more or less done" unless we see
> a glaring mistake that requires us to revert and redo it from
> scratch.
> 
> Thanks.
> 

The cleanup here turned into 16 small commits.  I'll send them as
a "Part 2.5" so that they stand alone and can either be appended
to part 2 or treated as a new branch.

GGG wouldn't let me send fixup! commits, so inside of each
commit message is a "fixup! ..." line which you can use if
you want to squash them into part 2.  But otherwise they
have a normal (non-fixup) commit summary.

After I send that I'll send a new version of part 3 that builds
upon them.

Thanks
Jeff
