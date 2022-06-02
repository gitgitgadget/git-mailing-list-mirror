Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12037C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiFBOHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiFBOHo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 10:07:44 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC28124791C
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 07:07:42 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DD2B63F47FA;
        Thu,  2 Jun 2022 10:07:41 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BD43C3F47F9;
        Thu,  2 Jun 2022 10:07:41 -0400 (EDT)
Subject: Re: What's cooking in git.git (Jun 2022, #01; Wed, 1)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqee07q3xc.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ac0bff3c-6998-70c0-87b3-93edfdebf50d@jeffhostetler.com>
Date:   Thu, 2 Jun 2022 10:07:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqee07q3xc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/1/22 8:55 PM, Junio C Hamano wrote:
...
> 
> * jh/builtin-fsmonitor-part3 (2022-05-26) 31 commits
>   - t7527: improve implicit shutdown testing in fsmonitor--daemon
>   - fsmonitor--daemon: allow --super-prefix argument
>   - t7527: test Unicode NFC/NFD handling on MacOS
>   - t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
>   - t/helper/hexdump: add helper to print hexdump of stdin
>   - fsmonitor: on macOS also emit NFC spelling for NFD pathname
>   - t7527: test FSMonitor on case insensitive+preserving file system
>   - fsmonitor: never set CE_FSMONITOR_VALID on submodules
>   - t/perf/p7527: add perf test for builtin FSMonitor
>   - t7527: FSMonitor tests for directory moves
>   - fsmonitor: optimize processing of directory events
>   - fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
>   - fsm-health-win32: force shutdown daemon if worktree root moves
>   - fsm-health-win32: add polling framework to monitor daemon health
>   - fsmonitor--daemon: stub in health thread
>   - fsmonitor--daemon: rename listener thread related variables
>   - fsmonitor--daemon: prepare for adding health thread
>   - fsmonitor--daemon: cd out of worktree root
>   - fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
>   - unpack-trees: initialize fsmonitor_has_run_once in o->result
>   - fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
>   - fsmonitor-settings: remote repos on Windows are incompatible
>   - fsmonitor-settings: remote repos on macOS are incompatible
>   - fsmonitor-settings: stub in macOS-specific incompatibility checking
>   - fsmonitor-settings: VFS for Git virtual repos are incompatible
>   - fsmonitor-settings: stub in Win32-specific incompatibility checking
>   - fsmonitor-settings: bare repos are incompatible with FSMonitor
>   - t/helper/fsmonitor-client: create stress test
>   - t7527: test FSMonitor on repos with Unicode root paths
>   - fsm-listen-win32: handle shortnames
>   - Merge branch 'jh/builtin-fsmonitor-part2' into jh/builtin-fsmonitor-part3
> 
>   More fsmonitor--daemon.
> 
>   Will merge to 'next'?
>   source: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
> 

I've addressed all of the feedback on V7 and V8. And V9 fixed a typo.
So I think it is ready to move forward.

Thanks for your patience in all of this.
Jeff


