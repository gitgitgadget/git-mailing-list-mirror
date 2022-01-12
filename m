Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FD2C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 18:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242265AbiALSNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 13:13:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55789 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbiALSLm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 13:11:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB544114FC5;
        Wed, 12 Jan 2022 13:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vrEmzUD/TyJA
        tbAtmmUlRjzvVSGQOEgJ92t9vLBBc8U=; b=g5Qk6xWX8gph1RCoaYFy5Jfw93Be
        uJlykcvIwB2fx/86uPHnkQm/2RJLJNFBBaoo8XTkSjzcAc0mkaPIAg71JMl+3gJV
        5SFEZhFJc4AOKD/Dr6300+wEGMFQds2C+nwK1ela4eCF4Sc2CdHnw2jxPtJkxyia
        X25w7si7o1hRmuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D27E7114FC4;
        Wed, 12 Jan 2022 13:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 49E17114FC3;
        Wed, 12 Jan 2022 13:11:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 0/2] fixups for issues in next-merged ab/cat-file
References: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com>
        <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
        <Yd2mwoHd6mNrh+06@nand.local>
Date:   Wed, 12 Jan 2022 10:11:40 -0800
In-Reply-To: <Yd2mwoHd6mNrh+06@nand.local> (Taylor Blau's message of "Tue, 11
        Jan 2022 10:48:18 -0500")
Message-ID: <xmqqfspsx1r7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 179E6410-73D3-11EC-81B2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jan 10, 2022 at 11:08:44PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> This series goes on top of ab/cat-file, which was merged to next in
>> e145efa6059 (Merge branch 'ab/cat-file' into next, 2022-01-05).
>>
>> The first commit addresses an issue Jiang Xin raised in
>> https://lore.kernel.org/git/CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvd=
hPOdjpBCg@mail.gmail.com/
>>
>> The second fixes a typo of mine when referring to an option name that
>> I spotted while preparing this.
>
> Thanks; both of these small fixes look fine to me.
>
> Just ACKing in case this topic happens to graduate to master even thoug=
h
> we are already past -rc0.

Thanks.  I do think these fix-ups should be at the same integration
stage as the earlier patches, but I do not know if the topic itself
should be in the upcoming release.

Let's merge these two to 'next', too.
