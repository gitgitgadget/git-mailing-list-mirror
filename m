Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4525FC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1132722D6E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbhAFGGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 01:06:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50710 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbhAFGGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 01:06:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96DE4AEE48;
        Wed,  6 Jan 2021 01:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=6tSNIFiaXbNKTvo2AW6SFG6Hw
        eY=; b=J2W32YcHISMPCez63GNEAQ0SSNqBFh/3/X3hAT9AbXF6MBXSTP9vj07n1
        BBoLXOfwKfjgmEgZmyaM0olnjJLFu+ZdsRkh7G65ls9YXZWD+Fhe0psHqqS71QhC
        LC7WTlxRC0Oc6o7jWHOdtErFv4zsrBBjO4ieO3U0Ew4++eFplI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=gqYWXmaUAmORleSGX1d
        yvhcU82dWyMiOJ/QchFgX48C0+T/GxAoozbiEuOlCBkCBo0eeUzRqUkAoYUT+JyK
        YZrV+lJzRun+QAdBDEB60h4YnyWIiGHGtNCnU71WNlUQEX0i4CgDJiParZRfitDg
        HbPdmVhQcQlMiH9/lo5YLefk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F3FFAEE45;
        Wed,  6 Jan 2021 01:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BD6CAEE44;
        Wed,  6 Jan 2021 01:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] t1300: minor cleanups
References: <20210103093649.2221-1-martin.agren@gmail.com>
Date:   Tue, 05 Jan 2021 22:05:22 -0800
Message-ID: <xmqqeeiyvbvh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29B2B33A-4FE5-11EB-9CA0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> There was some discussion around t1300 a while back and how it could
> need some major cleanup [1]. This patch series is not that. I'll post a=
n
> RFC series on that later. These initial cleanups -- or something like
> them -- should be useful regardless of the fate of that future RFC, so
> I'm posting them early.
>
> [1] https://lore.kernel.org/git/xmqqlfeuqd8d.fsf@gitster.c.googlers.com=
/
>
> Martin =C3=85gren (3):
>   t1300: remove duplicate test for `--file ../foo`
>   t1300: remove duplicate test for `--file no-such-file`
>   t1300: don't needlessly work with `core.foo` configs
>
>  t/t1300-config.sh | 72 +++++++++++++++++++++--------------------------
>  1 file changed, 32 insertions(+), 40 deletions(-)

All look sensible.  Thanks.
