Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B021C07E95
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 00:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F8461CAA
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 00:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhGHAUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 20:20:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56658 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGHAUo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 20:20:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB46DDFDC9;
        Wed,  7 Jul 2021 20:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=btpX6rohL09Q
        U4wAooa0yT/JSvx/wx8j0cnC31XZ2I8=; b=a0onOcRXFp3V29gf+MYEoSfe0Cib
        lorGf/2n6NTGIlV1eF9hhTyIBEOmaAuwc80d71qi6oHozw94rBFWzhA41/RmfLdH
        GJeIxpg+NIF+olAEah4U6/qPSqwu5V1FF/vvhnmvvdz0skjQFLciZLALU0Cj9aBa
        0180aLtuLECFnZw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3CECDFDC8;
        Wed,  7 Jul 2021 20:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CCF02DFDC7;
        Wed,  7 Jul 2021 20:18:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Jul 2021, #01; Tue, 6)
References: <xmqqim1mgbty.fsf@gitster.g>
        <fc5ec100-1d42-4199-236e-7a99c9218f38@gmail.com>
Date:   Wed, 07 Jul 2021 17:18:00 -0700
In-Reply-To: <fc5ec100-1d42-4199-236e-7a99c9218f38@gmail.com> (Philippe
        Blain's message of "Wed, 7 Jul 2021 19:08:37 -0400")
Message-ID: <xmqqeec9d5fr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4F7ABA0-DF81-11EB-9CA9-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2021-07-06 =C3=A0 21:19, Junio C Hamano a =C3=A9crit=C2=A0:
>
>> * bc/inactive-submodules (2021-07-02) 1 commit
>>   - submodule: mark submodules with update=3Dnone as inactive
>>   Usability update for inactive submodules.
>
> nit: "for 'update=3Dnone' submodules" would be more accurate;
> we do mark those as inactive but inactive is a different
> concept than update=3Dnone.
>
>>   Will merge to 'next'.
>>=20
>
> I'm finishing up a review of brian's v2, so maybe we could keep
> that one in seen a little longer?

Thanks, will do.
