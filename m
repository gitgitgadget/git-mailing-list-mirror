Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E009DC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C823561212
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 16:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343900AbhIQRAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:00:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:24673 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343810AbhIQQ74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 81BD13F40F5;
        Fri, 17 Sep 2021 12:58:32 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b109:12e8:cc1c:b3d3:708a:a5be])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1C3F73F40F3;
        Fri, 17 Sep 2021 12:58:32 -0400 (EDT)
Subject: Re: [PATCH 3/7] simple-ipc: move definition of ipc_active_state
 outside of ifdef
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <7de207828caa9e50906f39b955e39e9de2c1768f.1631738177.git.gitgitgadget@gmail.com>
 <xmqq5yv1wnuc.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <93ebf97b-1282-8f39-6894-90e0ea2dc851@jeffhostetler.com>
Date:   Fri, 17 Sep 2021 12:58:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5yv1wnuc.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/15/21 5:06 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> From: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>>
>> Move the declartion of the `enum ipc_active_state` type outside of
>> the SUPPORTS_SIMPLE_IPC ifdef.
> 
> The second one is not an in-body header since there is already a
> blank line that signals the end of in-body headers after the first
> one.
> 
> This _may_ be a bug in GGG, perhaps?

Maybe.  I'll make a note to ask @dscho when he gets back from vacation.

Credit for the commit should go to Carlo.  I just added it to the series
with his "From:" line and it looks like GGG added an extra one before
it.

Jeff
