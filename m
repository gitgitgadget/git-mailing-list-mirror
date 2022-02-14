Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA87C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 21:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiBNVOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:14:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiBNVOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 16:14:50 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC46106623
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 13:14:39 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4BFC11EC50;
        Mon, 14 Feb 2022 14:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XDl+VcBgWj4c
        6aell+WhjfvH8cdYs65fWkBE2L2nESo=; b=DVdYoTBex8aboh3nFNFBkvybkz9r
        ibAXfEy7W0zwi18fPDkyFO1Iu9tgqjihBoYkHReznp3n2PrS7Cx5efgGjHvov6sZ
        5NbGoh7Fa1V1rZjaKHgzXsoEfvhp9Xg3ph1KF5gF/d5Xv2tJxorqvAOhWVbG8GLy
        jepiXLCJqnRamco=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBF3911EC4F;
        Mon, 14 Feb 2022 14:52:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEF2011EC4E;
        Mon, 14 Feb 2022 14:52:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] date.[ch] API: split from cache.h, add API docs,
 stop leaking memory
References: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
        <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
        <220214.86czjpxst6.gmgdl@evledraar.gmail.com>
Date:   Mon, 14 Feb 2022 11:52:37 -0800
In-Reply-To: <220214.86czjpxst6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 14 Feb 2022 18:25:58 +0100")
Message-ID: <xmqq5yph2pkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9D3F366-8DCF-11EC-90F8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Feb 05 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Fix memory leaks in the date.[ch] API, in preparation for larger
>> changes to make the revision walking API stop leaking memory.
>>
>> This is a trivial re-roll to v1, to fix an issue that "make hdr-check"
>> spotted. For v1 see:
>> https://lore.kernel.org/git/cover-0.5-00000000000-20220202T195651Z-ava=
rab@gmail.com/
>
> Junio: I think this series may have fallen between the cracks. Any
> chance you're willing to pick this up? I'm keen to submit the larger
> revision.[ch] leak fixes in this cycle, and this is one of the few
> remaining dependencies for that.

I haven't seen the topic reviewed, and I haven't even had a chance
to give a cursory look, so until then, it will remain on the list
archive.

Thanks for reminding.
