Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE983C43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 15:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiFKPi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiFKPiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 11:38:24 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB160D90
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 08:38:23 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1o03Bs-000CFf-Cp;
        Sat, 11 Jun 2022 16:38:21 +0100
Message-ID: <3800fa9c-50b4-2967-2f00-036c1edf5e52@iee.email>
Date:   Sat, 11 Jun 2022 16:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] rebase: note `preserve` merges may be a pull
 config option
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
 <fe000f062078e544361c87c319830cd36aabbc91.1654341469.git.gitgitgadget@gmail.com>
 <xmqq1qw18yk2.fsf@gitster.g> <4cac8a13-a075-544e-8c10-e58bbf0dd73d@iee.email>
In-Reply-To: <4cac8a13-a075-544e-8c10-e58bbf0dd73d@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

small clarification,

On 11/06/2022 15:03, Philip Oakley wrote:
>> When pull.rebase is parsed, rebase.c::rebase_parse_value() is called
>> from builtin/pull.c::parse_config_rebase() and would trigger an
>> error, whether it comes from the pull.rebase or the branch.*.rebase
>> configuration variable.  An error() message already said that
>> 'preserve' was removed and 'merges' would be a replacement when it
>> happened.
>>
>> If the user has *not* reached this die() due to a configuration
>> variable, then there is not much point giving this new message,
>> either.
> From my perspective, users should then

That is, when users hit any of the `preserve-merges` error message, ... 
>  be purging _all_ their `preserve`
> configurations once they hit such errors. As the v2.34.0 change
> propagates through the Git ecosystem, hopefully it'll be a sufficient
> prompt for those who haven't realised that the option can be 'hidden' in
> their configuration options.

