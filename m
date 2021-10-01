Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608BC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AE961A56
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354704AbhJAO6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:58:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:27002 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhJAO6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:58:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C2C523F4096;
        Fri,  1 Oct 2021 10:56:35 -0400 (EDT)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AB3483F4095;
        Fri,  1 Oct 2021 10:56:35 -0400 (EDT)
Subject: Re: What's cooking in git.git (Sep 2021, #09; Thu, 30)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7e18soj.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <31c4b5fe-a233-2453-f7aa-12a7b670c204@jeffhostetler.com>
Date:   Fri, 1 Oct 2021 10:56:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7e18soj.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/30/21 9:01 PM, Junio C Hamano wrote:
> 
> * jh/builtin-fsmonitor-part1 (2021-09-20) 7 commits
>   - t/helper/simple-ipc: convert test-simple-ipc to use start_bg_command
>   - run-command: create start_bg_command
>   - simple-ipc/ipc-win32: add Windows ACL to named pipe
>   - simple-ipc/ipc-win32: add trace2 debugging
>   - simple-ipc: move definition of ipc_active_state outside of ifdef
>   - simple-ipc: preparations for supporting binary messages.
>   - trace2: add trace2_child_ready() to report on background children
> 
>   Built-in fsmonitor (part 1).
> 

I think part 1 has settled down if there are no further comments.

I'm going to need to re-roll my part 2 [1] because of conflicts with
"ab/repo-settings-cleanup (2021-09-22) 5 commits" in repo-settings.c

Jeff

[1] 
https://lore.kernel.org/all/pull.1041.git.1631822063.gitgitgadget@gmail.com/

