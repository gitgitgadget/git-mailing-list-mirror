Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3092FC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 03:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CBB61002
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 03:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFHDwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 23:52:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54382 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFHDwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 23:52:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6692AC46A7;
        Mon,  7 Jun 2021 23:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=F/2Eij+DzjZr6ccfERn2OEqDd
        NJTbcToc0pmHT2awkI=; b=A8lM4xeEzKMQDctmsVteAukZvHGf88TS+pNMXurdE
        fAnTePn9XwKubX/DzDWhATwYZqDi8s8uVgpyYiSvs+0rSP4dEvHKl1TP/9NJy71i
        IdWvoNL5K90o/E4cfiK+9sbsGbz+NCnFU4dQlpekxA6KrX9KHPdKESM71hRZFEz+
        70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D02BC46A6;
        Mon,  7 Jun 2021 23:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5BFEC46A4;
        Mon,  7 Jun 2021 23:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/3] SubmittingPatches: a few unrelated minor fixes
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
        <cover-0.3-0000000000-20210607T110044Z-avarab@gmail.com>
Date:   Tue, 08 Jun 2021 12:50:25 +0900
Message-ID: <xmqqsg1tqake.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A8933C48-C80C-11EB-A1EE-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A few minor updates to SubmittingPatches spotted while paging through
> it the other day (or other month, given the delay until v2).
>
> See
> https://lore.kernel.org/git/cover-0.3-0000000000-20210512T084137Z-avara=
b@gmail.com/
> for the v1 discussion. This hopefully addresses all the outstanding
> comments with it.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   SubmittingPatches: move discussion of Signed-off-by above "send"
>   SubmittingPatches: replace discussion of Travis with GitHub Actions
>   SubmittingPatches: remove pine-specific hints from MUA hints

Will replace but it seems 2&3/3 have a bit more work to do.

Thanks.
