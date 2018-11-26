Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30CFD1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeKZRiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:38:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59377 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZRiL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:38:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7A1D11291D;
        Mon, 26 Nov 2018 01:45:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z/xg17UdeKCP
        ROz/xKWvxy7hOG8=; b=jpmbUfVv5lQBF16GIBJcLTneSk0gXh8ty1dKhp2ZGG9o
        KDewLQUwTPyu0XzcZKV35oMbH8xXAJwsuJ8gD9vZt14H/NtJCX05XujPWAv34fQ7
        WIptJwzN4BIicGtpBa6HdXFV39Wmgo66Q1iHrByqCqxLVyh5qZEA8jNwk7pQ80I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qWRRVV
        5fJsZ29VaL+BJKst/AA+CagAoTIFEeC7mGUj554ojkvafIyeIg5kDI6xXvlR3Zs4
        DEZXconzGclIFY/TRYwce+Zkf64tsNyKUhTsG2M03jOJMYoJs4IiDqku2sDQ0U1E
        qvWxNb3IbGGOIm6uZ+79GHlkj9GtbUWo2xii4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF20211291C;
        Mon, 26 Nov 2018 01:45:03 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCC82112914;
        Mon, 26 Nov 2018 01:45:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] config.mak.uname: NetBSD uses old iconv interface
References: <cover.1543143503.git.carenas@gmail.com>
        <5841455b55d7e14f962659ce3bf36c1f04162268.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:45:01 +0900
In-Reply-To: <5841455b55d7e14f962659ce3bf36c1f04162268.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:47
        -0800")
Message-ID: <xmqqh8g4xrpu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD3946E0-F146-11E8-9C94-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> prevents the following warning :

s/^/Doing so / or something to make it a complete sentence.

> ...
> it is set by optional configure at least since NetBSD 6.0

s/it/It/;


Again, makes sense, and thanks for tying this loose end.

> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 36c973c7e6..59ce03819b 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -246,6 +246,7 @@ ifeq ($(uname_S),NetBSD)
>  	ifeq ($(shell expr "$(uname_R)" : '[01]\.'),2)
>  		NEEDS_LIBICONV =3D YesPlease
>  	endif
> +	OLD_ICONV =3D UnfortunatelyYes
>  	BASIC_CFLAGS +=3D -I/usr/pkg/include
>  	BASIC_LDFLAGS +=3D -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
>  	USE_ST_TIMESPEC =3D YesPlease
