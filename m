Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40067C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FC2652AB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCHR4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:56:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54112 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCHR4U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 12:56:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3199D135D61;
        Mon,  8 Mar 2021 12:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=m8bzkTz5yOW0
        SuubVBMfEJ50rBM=; b=oUGG7u+S6GOvPVT76dI1vhh5ZuqzrSYL7gr9ZQ7v0Ig9
        aat9ZSQuHH4+jjgiixAYU06rjO+lIInu71vqCRqQI/rNnJm3eiBj0dPtZOU0KYQ9
        cF7Gi01kZz0nnOUAkWn6lZS3p0hXLksWZ6D49V3wz4wkNjialVU2zRdhvE+ZRTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oTI5dR
        HbeONOk1c27eaRSA6bxDODFPE51vLNKGYas+jbsgzQJFs1uCfFcxInLPPovN1G8t
        gRXS8eNl3g/Fk6jj7JER0kLknSk0Ff+QBeOj4V9e3UFIKIoNTl4lVTjfobldFtRE
        fmtJTmthMVXixCi7HA/i9A2yxa/KkeuuGLCPk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A7E7135D60;
        Mon,  8 Mar 2021 12:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 77515135D5F;
        Mon,  8 Mar 2021 12:56:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramkumar Ramachandra <r@artagnon.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] [.mailmap] Add entry for Ramkumar Ramachandra
References: <20210306152814.8687-1-r@artagnon.com>
        <20210306154515.10575-1-r@artagnon.com>
Date:   Mon, 08 Mar 2021 09:56:15 -0800
In-Reply-To: <20210306154515.10575-1-r@artagnon.com> (Ramkumar Ramachandra's
        message of "Sat, 6 Mar 2021 16:45:15 +0100")
Message-ID: <xmqqa6rd7cn4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94ECBECA-8037-11EB-B9C4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramkumar Ramachandra <r@artagnon.com> writes:

> Signed-off-by: Ramkumar Ramachandra <r@artagnon.com>
> ---

This is 100% the other way around since the initial round; I take
that you want to be known with the address the patch was sent from
so I'll take this version ;-)

Nice to hear from an old friend of the list; it's been quite a
while.

Will queue.

>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index bde7aba756..9c6a446bdf 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -220,6 +220,7 @@ Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
>  Philippe Bruhat <book@cpan.org>
>  Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
>  Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk=
>
> +Ramkumar Ramachandra <r@artagnon.com> <artagnon@gmail.com>
>  Randall S. Becker <randall.becker@nexbridge.ca> <rsbecker@nexbridge.co=
m>
>  Ren=C3=A9 Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
>  Ren=C3=A9 Scharfe <l.s.r@web.de> Rene Scharfe
