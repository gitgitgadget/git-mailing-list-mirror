Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F34C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 09:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhLKJWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 04:22:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64839 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhLKJWo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 04:22:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80E0E173614;
        Sat, 11 Dec 2021 04:22:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=J2sbE+7Y9n3u8/Lkq0Agoi88i
        8gmFRIKXf+kFzt3Puw=; b=wGBizMHYdw37BThJBQ2NtXw73fhwXl+pHTx1fFpBo
        Tg01PKdwtzmGQE4aIFcoUgmFBPq7HF4coGJJQ9kWCOYg35xAtHiQfgZJtJkwm6C9
        9uKbx9a+Yao6vp0anEo2i5xLY+N4vZ3g+qMYHyaO253T3wzlJQWzWzl4uAw/BtXj
        qY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6EC53173613;
        Sat, 11 Dec 2021 04:22:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A1FE0173612;
        Sat, 11 Dec 2021 04:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        =?utf-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87_=28Aleen=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v19 1/3] doc: git-format-patch: describe the option
 --always
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
        <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
        <a524ca6adfa2adc02e517b7be5199b0c071134c4.1639034755.git.gitgitgadget@gmail.com>
        <1ad4a3ee-af05-9bb2-67fe-566d5e4c39a8@gmail.com>
        <7bd729fd.29.17da1f2df5d.Coremail.pwxu@coremail.cn>
        <0784617f-416f-a981-44e0-62bd22018d6c@gmail.com>
Date:   Sat, 11 Dec 2021 01:22:37 -0800
Message-ID: <xmqqczm3lcma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E24FD4A2-5A63-11EC-BB82-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 10/12/21 08.26, Aleen =E5=BE=90=E6=B2=9B=E6=96=87 wrote:
>> Dears Sanjaya,
>>      Thanks for your suggestion. I don't see the actual difference
>> between
>>      the two sentences, and do you want to enhance the word "always"?
>>      If you do, how about just describing the option as "Always includ=
e patches..."?
>> Aleen
>>=20
>
> Semantically speaking, I choose "generate" because git format-patch **g=
enerates**
> patches from the specified commits.

But the given commit is empty and does not result in a patch at
all, which is the whole point of having this option, no?  A typical
format-patch output message consists of the message part and the
patch part, and calling an output created for an empty commit a
"patch" leads to confusion, I am afraid.

So, between the two sentences, I do not see much difference either
way.
