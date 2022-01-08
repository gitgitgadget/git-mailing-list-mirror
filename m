Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E9C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 00:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiAHApI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 19:45:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64240 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAHApI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 19:45:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66E6B1114C2;
        Fri,  7 Jan 2022 19:45:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/o4DG89i5dGe
        mNfWyR4imsEcJpub6qC+eTecSXzRQCw=; b=H8nZkmBaZ9JU+r7ae6oKQwc8fQwx
        L0vS+Xcy4lSvHZd4IyiCzK/QTcL3bOMXUa5J5Hulc9Cm/LzGkGB0FQCsSo5zGwxj
        0KRVVeryQUbiSyGwDFOCeWpW0sWc1bnYxlefdqzft04pywXYMNbzeUq5pY97PrS2
        cD+wjAcE3sSI+MI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58B4B1114C1;
        Fri,  7 Jan 2022 19:45:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08CB21114BF;
        Fri,  7 Jan 2022 19:45:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v8 0/7] progress: test fixes / cleanup
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
Date:   Fri, 07 Jan 2022 16:45:04 -0800
In-Reply-To: <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Dec
 2021 16:18:56
        +0100")
Message-ID: <xmqqwnjb3vjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 39129EF0-701C-11EC-9E1E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Various test, leak and other fixes for the progress.c code and its
> tests. This v8 addresses feedback on v7[1] by Johannes
> Altmanninger. For that round I accidentally broke the In-Reply-To
> chain, so I'm replying to the v6 here to attach it to the original
> thread again.

Is this replying to v6 of a totally unrelated topic that is about
ambiguous object name?

