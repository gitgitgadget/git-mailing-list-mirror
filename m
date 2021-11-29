Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFACC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 02:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbhK2CfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Nov 2021 21:35:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54802 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbhK2CdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Nov 2021 21:33:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 647CF168152;
        Sun, 28 Nov 2021 21:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ycznGDuqaEQXRfe+U6ACX+2fo
        jPgraEFAC7PUn2fBo4=; b=d0RYleZ3N0KE/tlFGYgRdAQavMfZhcPdHy05Oh+uB
        pHyhB/oXXiS8iXRFCb/3mkYhTKccZ5BczZjZ5r+dZI701VCJ7puw9jFDAI/VsZeJ
        pBFR4ejcAjVvvXrJSYdUClcKvvDDAfcxcEL7LtrPdaStCsTvVhK/U2h3unRkLmQY
        Tg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D0F0168151;
        Sun, 28 Nov 2021 21:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D134168150;
        Sun, 28 Nov 2021 21:29:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bc/require-c99 + jc/c99-var-decl-in-for-loop
References: <xmqqlf1caica.fsf@gitster.g>
        <211126.86czmnhwu4.gmgdl@evledraar.gmail.com>
Date:   Sun, 28 Nov 2021 18:29:47 -0800
Message-ID: <xmqqh7bv4rtw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39C03B48-50BC-11EC-8078-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 24 2021, Junio C Hamano wrote:
>
>> * bc/require-c99 (2021-11-18) 1 commit
>>  . git-compat-util: add a test balloon for C99 support
>>
>>  Weather balloon to break people with compilers that do not support
>>  C99.
>
> It would be nice if they'd upgrade, but maybe breaking those people is
> going a bit far :)

You cannot tell who if anybody is not ready without a small piece of
change, which is very easy to revert locally, that would break them
hard.  If you look at the patch in question, especially if you pay
attention to what message it gives those who are not ready when it
happens, I would think you agree with the patch thta it is not going
too far.
