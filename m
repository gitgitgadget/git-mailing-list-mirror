Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC1CC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1F60FC3
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 20:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbhHDULG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 16:11:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60435 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240818AbhHDULF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 16:11:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF3C213178F;
        Wed,  4 Aug 2021 16:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7WpAYKeshcrS
        Vfa6rnzL1Co8UAQNUq5tA0n2ctw+b2M=; b=h/Uha7FTVImOcZtn6pqfoaK65iGj
        VEqwuB0M4tenlLr7T2KpOIH8LMFT0oW3p0lvoMoISGZvmmb8wIzSUJNeWVumDixY
        9lwJPIbFCTllY9Khu1uUhjmeXmwQAaPKCaK48Os9+OsKT8+O0v4PW4C152cZxF1Z
        sMq3Pg/aovKeWXk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B828F13178E;
        Wed,  4 Aug 2021 16:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E410E13178D;
        Wed,  4 Aug 2021 16:10:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
References: <xmqqfsvpr8t5.fsf@gitster.g> <87wnp1mqv2.fsf@evledraar.gmail.com>
        <xmqq4kc5ozi7.fsf@gitster.g> <87lf5hm0v7.fsf@evledraar.gmail.com>
Date:   Wed, 04 Aug 2021 13:10:47 -0700
In-Reply-To: <87lf5hm0v7.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 04 Aug 2021 21:53:02 +0200")
Message-ID: <xmqqzgtxnf7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10072AF8-F560-11EB-9AFD-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This is because post-c49a177beca we don't "unset" COLUMNS anymore, whic=
h
> bash takes as license to update it.

Ah, OK.

Thanks.
