Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F480C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351053AbiCOSjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiCOSjg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 14:39:36 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13212126F
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 11:38:23 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 56D203F4148;
        Tue, 15 Mar 2022 14:38:23 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1003:b8de:e273:b0e7:6a1e:4c01:1162])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 18E763F413F;
        Tue, 15 Mar 2022 14:38:22 -0400 (EDT)
Subject: Re: What's cooking in git.git (Mar 2022, #03; Mon, 14)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5yogp6xo.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c4162c3e-a04c-6c8d-6b84-a32333ce5c9f@jeffhostetler.com>
Date:   Tue, 15 Mar 2022 14:38:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5yogp6xo.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 
> 
> * jh/builtin-fsmonitor-part2 (2022-03-01) 30 commits
>    (merged to 'next' on 2022-03-08 at 5f9d385483)
>   + update-index: convert fsmonitor warnings to advise
>   + t7527: test status with untracked-cache and fsmonitor--daemon
>   + fsmonitor: force update index after large responses
>   + fsmonitor--daemon: use a cookie file to sync with file system
>   + fsmonitor--daemon: periodically truncate list of modified files
>   + t/perf/p7519: add fsmonitor--daemon test cases
>   + t/perf/p7519: speed up test on Windows
>   + t/helper/test-chmtime: skip directories on Windows
>   + t/perf: avoid copying builtin fsmonitor files into test repo
>   + t7527: create test for fsmonitor--daemon
>   + t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>   + help: include fsmonitor--daemon feature flag in version info
>   + fsmonitor--daemon: implement handle_client callback
>   + compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
>   + compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
>   + compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
>   + fsmonitor--daemon: create token-based changed path cache
>   + fsmonitor--daemon: define token-ids
>   + fsmonitor--daemon: add pathname classification
>   + fsmonitor--daemon: implement 'start' command
>   + fsmonitor--daemon: implement 'run' command
>   + compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
>   + compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
>   + fsmonitor--daemon: implement 'stop' and 'status' commands
>   + fsmonitor--daemon: add a built-in fsmonitor daemon
>   + fsmonitor: document builtin fsmonitor
>   + fsmonitor: use IPC to query the builtin FSMonitor daemon
>   + fsmonitor: config settings are repository-specific
>   + fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   + fsmonitor: enhance existing comments, clarify trivial response handling
>   (this branch is used by jh/builtin-fsmonitor-part-2plus and jh/builtin-fsmonitor-part3.)
> 
>   Built-in fsmonitor (part 2).
> 
>   Will merge to 'master'.
>   source: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
> 

One of your notes on part 2.5 asked if it would be better
to pull part 2 back to "seen" and let me squash in part 2.5
(and attend to any new comments on 2.5 itself).

I'm happy to do that if you haven't merged part 2 yet.
Just let me know what your preference is.

Thanks
Jeff
