Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14DCC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 19:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhLPTLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 14:11:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58707 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhLPTLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 14:11:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9761D160CFC;
        Thu, 16 Dec 2021 14:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CfGETW23I1ND
        Y8zoFHGTK/XiDqcK+2/aFme+0+UjAbI=; b=QS0p1Yfeoxq7PCK7vY0NbWrZb0ej
        bH2UHYj9lZ/nWS1SpjEqg+3W8MhSvObe4y7cf01d7tAiPttqh7rHx0gijrzhYK7f
        aegLq4Sm41zHuZZIXC0zyQYe1SAFhrTu0TZvB0bBE98smmCNaEFDQKHvR644/mwA
        1HIIxJR5lK//Tis=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90CC8160CFB;
        Thu, 16 Dec 2021 14:11:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F3132160CFA;
        Thu, 16 Dec 2021 14:11:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: ab/run-command
References: <xmqq8rwlz3cq.fsf@gitster.g>
        <211216.868rwkbv1b.gmgdl@evledraar.gmail.com>
        <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
        <211216.86v8zoa761.gmgdl@evledraar.gmail.com>
Date:   Thu, 16 Dec 2021 11:11:41 -0800
In-Reply-To: <211216.86v8zoa761.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 16 Dec 2021 16:38:21 +0100")
Message-ID: <xmqqsfusbc0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 013DE298-5EA4-11EC-81EA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I like that it's just "args", so I don't think I'd change it even if I
> could waive the proverbial magic wand to d oit.
>
> We also have non-run-command.h code that uses "struct strvec args =3D
> STRVEC_INIT" (although most of that ends up being passed into the
> run_command.c function).
>
> Saying "argv.v" also seems a bit more strange than "args.v", IMO.

So perhaps the renamed member will be called envs?

;-)
