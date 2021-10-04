Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4392C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 06:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC0961360
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 06:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbhJDGWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 02:22:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53946 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDGWw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 02:22:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DA3FE156823;
        Mon,  4 Oct 2021 02:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TnhUZ5IV7K5hQTCTsEZnMCSCC
        0kczY9FdI6vrVwQuTE=; b=raCUJ3V8POq3Td2bw2+cRJwPMxZSkNk9H9r1Op73I
        FW5dlQ6ro+AgptZ0hGJsHjVoVL0NRJ4vS7CaxO1h1x8KVbOBCg7kUhacJd0+OUTy
        8KtO2ESCTDADlcB38K+N+CHM3dAZkwIrydMcvhSeVDLU6Orckx3J8705mKXBNUzp
        lM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3B9D156822;
        Mon,  4 Oct 2021 02:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3AA4F15681F;
        Mon,  4 Oct 2021 02:21:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/5] COPYING: remove mention of GPLv3, clarify
 sub-project COPYING
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
        <patch-3.5-e91f8ce6984-20211002T091212Z-avarab@gmail.com>
Date:   Sun, 03 Oct 2021 23:21:00 -0700
Message-ID: <xmqqpmslxqcz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3EDA32EE-24DB-11EC-A0F7-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The COPYING file added in [1] is a product of its era, at the time
> discussions around the GPLv3 were quite active. Since then we have had
> almost on "GPL v2 or later" notices anywhere.

no

>
> Since then[2][3] linux.git has replaced its version of almost the
> identical wording with something that's a bit more formal, and which
> isn't mostly addressing a hypothetical future GPL v3 migratin. Let's

-tion

