Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC7C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKOQjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKOQjt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:39:49 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2227143
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:39:48 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CE572CA1254;
        Tue, 15 Nov 2022 11:39:47 -0500 (EST)
Received: from [10.0.0.2] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 869EECC833A;
        Tue, 15 Nov 2022 11:39:47 -0500 (EST)
Message-ID: <454089ac-3d0d-9820-26a4-e5650c2604d2@jeffhostetler.com>
Date:   Tue, 15 Nov 2022 11:39:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v5] status: long status advice adapted to recent
 capabilities
Content-Language: en-US
To:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Rudy Rigot <rudy.rigot@gmail.com>
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
 <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/10/22 3:04 PM, Rudy Rigot via GitGitGadget wrote:
> From: Rudy Rigot <rudy.rigot@gmail.com>
> 
> Improve the advice displayed when `git status` is slow because
> of excessive numbers of untracked files.  Update the `git status`
> man page to explain the various configuration options.
> 
> `git status` can be slow when there are a large number of untracked
> files and directories, because Git must search the entire worktree
> to enumerate them.  Previously, Git would print an advice message
> with the elapsed search time and a suggestion to disable the search
> using the `-uno` option.  This suggestion also carried a warning
> that might scare off some users.
> 
> Git can reduce the size and time of the untracked file search when
> the `core.untrackedCache` and `core.fsmonitor` features are enabled
> by caching results from previous `git status` invocations.
> 
> Update the advice to explain the various combinations of additional
> configuration options and refer to (new) documentation in the man
> page that explains it in more detail than what can be printed in an
> advice message.
> 
> Finally, add new tests to verify the new functionality.
> 
> Signed-off-by: Rudy Rigot <rudy.rigot@gmail.com>

I think V5 looks good.
Thanks for your persistence!

Jeff

