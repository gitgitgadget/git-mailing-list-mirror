Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FDC433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 21:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbhKXVZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 16:25:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58853 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhKXVZB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 16:25:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AF8C106558;
        Wed, 24 Nov 2021 16:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kY+6jrR+q1Od
        bdkCRP8lo9iqjevVcGvOXl3MruBsvrI=; b=WQxthfNC++4Qd6vuvX74FpS5x7D1
        i5xogJHYMceL80DY3kSK+TsCbEI5t1Ulm2paxr0Cth+yggqpBx6Q/i0qVP3mmdDQ
        mBdiwZbddMs9r4eLQzehOAk8bGdC9Mnarj4bzgjQyGgV5InpdLYXuNHP8boDxOCf
        Dg+dqm5vJGHgr4s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00466106557;
        Wed, 24 Nov 2021 16:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66137106554;
        Wed, 24 Nov 2021 16:21:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, <git-packagers@googlegroups.com>
Subject: Re: [ANNOUNCE] Git v2.34.1
References: <xmqq7dcx1ent.fsf@gitster.g>
        <000201d7e173$3eb3d320$bc1b7960$@nexbridge.com>
        <000301d7e174$1b568570$52039050$@nexbridge.com>
        <xmqq35nl1dsh.fsf@gitster.g>
        <000c01d7e177$f43327b0$dc997710$@nexbridge.com>
Date:   Wed, 24 Nov 2021 13:21:49 -0800
In-Reply-To: <000c01d7e177$f43327b0$dc997710$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Wed, 24 Nov 2021 16:12:08
        -0500")
Message-ID: <xmqqilwhz1ua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89BD63A8-4D6C-11EC-AAED-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On November 24, 2021 3:48 PM, Junio C Hamano:
>> <rsbecker@nexbridge.com> writes:
>>=20
>> >> In an unusual situation, make reports:
>> >>
>> >> GIT_VERSION =3D 2.34.GIT
>> >>
>> >> Instead of the expected
>> >>
>> >> GIT_VERSION =3D 2.34.1
>> >>
>> >> which we see usually.
>> >>
>> >> Am I missing a step that was added since 2.34.0?
>> >
>> > Oops. I have to build off 'maint' not master. Got it.
>> > -R.
>>=20
>> You made me cut my lunch break short to double check, but all is well =
if the
>> release materials are good after all ;-)
>
> Hopefully when travel is permitted and I can next get to your area, I c=
an repair this with beer =F0=9F=98=89
> Cheers,
> -Randall

Cheers.  There is nothing to repair.  I don't drink, but thanks for
the thought.

Have fun.
