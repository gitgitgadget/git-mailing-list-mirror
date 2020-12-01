Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C560C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E302085B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 21:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xb+Si5b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgLAVcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 16:32:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52454 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLAVcU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 16:32:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CDE6A0F00;
        Tue,  1 Dec 2020 16:31:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cOhBuR12Se4l
        kbfsAxhedWriRbA=; b=Xb+Si5b63at+8v2saDASwYEBIsPe7uFgOflfKaO3C6u/
        +yF3ij/WUQi3rCPFZJAtpU2M+wmDVxraBlRm6MQ6CtwCCjldc/2snijxL64BZRYT
        vdwcsJJlMev+54PJHk7Pl4OymNL/lkoNeywzhEm6d+5tn2LqpeOlsphMeiFhF3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qwJ6xM
        2NGSvRs12q2VFGKCjRllRlAgHxF3zKzGoBUoGjWVbupgRiFkOwyaYhq6X+33wnWv
        Bf9gZlsNTovQNPlFFYYPDkOVwE3sCDY+uj3Eci0YiSthKjcC79qAqn5W6koQsPWq
        /CRAgwStVvJhJXT3QUXUNkCnI0Qt5zWhGaoCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 253D0A0EFF;
        Tue,  1 Dec 2020 16:31:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CEE7A0EFB;
        Tue,  1 Dec 2020 16:31:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.txt: fix a typo (backslash != backquote)
References: <20201201121051.186050-1-stepnem@gmail.com>
Date:   Tue, 01 Dec 2020 13:31:35 -0800
In-Reply-To: <20201201121051.186050-1-stepnem@gmail.com> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Tue, 1 Dec 2020 13:10:51 +0100")
Message-ID: <xmqq4kl5nrgo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96FFBFEE-341C-11EB-975B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:

> Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
> ---
>  Documentation/config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for spotting an ancient typo that is more than 5 years old.

>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bf706b950e..9700f6ebf9 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -64,7 +64,7 @@ The variable names are case-insensitive, allow only a=
lphanumeric characters
>  and `-`, and must start with an alphabetic character.
> =20
>  A line that defines a value can be continued to the next line by
> -ending it with a `\`; the backquote and the end-of-line are
> +ending it with a `\`; the backslash and the end-of-line are
>  stripped.  Leading whitespaces after 'name =3D', the remainder of the
>  line after the first comment character '#' or ';', and trailing
>  whitespaces of the line are discarded unless they are enclosed in
