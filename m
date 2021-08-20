Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84FC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751C26101C
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhHTR4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:56:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60936 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTR4x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 13:56:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FEBBD97E3;
        Fri, 20 Aug 2021 13:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hFZQcDjM61cFhnYn+Kq93BuCqBjNvCzO//frWA
        TS0g0=; b=wB5AzQVSMy5ygT4gPcnJNukrbAxDQHOXCTHvKD0VMS8rXm3wb331qa
        m2M25ZYsYQwqrsjnS+VEfcEJKdMU81oo91bvyNDjeaq4/SHLKQSSsb0ALl12qJ+W
        Tg2Cw32NH0XN+XuPgeHO2Y3L8TsVdG7+BNFvo7Gg3/kyJEoAqvhAU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74321D97E1;
        Fri, 20 Aug 2021 13:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E316BD97E0;
        Fri, 20 Aug 2021 13:56:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: Re: [GSoC] Git Final Blog
References: <CAOLTT8SxHuH2EbiSwQX6pyJJs5KyVuKx6ZOPxpzWLH+Tbz5F+A@mail.gmail.com>
        <CAP8UFD0sbcJdrXYnumjHwzth150oEvW_uP9jgiR0NM0tn4Eu4A@mail.gmail.com>
Date:   Fri, 20 Aug 2021 10:56:13 -0700
In-Reply-To: <CAP8UFD0sbcJdrXYnumjHwzth150oEvW_uP9jgiR0NM0tn4Eu4A@mail.gmail.com>
        (Christian Couder's message of "Fri, 20 Aug 2021 18:22:27 +0200")
Message-ID: <xmqqbl5suhj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8F7EB82-01DF-11EC-B852-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Aug 19, 2021 at 7:39 AM ZheNing Hu <adlternative@gmail.com> wrote:
>>
>> My final week blog finished:
>> The web version is here:
>> https://adlternative.github.io/GSOC-Git-Final-Blog/
>
> Great, thanks!
>
>> ## Git Final Blog
>
> [...]
>
>> ### Concluding remarks
>>
>> This summer vacation, I have gained a lot, also made a lot of friends.
>>
>> Thanks to Google and Git.
>>
>> Thanks to those people who have helped me!
>>
>> Thanks to my two mentors Christian and Hariom.
>
> Thanks for all the work you did, and for your enthusiasm, dedication
> and involvement with the mailing list!
>
>> Three months ago, at the beginning of GSoC, I cited the example
>> of Junio's interview:
>> [[GSoC] Hello Git](https://lore.kernel.org/git/CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com/).
>> As an echo, I will maintain a passion for open source and technology,
>> and continue to participate in the development and maintenance of the
>> Git community.
>
> Great! We are looking forward to continuing to work with you!

Surely.  

We hope each participant had developed useful skills, found that
contributing to an open source project is fun, and most importantly,
had a great fun.

I hate to see the "Final" label on these messages.  Even thoguh this
round of GSoC may be coming to an end, don't become a stranger ;-)

Thanks.

