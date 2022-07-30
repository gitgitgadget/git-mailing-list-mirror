Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D4EC19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 20:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiG3UoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 16:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiG3UoN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 16:44:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB4815808
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:44:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3C31469E8;
        Sat, 30 Jul 2022 16:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NGh8gP2VxZly
        qnT+Jn3IAEyTKVbrzRH/IH/BL6FlPGM=; b=Oi/KI5NxVmPoHPI9ScYzLJKwnTjY
        dL89oX+o9jW5mvXs15z6oEx/t1+Tc78FWGsQWkewSkHuiLOXlT7+wLhT0Krr0fDQ
        /VOAPGrmQULawCXFvT9USZEOdQRujME9m7DOu11Bc5jGv7Mz3LDfAa/XAk7JYZXR
        VIP/xSU/0gTVIP0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63FA31469E7;
        Sat, 30 Jul 2022 16:44:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A01D11469E5;
        Sat, 30 Jul 2022 16:44:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 9/9] docs: add CONFIGURATION sections that fuzzy map
 to built-ins
References: <cover.1657819649.git.matheus.bernardino@usp.br>
        <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
        <patch-v2-9.9-91689154926-20220729T081959Z-avarab@gmail.com>
        <CAHd-oW7PV=sAmfonMDnCCEQ9NF-fmpqYAYGRS6+AJRxfyExUgQ@mail.gmail.com>
Date:   Sat, 30 Jul 2022 13:44:06 -0700
In-Reply-To: <CAHd-oW7PV=sAmfonMDnCCEQ9NF-fmpqYAYGRS6+AJRxfyExUgQ@mail.gmail.com>
        (Matheus Tavares's message of "Sat, 30 Jul 2022 16:08:05 -0300")
Message-ID: <xmqqpmhm1gbt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B7DE770-1048-11ED-9DDC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Add a CONFIGURATION section to the documentation of various built-ins,
>> for those cases where the relevant config/NAME.txt doesn't map only to
>> one git-NAME.txt. In particular:
>>
>>  * config/blame.txt: used by git-{blame,annotate}.txt. Since the
>>    git-annotate(1) documentation refers to git-blame(1) don't add a
>>    "CONFIGURATION" section to git-annotate(1), only to git-blame(1)>
>>
>>  * config/branch.txt: maps to both git-checkout.txt and
>>    git-switch.txt (but nothing else).
>>
>>  * config/init.txt: should be included in git-init(1) and
>>    git-clone(1).
>
> I think the inclusion at git-init(1) is missing in the diff below.

Good eyes.  Thanks for carefully reviewing.
