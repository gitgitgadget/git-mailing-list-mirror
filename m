Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37B2C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD506120D
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 07:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhFSHGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 03:06:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55309 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhFSHGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 03:06:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E5E8C3479;
        Sat, 19 Jun 2021 03:03:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1aNoNq6iUfGM
        ICsNwXWmFJ9utb+4LU2jzBmidPFBdTQ=; b=vYTGNCZQJZxAyVhKhLXlqQZpNB8Q
        k9owtsZYLXnBa2xxzjyNlrnrvphbKBLvd7mYk4TG5TPmH3rW4EHYl7EJgToIJyRP
        FXs5wAg3wBY7kCCtKoRgGsCNwKS24/VTSxlyjwx/Be5jDBnvvMCpPKvRkQRC8ltB
        KYgQJLwB9w+snQM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65A86C3478;
        Sat, 19 Jun 2021 03:03:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D22B5C3477;
        Sat, 19 Jun 2021 03:03:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Phillip Susi <phill@thesusis.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/4] CodingGuidelines: recommend singular they
References: <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <pull.975.v3.git.1623766273.gitgitgadget@gmail.com>
        <f06092a9053e40d93c4ec94b7fbbb1b8d563957b.1623766273.git.gitgitgadget@gmail.com>
        <87a6nryt51.fsf@evledraar.gmail.com> <xmqqsg1iseza.fsf@gitster.g>
        <xmqqbl86qtyf.fsf@gitster.g> <87bl85y15s.fsf@evledraar.gmail.com>
        <YMvuprVu1MnokHM5@camp.crustytoothpaste.net>
Date:   Sat, 19 Jun 2021 16:03:56 +0900
In-Reply-To: <YMvuprVu1MnokHM5@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 18 Jun 2021 00:53:58 +0000")
Message-ID: <xmqqr1gyjpyb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 83D95590-D0CC-11EB-953B-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I agree that in many cases we can effectively rephrase to avoid needing
> to do this, but if we acknowledge that sometimes we will need to write
> using third-person personal pronouns in some cases, it's worth
> documenting what those should be.

I think we've heard enough from both sides and there probably is not
misunderstanding among the folks, even though there are differences
of opinions.

I would like to consider that the last draft I did [*1*] based on
earlier suggestions by Derrick and =C3=86var would be a reasonable middle
ground.

I'll go mostly offline next week---I'd notice if the list came up
with a vastly different concensus when I come back, but hopefully
not ;-)

Thanks.


[Reference]

*1* https://lore.kernel.org/git/xmqqbl86qtyf.fsf@gitster.g/

