Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569DCC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B5E20708
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 08:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894920AbgJ0Icj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:32:39 -0400
Received: from dd36226.kasserver.com ([85.13.153.21]:45816 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894816AbgJ0Ici (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 04:32:38 -0400
Received: from client3368.fritz.box (i5C7443F9.versanet.de [92.116.67.249])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id E874D3C0439;
        Tue, 27 Oct 2020 09:32:36 +0100 (CET)
Subject: Re: [PATCH] Fix zsh installation instructions
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexey via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>, Alexey <lesha.ogonkov@gmail.com>
References: <pull.814.git.git.1593687080695.gitgitgadget@gmail.com>
 <xmqqr1to8dv9.fsf@gitster.c.googlers.com>
 <abc4ab95-ed65-1d6b-e964-73734c08cda9@haller-berlin.de>
 <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
From:   Stefan Haller <lists@haller-berlin.de>
Message-ID: <abc34ced-0c0f-4024-a50c-30e4ca31b325@haller-berlin.de>
Date:   Tue, 27 Oct 2020 09:32:36 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAMP44s3=CUmx_7DCExK7L4trZvQTxO67Qk20eexsP3su-3RyKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25.10.20 4:29, Felipe Contreras wrote:
>> The other hunk (adding compinit) is not so important to me; I suppose it
>> was not in the original version because most zsh users already have this
>> in their .zshrc anyway. But it's not wrong, and doesn't hurt to have
>> here, I guess.
> 
> If you don't have compinit, then how is the '_git' script being loaded
> in the first place?

I didn't say it's unnecessary to have it in your .zshrc. I just said 
it's maybe unnecessary to document it here because most zsh users have 
it in their .zshrc already anyway.

(Sorry for the other empty mail, I hit the wrong button...)

Best,
Stefan
