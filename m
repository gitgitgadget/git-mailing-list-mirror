Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6335BC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195F5613C4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 14:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhDTO3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 10:29:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:22598 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhDTO3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 10:29:12 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 080883F40D9;
        Tue, 20 Apr 2021 10:28:41 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DF2363F4096;
        Tue, 20 Apr 2021 10:28:40 -0400 (EDT)
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtuo17t6t.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e4bae5e3-48c2-d982-ca78-7f3ed4002a37@jeffhostetler.com>
Date:   Tue, 20 Apr 2021 10:28:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuo17t6t.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/19/21 7:25 PM, Junio C Hamano wrote:
> 
> * jh/rfc-builtin-fsmonitor (2021-04-08) 23 commits
>   - t7527: test status with untracked-cache and fsmonitor--daemon
>   - p7519: add fsmonitor--daemon
>   - t7527: create test for fsmonitor--daemon
>   - fsmonitor: force update index when fsmonitor token advances
>   - fsmonitor--daemon: use a cookie file to sync with file system
>   - fsmonitor--daemon:: introduce client delay for testing
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
>   - fsmonitor--daemon: implement client command options
>   - fsmonitor--daemon: add a built-in fsmonitor daemon
>   - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
>   - config: FSMonitor is repository-specific
>   - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>   - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
> 
>   An attempt to write and ship with a watchman equivalent tailored
>   for our use.
> 
>   Will discard.
>   ... as nobody seems to be interested.

I'd like to ask that we give this a little more time.

Is there something I could do to make it easier to review
or more interesting to the community?

I hesitant to spam the list with a non-RFC/V2 until
this one has seen at least a little high-level review.

Thanks
Jeff


