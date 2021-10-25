Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383BEC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFF260F46
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 17:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhJYRva (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:51:30 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55766 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhJYRvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 13:51:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C08F16AADF;
        Mon, 25 Oct 2021 13:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=daFYOIXu16Pb58T+nHkov49HEw83Kc5LGriHbq
        A1P7A=; b=A34xxj3WIo5aLdO1FvEdkgauC3GBE++pHlFIW2v6MUbpRW7rHz0azQ
        /znFyQYZP/1m6awUcWohTqdex4XBZvkhaBvUfUI8W8C1S23ZnrCS2+TVqRVWbiEC
        EJE00uFs0NKU1pTDz9uNn1UzJkhEn4IsRqL8tvVroicy4cOld8RIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2649416AADE;
        Mon, 25 Oct 2021 13:48:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8532B16AADA;
        Mon, 25 Oct 2021 13:48:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>, vagabon.xyz@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] archive: describe compression level option
References: <20211022064543.28950-1-bagasdotme@gmail.com>
        <CAPig+cRAi4ZR+_+Dh+DoUBkG=sgWTekxadob2YvThJQhr9tqfA@mail.gmail.com>
        <xmqqcznvbg2m.fsf@gitster.g>
        <CAPig+cQ8NEKY3nwuFi_7Hc7L7rnbcUShf3zw60PvBB8LOPEgPA@mail.gmail.com>
Date:   Mon, 25 Oct 2021 10:48:48 -0700
In-Reply-To: <CAPig+cQ8NEKY3nwuFi_7Hc7L7rnbcUShf3zw60PvBB8LOPEgPA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 25 Oct 2021 12:39:07 -0400")
Message-ID: <xmqqsfwp0zcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF5AB794-35BB-11EC-ABBA-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> In summary, perhaps something like this?  I still have "-9 (best
>> ratio)" which does not say it is merely the intent and not
>> guarantee, but the resulting text read a bit funny with "best ratio"
>> replaced with "try hardest".
>
> This version looks fine. Thanks.

Thanks for proofreading.  I have locally fixed a grammo ("Larger
values allow the command"), by the way.


