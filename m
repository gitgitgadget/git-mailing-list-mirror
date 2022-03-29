Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C53BC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbiC2N7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236775AbiC2N7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:59:53 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76114232D24
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:58:09 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A776D3F4148;
        Tue, 29 Mar 2022 09:58:08 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 89CA43F4147;
        Tue, 29 Mar 2022 09:58:08 -0400 (EDT)
Subject: Re: What's cooking in git.git (Mar 2022, #06; Mon, 28)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqo81pxzt4.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <66518eaa-efc8-b6ad-d919-abcf76ab46d9@jeffhostetler.com>
Date:   Tue, 29 Mar 2022 09:58:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqo81pxzt4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/28/22 10:22 PM, Junio C Hamano wrote:
[...]
> 
> * jh/builtin-fsmonitor-part2 (2022-03-25) 30 commits
>   - t7527: test status with untracked-cache and fsmonitor--daemon
>   - fsmonitor: force update index after large responses
>   - fsmonitor--daemon: use a cookie file to sync with file system
>   - fsmonitor--daemon: periodically truncate list of modified files
>   - t/perf/p7519: add fsmonitor--daemon test cases
>   - t/perf/p7519: speed up test on Windows
>   - t/perf/p7519: fix coding style
>   - t/helper/test-chmtime: skip directories on Windows
>   - t/perf: avoid copying builtin fsmonitor files into test repo
>   - t7527: create test for fsmonitor--daemon
>   - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   - help: include fsmonitor--daemon feature flag in version info
>   - fsmonitor--daemon: implement handle_client callback
>   - compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
>   - compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
>   - compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
>   - fsmonitor--daemon: create token-based changed path cache
>   - fsmonitor--daemon: define token-ids
>   - fsmonitor--daemon: add pathname classification
>   - fsmonitor--daemon: implement 'start' command
>   - fsmonitor--daemon: implement 'run' command
>   - compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
>   - compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
>   - fsmonitor--daemon: implement 'stop' and 'status' commands
>   - fsmonitor--daemon: add a built-in fsmonitor daemon
>   - fsmonitor: document builtin fsmonitor
>   - fsmonitor: use IPC to query the builtin FSMonitor daemon
>   - fsmonitor: config settings are repository-specific
>   - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   - fsmonitor: enhance existing comments, clarify trivial response handling
>   (this branch is used by jh/builtin-fsmonitor-part3.)
> 
>   Built-in fsmonitor (part 2).
> 
>   Will merge to 'next'?
>   source: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
> 

I think we're good to go.  Part 2 now includes all of the
fixups that we discussed over the last few weeks and I haven't
seen any further feedback.

Thanks,
Jeff
