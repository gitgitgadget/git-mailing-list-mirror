Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F34C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 15:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbhLMPjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 10:39:42 -0500
Received: from siwi.pair.com ([209.68.5.199]:64927 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232862AbhLMPjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 10:39:41 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 615143F4107;
        Mon, 13 Dec 2021 10:39:41 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3B37F3F40F5;
        Mon, 13 Dec 2021 10:39:41 -0500 (EST)
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilvvluoa.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <538f6f16-3cef-3f42-7ebb-c2bb6e5cb734@jeffhostetler.com>
Date:   Mon, 13 Dec 2021 10:39:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/10/21 9:52 PM, Junio C Hamano wrote:
> [Cooking]
> 
> * jh/builtin-fsmonitor-part2 (2021-10-21) 29 commits
>   - t7527: test status with untracked-cache and fsmonitor--daemon
>   - fsmonitor: force update index after large responses
>   - fsmonitor--daemon: use a cookie file to sync with file system
>   - fsmonitor--daemon: periodically truncate list of modified files
>   - t/perf/p7519: add fsmonitor--daemon test cases
>   - t/perf/p7519: speed up test on Windows
>   - t/helper/test-chmtime: skip directories on Windows
>   - t/perf: avoid copying builtin fsmonitor files into test repo
>   - t7527: create test for fsmonitor--daemon
>   - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   - help: include fsmonitor--daemon feature flag in version info
>   - fsmonitor--daemon: implement handle_client callback
>   - compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
>   - compat/fsmonitor/fsm-listen-darwin: add macos header files for FSEvent
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
>   - fsmonitor: enhance existing comments
> 
>   Built-in fsmonitor (part 2).
> 
>   Expecting a reroll.
>   Seems that the discussion stalled.
>   cf. <d9c3ef61-768c-3560-2858-3438c355a742@jeffhostetler.com>
>   source: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>

Sorry, $DayJob has had me diverted to other things and
I haven't had time to get back to this.

Yes, I owe you a reroll to address your last round of comments.
And then once I push that, I can update and push part 3.

I'm currently planning to work on these topics during the
Christmas holiday weeks.

Jeff

