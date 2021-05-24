Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4474C47082
	for <git@archiver.kernel.org>; Mon, 24 May 2021 01:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD61561168
	for <git@archiver.kernel.org>; Mon, 24 May 2021 01:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhEXBRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 21:17:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56381 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhEXBRU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 21:17:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA47FB0D41;
        Sun, 23 May 2021 21:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pOrR/F/59WF5
        3Foq+s7Au/wFpe0DuOQrE4bYY792k3M=; b=gab15DUM+biShEoJSJt94GpIqO4W
        x2vKX81sxjfzHZgFRa5Rbtg5xMo6Nw6ihQd6P9OGPs7/ZRZ+GADI82y14+jMJRXs
        3LXVCBc5NcCdUxw3aDyxs/s1vzJ6w6YuoBa6nwkCZDrFrRlydYIKxmzHf6YhyzCA
        T38C30klzK4XoUc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0F67B0D40;
        Sun, 23 May 2021 21:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34CB4B0D3F;
        Sun, 23 May 2021 21:15:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/13] send-email: various optimizations to speed up
 by >2x
References: <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
        <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
Date:   Mon, 24 May 2021 10:15:51 +0900
In-Reply-To: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 23 May
 2021 10:56:05 +0200")
Message-ID: <xmqqwnrplyns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94E23C70-BC2D-11EB-AA96-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A re-roll of v2[1] which fixes issues pointed out with v2, plus some
> others I noticed along the way.

"move trivial" step does not seem to apply to master, next, or jch
and it does not seem to apply to master...ab/send-email-optim
either.

On top of what commit were these patches designed to be applied?

Thanks.
