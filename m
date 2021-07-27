Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D41C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1683D61A07
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 13:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhG0NMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:12:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:46787 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236559AbhG0NMf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 09:12:35 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EF6FA3F40F5;
        Tue, 27 Jul 2021 09:12:34 -0400 (EDT)
Received: from SME-RED-HCI8.sme.test.net (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D39D33F40F4;
        Tue, 27 Jul 2021 09:12:34 -0400 (EDT)
Subject: Re: What's cooking in git.git (Jul 2021, #06; Mon, 26)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq35s0fj9o.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cf16ce28-5d2a-98b3-800a-6d4880566b92@jeffhostetler.com>
Date:   Tue, 27 Jul 2021 09:12:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq35s0fj9o.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/27/21 12:55 AM, Junio C Hamano wrote:
> 
> * jh/builtin-fsmonitor (2021-07-12) 35 commits
>   - BANDAID: sparse fixes
>   - t7527: test FS event reporing on MacOS WRT case and Unicode
>   - fsmonitor: handle shortname for .git
>   - t7527: test status with untracked-cache and fsmonitor--daemon
>   - fsmonitor: force update index after large responses
>   - fsmonitor: enhance existing comments
>   - fsmonitor--daemon: use a cookie file to sync with file system
>   - fsmonitor--daemon: periodically truncate list of modified files
>   - t7527: create test for fsmonitor--daemon
>   - t/perf/p7519: add fsmonitor--daemon test cases
>   - t/perf: avoid copying builtin fsmonitor files into test repo
>   - t/perf/p7519: speed up test using "test-tool touch"
>   - t/helper/test-touch: add helper to touch a series of files
>   - fsmonitor--daemon: implement handle_client callback
>   - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>   - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>   - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>   - fsmonitor--daemon: create token-based changed path cache
>   - fsmonitor--daemon: define token-ids
>   - fsmonitor--daemon: add pathname classification
>   - fsmonitor: do not try to operate on bare repos
>   - fsmonitor--daemon: implement 'start' command
>   - fsmonitor--daemon: implement 'run' command
>   - fsmonitor-fs-listen-macos: stub in backend for MacOS
>   - fsmonitor-fs-listen-win32: stub in backend for Windows
>   - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   - fsmonitor--daemon: implement 'stop' and 'status' commands
>   - fsmonitor--daemon: add a built-in fsmonitor daemon
>   - fsmonitor: use IPC to query the builtin FSMonitor daemon
>   - fsmonitor: config settings are repository-specific
>   - help: include fsmonitor--daemon feature flag in version info
>   - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   - fsmonitor--daemon: update fsmonitor documentation
>   - fsmonitor--daemon: man page
>   - simple-ipc: preparations for supporting binary messages.
> 
>   An attempt to write and ship with a watchman equivalent tailored
>   for our use.
> 
>   So, where are we with this topic?
> 

I'm working on a V4 currently.  It will try to address most of the V3
concerns raised on list as well as feedback and error reports from the
beta testers of the experimental version in our downstream forks.

At this point in the cycle leading up to v2.33, it would be fine to
drop V3 from your nightly builds and avoid all of the distractions
as you prepare for the release.

I'll hold V4 until after the release.

Thanks
Jeff

