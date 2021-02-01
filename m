Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67A4C4332B
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB064E2E
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBAX1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:27:43 -0500
Received: from siwi.pair.com ([209.68.5.199]:36731 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231258AbhBAX1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:27:36 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 388E23F410A;
        Mon,  1 Feb 2021 18:26:51 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F048D3F40FA;
        Mon,  1 Feb 2021 18:26:50 -0500 (EST)
Subject: Re: [PATCH v2 00/14] Simple IPC Mechanism
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <xmqq5z3bjuqs.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1be67634-4188-9ef3-306c-72b78ea856b5@jeffhostetler.com>
Date:   Mon, 1 Feb 2021 18:26:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z3bjuqs.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/1/21 5:20 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Here is version 2 of my "Simple IPC" series and addresses the following
>> review comments:
>> ...
>> Junio C Hamano (1):
>>    ci/install-depends: attempt to fix "brew cask" stuff
> 
> Huh?
> 

Sorry.  I had to prepend that one to the patch series to get the
CI builds to run.  I've been working rebased against "v2.30.0" and
GitGitGadget references "master".

Jeff
