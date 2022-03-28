Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E33C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 15:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiC1PSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 11:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiC1PSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 11:18:47 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903F606F8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 08:17:06 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8E5C53F4128;
        Mon, 28 Mar 2022 11:17:05 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 066243F413E;
        Mon, 28 Mar 2022 11:17:04 -0400 (EDT)
Subject: Re: [PATCH v9 00/30] Builtin FSMonitor Part 2
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
 <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
 <xmqqpmm98w9u.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b89dcf8e-d16e-c604-0bf0-3a11d1528d59@jeffhostetler.com>
Date:   Mon, 28 Mar 2022 11:17:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmm98w9u.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/25/22 7:09 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Here is V9 of Part 2 of my builtin FSMonitor series. This version addresses
>> bash style issues in t7527 raised on V8. These changes do not require a new
>> version of Part 3.
> 
> This addresses all the "oops" fix-ups from part 2.5, and good base
> to build part 3 on top, right?
> 
> Queued.
> 
> Thanks.
> 

Yes, this version of part 2 includes all of the fixups from 2.5.
And 2.5 should be dropped.
And yes, this part 2 should be the basis for part 3.

Thanks again!
Jeff
