Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE95C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 20:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347053AbiBBUTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:19:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64444 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiBBUTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 15:19:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E221117F845;
        Wed,  2 Feb 2022 15:19:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q6HYS456O94c
        mx9OSc0YWfeUwVRW1sFae4NGaINV0T0=; b=MQ4kpxAHYlTPIPn8it8IsAG/r5cH
        fhZnJhGF4u0Ulb2omej0Agp4Ku1CZ/AUEk8637b9ZtvMzfGnQthZa64TbBLs+ZSD
        R4nYlHf9bvrbe4IAiT67lQ1y5xhg/IrFrTFF9sXteD9Zqy+oxoM9sclxyff89FlR
        NNBLYDKyffIfHH0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB23D17F844;
        Wed,  2 Feb 2022 15:19:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51CDA17F843;
        Wed,  2 Feb 2022 15:19:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0051: use "skip_all" under !MINGW in single-test file
References: <patch-1.1-34ff968dcb8-20220201T203428Z-avarab@gmail.com>
        <xmqq5ypycl7u.fsf@gitster.g>
        <220202.86zgn96oip.gmgdl@evledraar.gmail.com>
Date:   Wed, 02 Feb 2022 12:19:09 -0800
In-Reply-To: <220202.86zgn96oip.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 02 Feb 2022 20:44:16 +0100")
Message-ID: <xmqq7dad10oy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 61788230-8465-11EC-8594-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> This way TAP consumers like "prove" will show a nice summary when the
>>> test is skipped, e.g.:
>>
>> ... as opposed to?  A failure?  A different appearance of the log
>> message?  Something else?
>
> In "prove" we go from simply showing "ok":
>    =20
>     $ prove t0051-windows-named-pipe.sh
>     t0051-windows-named-pipe.sh .. ok  =20
>     All tests successful.
>     Files=3D1, Tests=3D1,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.0=
3 cusr  0.01 csys =3D  0.06 CPU)
>     Result: PASS
>    =20
> To showing the skip message quoted here:

Because you have been here long enough, I trust that you already
know this, but for the benefit of those reading from sidelines...

As with many questions I give during my code review, this was not a
request:"I do not understand this---please explain it to me".  It
poined out the part in the proposed log message that future readers
of "git log" would be puzzled about and needs to be improved.

Thanks for a reply.



