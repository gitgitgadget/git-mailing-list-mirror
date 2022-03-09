Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C049C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiCINip (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiCINin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:38:43 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550922716
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:37:44 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 561193F4161;
        Wed,  9 Mar 2022 08:37:43 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CE9383F413E;
        Wed,  9 Mar 2022 08:37:42 -0500 (EST)
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1a060357-3296-81d5-bf23-a55263ef6d10@jeffhostetler.com>
Date:   Wed, 9 Mar 2022 08:37:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/7/22 5:37 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
[...]

Ævar sent feedback (thanks!) on 8 commits in the V6 version
on March 7.  I started responding to each as I got to them
in my inbox yesterday, but I'd like to take a break from
responding individually to each of them inside of Part 2.

Since most of the feedback is for "general cleanup" and since
Part 2 V6 is already in "next", I'd like to revisit these
issues with a few "cleanup" commits on top of Part 3 (which
is still in active review), rather than re-rolling or
appending "fixup" commits onto Part 2.

I think this would be quicker and easier in the long run
and give us the same net result.

Thanks,
Jeff

