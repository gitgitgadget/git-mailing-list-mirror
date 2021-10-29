Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F328EC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9D760FC0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJ2VrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:47:01 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56304 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJ2Vq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:46:58 -0400
Message-ID: <ab609944-d4ec-cf50-1a2f-c0e159a541d5@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635543867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKNKEEUSkoUvXdS+wxoSWpv7qg/XBU4D3HgVF5juNr0=;
        b=ik4tFaaxnR/5WATTihiiC6UXTBrfVupkq5Cu2ek5RYuaUMStsC6Gig2ZGFv2VMjrTAQkiW
        RuF5PH2wGxR9cPiWF6JeiAFZhNgDYW40oZNj3Vb/2RClRsSyioMMKi6H6GodW0h7xUNYdO
        Bt8oSGo/6egjQ35XaBz7F9OzDrg3LpigCEuOtsYm3XDnbKvINHPSc7F4pP55/kwRUfzPH4
        AUvljskaZ/naw88JdsMciKJ2citPgrqSXL8xvjRzfCw/XN1ez2A1vUPmG76UbFGi2zWHzF
        bIkXCXyGLiaXWMJlzkMnatNS9k1y5QdAtJoHD5e7qBBWZMxXqN/EYgwCiwyRDjUw47KXZ8
        y3F9Tz7f612o13myeyM/omUXbLmtyxXtaOx9AnCo0Gjbeh38g2Eq9M/X5rWoKcKkbE/qrU
        u42JnqMNAN9oiYrB6ulMFsyh2WYEkq0RE8OD0YltzLr5P9rolwsd5xXiM0gMF1iwznfSkr
        ncGjFiG3P03Eck22yZwyUN+0IcwcV47COy2JRVSu6SkbS5+rfMnnnzOnRTMI9OIfF0jjBc
        uHAUdwi1i6DKBpPxGu8LZEnKU3W9xzshEZ+01KZrPtjvAGXF2Cj+/TFWD2MnzJmXtJRems
        9kuWhSQu7pyGgPHTjJOe1/gCNHi2ptzwC4e9YAiyanHg+Gd3BivTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635543867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qKNKEEUSkoUvXdS+wxoSWpv7qg/XBU4D3HgVF5juNr0=;
        b=JnDefBtU+55makQqss9mgb6viT9Pf1q6onKNyn0Z7jpO0isAUj59k9KrgzPnnqWSzFUPnc
        U4PGTQVplr1HNZBg==
Date:   Fri, 29 Oct 2021 17:44:23 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-3-eschwartz@archlinux.org>
 <xmqqy26bk2k9.fsf@gitster.g> <xmqq7ddvjzbs.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqq7ddvjzbs.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OPhmDsSOWFHHwYRloC3AUozg"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OPhmDsSOWFHHwYRloC3AUozg
Content-Type: multipart/mixed; boundary="------------nXW3B04FF9VfHA0V1410jceJ";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <ab609944-d4ec-cf50-1a2f-c0e159a541d5@archlinux.org>
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-3-eschwartz@archlinux.org>
 <xmqqy26bk2k9.fsf@gitster.g> <xmqq7ddvjzbs.fsf@gitster.g>
In-Reply-To: <xmqq7ddvjzbs.fsf@gitster.g>

--------------nXW3B04FF9VfHA0V1410jceJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/29/21 5:28 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Eli Schwartz <eschwartz@archlinux.org> writes:
>>
>>>  +
>>> +** 'tags[=3D<BOOL>]': Instead of only considering annotated tags,
>>> +   consider lightweight tags as well.
>>
>> This part contradicts what Jean-No=C3=ABl's df34a41f is trying to
>> achieve, which can be seen in these hunks from it:
>> ...
>> So, let's instead use
>>
>>     tags[=3D<bool-value>]: Instead of only considering ...
>>
>> i.e. lowercase, with -value suffix.
>=20
> The other topic merges earlier to 'seen' before your topic, and FYI,
> the diff between the tip of 'seen' before and after your topic gets
> merged looks like this, with my semantic conflict resolution.
>=20
> Notice the way placeholders are spelled in lowercase and generally
> have more descriptive names.
>=20
> Thanks.
>=20
> diff --git c/Documentation/pretty-formats.txt w/Documentation/pretty-fo=
rmats.txt
> index d465cd59dd..25cfffab38 100644
> --- c/Documentation/pretty-formats.txt
> +++ w/Documentation/pretty-formats.txt
> @@ -220,6 +220,12 @@ The placeholders are:
>  			  inconsistent when tags are added or removed at
>  			  the same time.
>  +
> +** 'tags[=3D<bool-value>]': Instead of only considering annotated tags=
,
> +   consider lightweight tags as well.
> +** 'abbrev=3D<number>': Instead of using the default number of hexadec=
imal digits


As a matter of curiosity, why "bool-value" but not "number-value"?

Isn't the "value" part implicit?


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------nXW3B04FF9VfHA0V1410jceJ--

--------------OPhmDsSOWFHHwYRloC3AUozg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF8azgACgkQzrFn77Vy
K9YyhQ/+PPAyaG3ETRkXSsNVHJ/UBwveEilKQEQ705OTmLo/i0zzqiTL0B3YDjEb
Fn0SE9ympKBDrsyYb7fOpzKpkTBAIpgZ0BHqKFGMCdTGvN6tOeW0shqjDAuq0FVI
uhNuldbg7ofBMrRq34e9cbI5nj4eD4ZyfG1rQgLeMIJuTcncgTZEtAamDCC5hP0+
Ur8cd4e/lrQjsv7XsKrUTJr6C8P0Vyx+kkoIuvWDCCMNVSEq0zS0wiBJEmm2t+Yv
iL4qUNy2AOBIVZk/LtoxvT8vP7wuHU4NneKFoWnbksBZxdKOL0pf6N2Z1yzm78JK
w+zfXXAXaeyACqfWwvHtXZu3GrRJJfPehnBOrLqPVrmZEk8RYhlpLvVOVv/MShS9
3MphS5SLWO//sB2zXkyq5NGHbrpcY1V5PewN/DDaN/Pjlb6UzX0Fzyc33f17rr+h
PDLj0NAGhXYjO0cZ21NGTYM/Z8UL4XdPSoqaDa/nb1IHwzdAWPGLiGpOEyu3PuEZ
D6G3AtumqKmWv5GTLFRxLw69+IY0k4Ov9XA8aLVTje03xn1nPc1FOdfCYeekCTHN
nEEZ1K3G9XMPbwI2TOvEJzn0fVqYpwpMYJTPzsZVsiYTfRKFXMQ50Jd1GCMg6N17
dmoYlhpNG++XaPsRGoJ9CwfTKrnhWio2TuRTnqgeGkT+sOlHTb8=
=/aEg
-----END PGP SIGNATURE-----

--------------OPhmDsSOWFHHwYRloC3AUozg--
