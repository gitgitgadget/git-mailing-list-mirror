Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4EEC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC73C611C2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 20:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhI0UeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:34:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56615 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhI0UeV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 16:34:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 627FD141325;
        Mon, 27 Sep 2021 16:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=te6z0aWKRxja
        0L69+u7tMjoCce5qAxJtBpdkQwknKCM=; b=I/vgY7ztfuYCTPnjx4mes4zhwgB6
        NjvrnKP/Z6UAo2QSYtQ4XmEQrb0yrmK9ZXfYcDdAQQ3i5SBasdtJEU71TrhxqoVc
        qrO7ilM9H8T56qs+/xK2j5uZliKhHnRt5JGwiLC/FdUyVIqPZPZU03U65PrQLXNK
        xQOvBwYtx7/GwbQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B638141322;
        Mon, 27 Sep 2021 16:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD5DA141320;
        Mon, 27 Sep 2021 16:32:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/15] scalar: create a rudimentary executable
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <852ec003109b8244e2f9360ec64749779989c4a2.1631630356.git.gitgitgadget@gmail.com>
        <87sfxu2kyc.fsf@evledraar.gmail.com> <xmqqy27lvoyb.fsf@gitster.g>
        <8735pr2lcq.fsf@evledraar.gmail.com>
Date:   Mon, 27 Sep 2021 13:32:39 -0700
In-Reply-To: <8735pr2lcq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 26 Sep 2021 21:15:37 +0200")
Message-ID: <xmqqbl4dpxnc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0FA819EA-1FD2-11EC-99F9-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Sep 24 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> ... the
>>> usage.c API, which is generally being phased out.
>>
>> That is news to me.  Any reason why you think so?
>
> Perhaps better phrased as "generally going unused where we're using
> parse-options.c", ...

Ah, if it was merely an observation of the general trend, then I
agree.  My reaction was primarily "Oh, why is somebody all of a
sudden setting a project decision unilaterally, especially when even
I do not do so very often myself?  Did I miss recent discussion that
resulted in an update to Documentation/ meant for developers?"

Thanks.
