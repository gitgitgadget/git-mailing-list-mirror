Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C25FC2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB93613F5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhFOC0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:26:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61597 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhFOC0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 22:26:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B280F124EA8;
        Mon, 14 Jun 2021 22:24:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8pUq+rGN66r+
        M0kf2T+qhyZp07K3FqrHwNZ24DVJAPo=; b=jCdaSC7QUg5AoKZmNgF6JBMiFPN5
        1r0Z7Dsrv+JulRyXp7+GZNuN2jASbWcsO2EF/5iDp5kFz8Ap8PUH4sGb2xtUQYvm
        IMOzXPFwAlAHK+Zh80ZtaBgmHVeSjEguCwnGnqLvKqj24o0DjC0yZI57cLAB031Y
        FG4NU4Hb3vJ2N2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AAEFA124EA7;
        Mon, 14 Jun 2021 22:24:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFBE0124EA6;
        Mon, 14 Jun 2021 22:24:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 0/8] test-lib tests: split off subtest code in t0000
 into lib-subtest.sh
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
Date:   Tue, 15 Jun 2021 11:24:17 +0900
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 14 Jun
 2021 12:48:06 +0200")
Message-ID: <xmqq35tjzwz2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9CB569C-CD80-11EB-A72D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This refactors the testing of test-lib.sh itself in t0000 into a
> lib-subtest.sh, fixing duplicate setup, bugs and various shell nits
> along the way.
> ...
> I thought it was better to submit this now anyway, while
> this code is fresh in people's minds.

Any time you send it anew is the time it is fresh in people's minds
if they read it, no?  I am not sure I understand the reasoning.

> I'm hoping Felipe will take some variant of my
> http://lore.kernel.org/git/8735tk22if.fsf@evledraar.gmail.com and
> perhaps review this series & base his patch on top of these changes,
> but alternatively they can go in independently with Junio solving the
> conflict.

I'd rather not if it can be avoided.  Please scale the process by
coordinating among contributors yourselves.
