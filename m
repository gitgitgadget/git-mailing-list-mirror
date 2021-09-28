Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B54CC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F008A6128E
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 22:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242870AbhI1WOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:14:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50670 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243045AbhI1WOH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 18:14:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5007614B803;
        Tue, 28 Sep 2021 18:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=30idYMB/N4ir
        Da+kE0y9ceRUuW5xgiIiVOfqU7S7i9M=; b=D6ntnUHfc7nKX0eH3xFRxsbkRTMB
        KEed/zPmRinf39KMAhGOj92LLQUdq3qEZhJdSDNiPuI9wmiTXci9wefNXwj6kVbo
        aU4pncsYHOrgOB5DXj7Jagw4Iv3SD0Xi2kNyLryJoq9lDAOZsTGUdjiSgVNjP20G
        QdTZeiDezNk7qEY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4848914B801;
        Tue, 28 Sep 2021 18:12:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0F1F14B800;
        Tue, 28 Sep 2021 18:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] refs: remove long-dead code
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
Date:   Tue, 28 Sep 2021 15:12:23 -0700
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 15:02:19 +0200")
Message-ID: <xmqqv92kic3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28BE26A4-20A9-11EC-842B-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This removes dead code in the refs backend, mainly in the
> ref-cache. By line count this is mostly a straightforward follow-up to
> 9939b33d6a3 (packed-backend: rip out some now-unused code, 2017-09-08)
> and 9dd389f3d8d (packed_ref_store: get rid of the `ref_cache`
> entirely, 2017-09-25).
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
>   refs.[ch]: remove unused ref_storage_backend_exists()
>   refs/ref-cache.[ch]: remove unused remove_entry_from_dir()
>   refs/ref-cache.[ch]: remove unused add_ref_entry()
>   refs/ref-cache.c: remove "mkdir" parameter from find_containing_dir()
>   refs/ref-cache.[ch]: remove "incomplete" from create_dir_entry()

Looking good.  Thanks.
