Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE6C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA0613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhFRQet (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:34:49 -0400
Received: from siwi.pair.com ([209.68.5.199]:58332 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235921AbhFRQes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 12:34:48 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 392613F40F1;
        Fri, 18 Jun 2021 12:32:38 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 227CB3F40DA;
        Fri, 18 Jun 2021 12:32:38 -0400 (EDT)
Subject: Re: What's cooking in git.git (Jun 2021, #06; Thu, 17)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr1h1mc81.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5489d9e9-93f4-d0f3-b4fd-a3d804a68ba5@jeffhostetler.com>
Date:   Fri, 18 Jun 2021 12:32:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/16/21 10:55 PM, Junio C Hamano wrote:
...
> 
> * jh/builtin-fsmonitor (2021-05-24) 30 commits
>   - t/perf: avoid copying builtin fsmonitor files into test repo
>   - t7527: test status with untracked-cache and fsmonitor--daemon
>   - p7519: add fsmonitor--daemon
>   - t7527: create test for fsmonitor--daemon
>   - fsmonitor: force update index after large responses
>   - fsmonitor: enhance existing comments
>   - fsmonitor--daemon: use a cookie file to sync with file system
>   - fsmonitor--daemon: periodically truncate list of modified files
>   - fsmonitor--daemon: implement handle_client callback
>   - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>   - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>   - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>   - fsmonitor--daemon: create token-based changed path cache
>   - fsmonitor--daemon: define token-ids
>   - fsmonitor--daemon: add pathname classification
>   - fsmonitor--daemon: implement daemon command options
>   - fsmonitor-fs-listen-macos: stub in backend for MacOS
>   - fsmonitor-fs-listen-win32: stub in backend for Windows
>   - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   - fsmonitor--daemon: implement client command options
>   - fsmonitor--daemon: add a built-in fsmonitor daemon
>   - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
>   - config: FSMonitor is repository-specific
>   - help: include fsmonitor--daemon feature flag in version info
>   - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   - fsmonitor--daemon: update fsmonitor documentation
>   - fsmonitor--daemon: man page
>   - simple-ipc: preparations for supporting binary messages.
>   - Merge branch 'jk/perf-in-worktrees' into HEAD
>   - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
> 
>   An attempt to write and ship with a watchman equivalent tailored
>   for our use.
> 
>   What's the status of this one?
> 

I went on vacation shortly after I send V2.  I'm back now, but still
catching up on my various inboxes.

I'll send a V3 after I get caught up.

Thanks,
Jeff

