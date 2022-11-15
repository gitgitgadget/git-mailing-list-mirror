Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB6EC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiKOQi4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiKOQiz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:38:55 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8F027143
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:38:54 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 285A6CA1254;
        Tue, 15 Nov 2022 11:38:54 -0500 (EST)
Received: from [10.0.0.2] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EBF8DCC833D;
        Tue, 15 Nov 2022 11:38:53 -0500 (EST)
Message-ID: <4cba2921-1497-ccc0-adfa-742d5ce75e3a@jeffhostetler.com>
Date:   Tue, 15 Nov 2022 11:38:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3] status: long status advice adapted to recent
 capabilities
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Rudy Rigot <rudy.rigot@gmail.com>
References: <pull.1384.v2.git.1667002005494.gitgitgadget@gmail.com>
 <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
 <Y2WG6ursW7qT29lc@nand.local>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <Y2WG6ursW7qT29lc@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/4/22 5:40 PM, Taylor Blau wrote:
> On Wed, Nov 02, 2022 at 09:27:47PM +0000, Rudy Rigot via GitGitGadget wrote:
>> From: Rudy Rigot <rudy.rigot@gmail.com>
>>
>> Improve the advice displayed when `git status` is slow because
>> of excessive numbers of untracked files.  Update the `git status`
>> man page to explain the various configuration options.
> 
> This one is looking good to me. Jeff: do you agree? If so, I'm ready to
> start merging this one down.
> 
> Thanks,
> Taylor

This series is looking good to me too.  I think V5 has addressed
all of the concerns.

Jeff
