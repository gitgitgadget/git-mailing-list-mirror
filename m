Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F588C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhLLSiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 13:38:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60684 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhLLSiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 13:38:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDEC0F357D;
        Sun, 12 Dec 2021 13:38:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vu0yqbmGXFgP
        2Up5I0UtBPoJsb21OpI01v7hiIn2bUw=; b=ga12E42C2/FDBzcXxe6tvxLtbODt
        bl9U8F363hre6fbxoCU131lHNmEnOnbN1dTmzFEySJIkBHoRDgLbY9IlNvi9Sjfc
        gI3ZOUddKf/BGpHcQRxQDUA37EdCLY+e60YcXxS/99giewuAyeOF1N6dA9sd5gvq
        RSVgYsF2LHQPbcs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A35EFF357B;
        Sun, 12 Dec 2021 13:38:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03BEAF357A;
        Sun, 12 Dec 2021 13:38:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jose Wielandt <jose.wielandt@timining.com>,
        Fabian Stelzer <fs@gigacodes.de>, git <git@vger.kernel.org>
Subject: Re: Please, paint new branch errors in RED (or any visible color)
References: <CAJrA3nLUG_m1ftdAyzFBkmL3m1vMPuv5dd3bYVVOmXV-fThwnA@mail.gmail.com>
        <211210.86r1akbes8.gmgdl@evledraar.gmail.com>
        <20211210164249.bahhe5ogjjhz4lxo@fs>
        <CAJrA3nKbUK=_5d5KTCDehrfge4y1aB9YGsFwQYNzUDWGcfog4w@mail.gmail.com>
        <211211.86a6h7c1mq.gmgdl@evledraar.gmail.com>
Date:   Sun, 12 Dec 2021 10:38:16 -0800
In-Reply-To: <211211.86a6h7c1mq.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 11 Dec 2021 03:30:00 +0100")
Message-ID: <xmqq4k7dlld3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC879694-5B7A-11EC-8F9D-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Dec 10 2021, Jose Wielandt wrote:
>
>> Yes, I git switch has the same behavior.
>> I also agree that add hints could be a good idea.
>
> I'll pick up this topic.

Please make sure color challenged users can configure it away or
customize it somehow.

Making it opt-in is even better, but it is my personal taste.
