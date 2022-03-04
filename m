Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A0C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiCDXsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCDXsg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:48:36 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C122B29
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:47:47 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 544913F47F8;
        Fri,  4 Mar 2022 18:47:47 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 207A23F4147;
        Fri,  4 Mar 2022 18:47:47 -0500 (EST)
Subject: Re: [PATCH 02/23] t7527: test FS event reporing on macOS WRT case and
 Unicode
To:     Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <ad8cf6d9a47b61d9fe41a961466122be16e4f041.1644940773.git.gitgitgadget@gmail.com>
 <c7ee2394-cda0-a997-3b9d-fb8c3d65b312@github.com>
 <20220224173305.gbr2waw77xpuieub@tb-raspi4>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <2bbc2802-8ab8-74ec-3fca-a933100752f3@jeffhostetler.com>
Date:   Fri, 4 Mar 2022 18:47:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220224173305.gbr2waw77xpuieub@tb-raspi4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 12:33 PM, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
> On Thu, Feb 24, 2022 at 09:52:28AM -0500, Derrick Stolee wrote:
>> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Confirm that macOS FS events are reported with a normalized spelling.
>>>
>>> APFS (and/or HFS+) is case-insensitive.  This means that case-independent
> 
[...]
> 
> An interesting article can be found here:
> https://lwn.net/Articles/784041/
> 
> And to be technically correct, I think that even NTFS can be
> "configured to be case insensitive in an empty directory".

Yes, it is now possible to have NTFS be case sensitive (on a
directory by directory basis).  I haven't had a chance to
experiment with this yet, but I'm hoping that if we can always
have the daemon report using the on-disk spelling, we can
avoid most of this insanity.

Thanks,
Jeff
