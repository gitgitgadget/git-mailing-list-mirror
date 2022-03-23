Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B18DC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbiCWUQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiCWUQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:16:25 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DBE8A31B
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:14:54 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 10D113F4155;
        Wed, 23 Mar 2022 16:14:54 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EEF8A3F414B;
        Wed, 23 Mar 2022 16:14:53 -0400 (EDT)
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqv8wcizi4.fsf@gitster.g>
 <eb10fee5-d6ea-b660-e339-d55a4b669c3c@jeffhostetler.com>
 <xmqqk0cksev5.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <eb503dec-4a30-dd29-ac65-a8924fa178d6@jeffhostetler.com>
Date:   Wed, 23 Mar 2022 16:14:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0cksev5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/23/22 2:28 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On 3/17/22 7:34 AM, Junio C Hamano wrote:
>>> * jh/builtin-fsmonitor-part-2plus (2022-03-13) 16 commits
>>>    - fsmonitor-settings: simplify initialization of settings data
>>>    - fsmonitor--daemon: add _() to calls to error()
>>>    - fsmonitor--daemon: add _() to calls to die()
>>>    - compat/fsmonitor/fsm-listen-win32: add _() to calls to error()
>>>    - compat/fsmonitor/fsm-listen-darwin: add _() to calls to error()
>>>    - fsmonitor-ipc: add _() to calls to die()
>>>    - t7527: delete unused verify_status() function
>>>    - t7527: fix && chaining in matrix_try()
>>>    - t7527: add parameters to start_daemon to handle args and subshell
>>>    - t/perf/p7519: cleanup coding style
>>>    - t/perf/p7519: use grep rather than egrep in test
>>>    - fsmonitor--daemon: refactor cookie handling for readability
>>>    - t/helper/fsmonitor-client: cleanup call to parse_options()
>>>    - compat/fsmonitor/fsm-listen-darwin: split out GCC-specific declarations
>>>    - update-index: convert advise() messages back to warning()
>>>    - t/test-lib: avoid using git on LHS of pipe
>>>    (this branch uses jh/builtin-fsmonitor-part2.)
>>>    Various small fixes and cleanups on part-2 of the same topic.
>>>    Needs review.
>>>    source: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
>>
>> I have squashed this into part 2 V7, so this series can be
>> discarded.  Thanks (and sorry for the mess).
> 
> Will take a (hopefully final) look, and ...
> 
> 
>>> * jh/builtin-fsmonitor-part3 (2022-03-09) 28 commits
>>> ...
>>>    . Merge branch 'jh/builtin-fsmonitor-part2' into jh/builtin-fsmonitor-part3
>>>    (this branch uses jh/builtin-fsmonitor-part2.)
>>>    More fsmonitor--daemon.
>>>    source: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
>>
>> I just sent a V3 of part 3 that builds upon V7 of part 2.
>> The fixups from part 2.5 have been squashed in.
> 
> ... queue the updated one on top.
> 
> Thanks.
> 


I have a V8 of Part 2 that addresses AEvar's last round of comments
from yesterday (mostly related to the test suite).  It's building
now on GGG.  If there are no other comments by the morning, I'll send
it (and an updated Part 3 to match) tomorrow and hopefully Part 2 can
be done.

Thanks
Jeff
