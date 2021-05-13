Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DFEC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61D861406
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhEMVoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:44:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62388 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhEMVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:44:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 21AC613353D;
        Thu, 13 May 2021 17:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dLgITaPJofhx
        Qd5MWxj+lzG+Wo/bJ/UJ87ft0YGM8pQ=; b=sYZCB9bHtNXVnhEJcTFGVCaJ9Et/
        iDa7PJc3V2fAKSN5subGixxO4fpKkEkm3quMjSW2C7Wh8F/N/CEWGiZCZb+01ntQ
        7UaO1hQi2Yt+XP7BCzsm3wMqlj6ziRUFI7IFULYsWx8FA034p0VtPYBHcRH3Fbui
        sj5RGYxPeHpOXN0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ACBA13353C;
        Thu, 13 May 2021 17:43:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9910413353B;
        Thu, 13 May 2021 17:43:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/8] doc: add an asciidoc helper
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
        <20210512222803.508446-3-felipe.contreras@gmail.com>
        <87bl9esls8.fsf@evledraar.gmail.com>
Date:   Fri, 14 May 2021 06:43:17 +0900
In-Reply-To: <87bl9esls8.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 13 May 2021 17:17:33 +0200")
Message-ID: <xmqq4kf69uoa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B055026-B434-11EB-B68E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But if you're trying to address this "maybe it errors" issue then
> .DELETE_ON_ERROR is a better solution.

Yeah, I forgot about that, but I agree that .DELETE_ON_ERROR is a
good thing to use, as we depend on GNU make anyway.

Thanks for bringing it up.
