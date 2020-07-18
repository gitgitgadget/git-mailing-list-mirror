Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB03C433DF
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8556A207DD
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dZhIjoiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGRUl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:41:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51506 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgGRUl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:41:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED88F6AD97;
        Sat, 18 Jul 2020 16:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lNIRP24KD6IR
        dGZVrMX2lXsYoTo=; b=dZhIjoiqhU7vPeAMT2XIip7PtCStR2H3M82BFFSKkGHx
        t+Oy2J87IrNzh0SjGq/8hZCvmgamXMSJ8PV+R4i1761voz72rN5irG7oBR0Hhkhp
        GcC2KaY9mt+JUDobVtyejbFMBXNHIf2gDKP/EV8I/Di/7J7z17LGlXR8rhJz95k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UwFEjl
        QgYBn3feyrmSHtNoEkrKV9QcPLAXQWOZm5i2i4jrzqkJbaKclYd5eFWz/+qW7Igd
        6YA+SiUMN4Jk+K9+lvybL95JgOyNbVeKvfe+T2ANTAqxc12AENXYBLhi7Zyu8mCR
        Jl5noYRrGqzMlMI2M2SeoayWXDTfDuGHeEjPM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E56C96AD96;
        Sat, 18 Jul 2020 16:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 409186AD95;
        Sat, 18 Jul 2020 16:41:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitworkflows.txt: fix broken subsection underline
References: <20200718201723.10889-1-martin.agren@gmail.com>
Date:   Sat, 18 Jul 2020 13:41:55 -0700
In-Reply-To: <20200718201723.10889-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sat, 18 Jul 2020 22:17:23 +0200")
Message-ID: <xmqq1rl8blnw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1EA5D3E4-C937-11EA-9385-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> AsciiDoctor renders the "~~~~~~~~~" literally. That's not our intention=
:
> it is supposed to indicate a level 2 subsection. In 828197de8f ("docs:
> adjust for the recent rename of `pu` to `seen`", 2020-06-25), the lengt=
h
> of this section header grew by two characters but we didn't adjust the
> number of ~ characters accordingly. AsciiDoc handles this discrepancy o=
k
> and still picks this up as a subsection title, but Asciidoctor is not a=
s
> forgiving.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/gitworkflows.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nicely spotted and this obviously want to be in the final release,
as it comes from 828197de (docs: adjust for the recent rename of
`pu` to `seen`, 2020-06-25), which is a post 2.27 development.

Thanks.

>
> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflow=
s.txt
> index 2db7ba7842..47cf97f9be 100644
> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -292,7 +292,7 @@ described in the previous section.
> =20
> =20
>  Branch management for next and seen after a feature release
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
>  After a feature release, the integration branch 'next' may optionally =
be
>  rewound and rebuilt from the tip of 'master' using the surviving
