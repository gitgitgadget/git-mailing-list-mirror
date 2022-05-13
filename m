Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55661C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 19:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiEMTnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 15:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiEMTnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 15:43:20 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC84227CF1
        for <git@vger.kernel.org>; Fri, 13 May 2022 12:43:18 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 18DE43F4813;
        Fri, 13 May 2022 15:43:18 -0400 (EDT)
Received: from REPLICASERVER01.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EFC953F4807;
        Fri, 13 May 2022 15:43:17 -0400 (EDT)
Subject: Re: What's cooking in git.git (May 2022, #04; Thu, 12)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilqacmmd.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <455b0ce0-0e28-d3fd-c47c-38ae32d84987@jeffhostetler.com>
Date:   Fri, 13 May 2022 15:43:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqilqacmmd.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/22 8:16 PM, Junio C Hamano wrote:
> 
> * jh/builtin-fsmonitor-part3 (2022-04-22) 29 commits
>   - fsmonitor--daemon: allow --super-prefix argument
>   - t7527: test Unicode NFC/NFD handling on MacOS
>   - t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
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
>   Expecting a hopefully final reroll.
>   cf. <nycvar.QRO.7.76.6.2205121726260.352@tvgsbejvaqbjf.bet>
>   source: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>

Yes, Johannes had some comments on my V6 on Thursday.
I'll address them and send a (hopefully final) V7 early
next week.

Thanks for your patience.
Jeff

