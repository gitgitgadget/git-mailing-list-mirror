Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176FC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E27561A26
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 19:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbhCXT5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:57:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59543 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbhCXT5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 15:57:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A9AB12A88B;
        Wed, 24 Mar 2021 15:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4rr+hRmnA1Tx
        t9gqVYHbT9ISlVY=; b=yh9j4ZJWrLxmRBck4VO1MOpNOLe+00UoXiU/uRneOn9r
        s1Z67a0U+ICOI/IOlP3myW4dRvORw3LDYCAw+QyuD1J7clBmuuaGXaf5qJnYpbwc
        1IrFDjWVoZ+J/T3QHIW9r64UpCTJz4/FQ70YPWIEpizYhXJo5r22lTRsuRR+If0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NB9Iok
        Q8NSKE1Xw64bow8hkL35impCnhv6JAwPl2riXmjwlVpY8V6x77baVQFhhl25wJ5E
        WGKWmbSCCUOdijHXfg7WAX/QeJbtHpsTigRaXxcDS3sTK8VqlYEwUPbTVSEoaZ5v
        lHzun6ursmEkhNL67RTEUsYzLDKkSDRAdR9Q8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43FED12A88A;
        Wed, 24 Mar 2021 15:57:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 86E5A12A889;
        Wed, 24 Mar 2021 15:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, ric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] mktag tests: fix broken "&&" chain
References: <20210307132905.14212-1-avarab@gmail.com>
        <patch-1.1-0b43e43b949-20210324T021049Z-avarab@gmail.com>
Date:   Wed, 24 Mar 2021 12:57:34 -0700
In-Reply-To: <patch-1.1-0b43e43b949-20210324T021049Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 24 Mar
 2021 03:11:52 +0100")
Message-ID: <xmqqo8f8xr2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E320B94-8CDB-11EB-A9EF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove a stray "xb" I inadvertently introduced in 780aa0a21e0 (tests:
> remove last uses of GIT_TEST_GETTEXT_POISON=3Dfalse, 2021-02-11).

Thanks.
