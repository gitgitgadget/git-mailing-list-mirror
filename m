Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AAEC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 02:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiA0CbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 21:31:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiA0CbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 21:31:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B54BF17A812;
        Wed, 26 Jan 2022 21:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nYJmqdlVWYBw43ZyqUOOlJVQmcvlIY/332kq5K
        SUPrA=; b=DfKKm91Kp/0dl30hv9fT4zlIx/jaV878JS9nJY6LvVA1G8hLwpk3vu
        rGEtb1YLcwK+cnjVd2JUbjFEqw2DD6d+c5AE4N6EbUVoGv22/q967V/Qqhap/O2c
        lVo0D/oWeB+XHLOXp0JsDnhfca2oQzXNDTW/OAY6qJDhquACLmF7k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADC1817A811;
        Wed, 26 Jan 2022 21:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 27F6D17A810;
        Wed, 26 Jan 2022 21:30:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/config/pgp.txt: add missing apostrophe
References: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
        <20220126121426.53799-1-greg@hurrell.net>
        <20220126121426.53799-3-greg@hurrell.net>
Date:   Wed, 26 Jan 2022 18:30:56 -0800
In-Reply-To: <20220126121426.53799-3-greg@hurrell.net> (Greg Hurrell's message
        of "Wed, 26 Jan 2022 13:14:26 +0100")
Message-ID: <xmqq1r0t6hb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 287C53EA-7F19-11EC-81E3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greg Hurrell <greg@hurrell.net> writes:

> Add an apostrophe to "signatures" to indicate the possessive
> relationship in "the signature's creation".
>
> Signed-off-by: Greg Hurrell <greg@hurrell.net>
> ---
>  Documentation/config/gpg.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  Will queue.

> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index abfabd6d62..86892ada77 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -66,7 +66,7 @@ This way only committers with an already valid key can add or change keys in the
>  +
>  Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
>  valid-before options. Git will mark signatures as valid if the signing key was
> -valid at the time of the signatures creation. This allows users to change a
> +valid at the time of the signature's creation. This allows users to change a
>  signing key without invalidating all previously made signatures.
>  +
>  Using a SSH CA key with the cert-authority option
