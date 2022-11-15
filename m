Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7EC4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiKOQO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKOQO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:14:56 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E8E10BF
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:14:55 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C3A38CA1269;
        Tue, 15 Nov 2022 11:14:54 -0500 (EST)
Received: from [10.0.0.2] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8A6A9CC8324;
        Tue, 15 Nov 2022 11:14:54 -0500 (EST)
Message-ID: <7ca10b13-7041-c730-c92f-4cff07783746@jeffhostetler.com>
Date:   Tue, 15 Nov 2022 11:14:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] fsmonitor--daemon: on macOS support symlink
To:     Taylor Blau <me@ttaylorr.com>,
        srz_zumix via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, srz_zumix <zumix.cpp@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1406.git.1667885119570.gitgitgadget@gmail.com>
 <Y2rLr5zJTnqownCT@nand.local>
Content-Language: en-US
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <Y2rLr5zJTnqownCT@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/8/22 4:35 PM, Taylor Blau wrote:
> On Tue, Nov 08, 2022 at 05:25:19AM +0000, srz_zumix via GitGitGadget wrote:
>> From: srz_zumix <zumix.cpp@gmail.com>
>>
>> Resolves a problem where symbolic links were not showing up in diff when
>> created or modified.
> 
> Looks reasonable to me. Adding Jeff Hostetler (cc'd) as a possible
> reviewer.
> 
> Thanks,
> Taylor

This looks good to me too.  Thanks!
