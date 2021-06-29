Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91620C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7416661C6F
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhF2BfI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:35:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55732 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhF2BfI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:35:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 332FB1329C6;
        Mon, 28 Jun 2021 21:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=vVJ1Zj+xFFtg4d4nPEjka5l/c
        dFT1vEegTsl1zp2Dkc=; b=sy7YNXgbKauEW5CwROccjPcSGFrxABVuBs2IwLYoS
        DaVzKeW7ZmRn67FYSn5LIJHgFwiQDu8US4JxcHSIj9KzgJJO8nSzGn0ilY6mdgqg
        Q8LVI8m3X6b3L5/RdyzD0af8yVzvjDq4gNN4dElSVcrOX1XgUz0Tr9Ht2bFGr+fK
        8o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B6971329C5;
        Mon, 28 Jun 2021 21:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59C9C1329C4;
        Mon, 28 Jun 2021 21:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [L10N] l10n: fixed tripple-letter typos
References: <20210621020740.25577-1-worldhello.net@gmail.com>
        <alpine.DEB.2.21.2106212034050.12899@perkele.intern.softwolves.pp.se>
        <CANYiYbFt-kk2zj54MtJqfb_S9DswLvHicBNd5MmiayUxqJFPqw@mail.gmail.com>
Date:   Mon, 28 Jun 2021 18:32:37 -0700
Message-ID: <xmqqim1x316y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E410100C-D879-11EB-9F94-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Peter Krefting <peter@softwolves.pp.se> =E4=BA=8E2021=E5=B9=B46=E6=9C=88=
22=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:36=E5=86=99=E9=81=93=EF=
=BC=9A
>>
>> Jiang Xin:
>>
>> > Andrei found that the word "shallow" has an extra letter "l" in
>> > "po/zh_CN.po". There are similar typos in other l10n files.
>>
>> Andrei also pointed out another typo in the Swedish translation, where
>> a configuration option had been copied incorrectly. Could you please
>> amend your patch to contain both these changes?
>
> Will merge.

Thanks.  I'll leave these changes to you and trust that you'll throw
me a pull request for po/ later.

