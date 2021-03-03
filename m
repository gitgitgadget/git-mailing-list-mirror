Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA5EC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D641C64E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355272AbhCDAWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:03 -0500
Received: from [93.83.142.38] ([93.83.142.38]:35370 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1452178AbhCCHNg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 02:13:36 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 26782368B9;
        Wed,  3 Mar 2021 08:13:13 +0100 (CET)
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com>
 <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com>
 <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org>
Date:   Wed, 3 Mar 2021 08:13:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.03.21 um 22:52 schrieb anatoly techtonik:
> For my use case, where I just need to attach another branch in
> time without altering original commits in any way, `reposurgeon`
> can not be used.

What do you mean by "attach another branch in time"? Because if you
really do not want to alter original commits in any way, perhaps you
only want `git fetch /the/other/repository master:the-other-one-s-master`?

-- Hannes
