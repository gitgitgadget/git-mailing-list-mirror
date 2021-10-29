Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43681C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A6F60E8C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2VQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhJ2VQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:16:49 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1071C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:14:20 -0700 (PDT)
Message-ID: <3cf891ea-58c8-b7d5-0b6e-eb23dff92bd5@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635542058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BokRsTBQZrAay8B15O1pCWf5x5esyNIaPo5BVRfwP7s=;
        b=tgpVydTisiVRldq790q4gEpI0NgQ0aHP6NEsS2PBoxmnpzL7tWnmUuMJK0isHJDe8FD1xx
        s1sSXBRJdbzwZqCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635542058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BokRsTBQZrAay8B15O1pCWf5x5esyNIaPo5BVRfwP7s=;
        b=Tvv1fjKZonffIaQtZ4+Bx7iIMYZyqQyCKRhPq6EJiAQC9Bcl6TgtLztq8MHlBbhgqUxyJP
        DawLskImE46wvrB6spbJ0T6ORg1wL2wLmx3KxJYeJlT0ZALJd4cSHF8QPDZxlu0mdlxhKY
        AbmP8bF+ixLjF7blZ86gq+Kxfs43IH0KQ9u1jzw42wXh1R0MRJfipDmbyCpOwiGy9rvGh6
        Y2gcWbZjVPtNcVUhrXAT+wIUgKTKjvNnp2q6HDLV7YzMIqwG95ZFmQREi5OM2fRFBjw8F9
        Vexo5/xyxGbdsYkcvd3SP+r5dgd8+lmjQAGdW/opniZAIrqKtPTGZAMY8WnVXJqxFQJ+/U
        /jfDZhPFw0+cTCkCO5c0GKPiCFvC7T0t2/wXZ2dxUyuD488DW7YrSETfM2sJio3aI75wdI
        kHTSE5DhrWQJkDnb8ZzRcoBSt7Fa5KV1h9m6c1NPF1gMf5imLq09hToVhL4Bdeacfgy8Ef
        b0Tqb4bcepmfKY31/9xCBWOjwiYt/Lh1f8vKqbtGlPsiIu1mUjt4SYf9cbIVMANzB8pXj1
        kp8Jj8WLhNf6PuHxglF+HthMMh+a78RcxDzqCzn6gj2jZd+kfLGQZKVTIrrxNLQVlvUCUc
        pv1FIPVxNNW83uciUkRsrVFk2JN4scJ0Yr4cVoRYgbBDDQqzISTak=
Date:   Fri, 29 Oct 2021 17:14:15 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-3-eschwartz@archlinux.org>
 <xmqqy26bk2k9.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqqy26bk2k9.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UyQ6gQVaYQRerK57zc4LgM8g"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UyQ6gQVaYQRerK57zc4LgM8g
Content-Type: multipart/mixed; boundary="------------0LN0UsxZdpYCTgBwFGXJ0utX";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <3cf891ea-58c8-b7d5-0b6e-eb23dff92bd5@archlinux.org>
Subject: Re: [PATCH v3 2/3] pretty: add tag option to %(describe)
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-3-eschwartz@archlinux.org>
 <xmqqy26bk2k9.fsf@gitster.g>
In-Reply-To: <xmqqy26bk2k9.fsf@gitster.g>

--------------0LN0UsxZdpYCTgBwFGXJ0utX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/29/21 4:18 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>=20
>>  +
>> +** 'tags[=3D<BOOL>]': Instead of only considering annotated tags,
>> +   consider lightweight tags as well.
>=20
> This part contradicts what Jean-No=C3=ABl's df34a41f is trying to
> achieve, which can be seen in these hunks from it:
>
> [...]
>=20
> So, let's instead use
>=20
>     tags[=3D<bool-value>]: Instead of only considering ...
>=20
> i.e. lowercase, with -value suffix.


An interesting change. I can use that description style, sure. Though I
will note the commit message for it talks a lot about replacing spaces
with hyphens, and very little about consolidating on case *or* using
different language such as:


-* 'format:<string>'
+* 'format:<format-string>'


I also assume that it's fine for my patches to be inconsistent with the
base commit, as it's expected df34a41f or some revision of it will be
merged around the same time?


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------0LN0UsxZdpYCTgBwFGXJ0utX--

--------------UyQ6gQVaYQRerK57zc4LgM8g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF8ZCgACgkQzrFn77Vy
K9Y8Mg//ZfnvNQsCWEPVrPhOIzAWmxoGihe1Mlku5cnc2Q/wkJAH0Lb7AuNj5bAA
zhfXICP5mW3mMm9pBIzIJS9Vsh6iaInHceceuGL04GqxSal6lNfMFo3ltpvW6k/O
ocw91vKk3qZFebcYVFsgYQFcIDDF6xQbHVEe7Tptc94zCCCFsLnme2N8WQGVXU1X
a0yWQ2EXTEvdm68ustyvWYmgFVjnxFByzC9Cs8b1rtUzCHAgb58ucA2lbzTH3aGl
6RL6x2DHyNlczqEn/i7K2IjK40m8nDO2V+dJAUMNvmc/xPZ2/WZfx0nU+1pjpaZ0
ARd41UcvhBCnG1qok8RgyB40jE2OSjl2g8ZvgNQPnUAMJGbTI+E4bBDj7TZ+ml3q
ove9Cbdbzs3RUUEdLRpZq603O2XG86RyO5ncT6jvxcVbxyY4IBbQOaRnpzSuMv5G
wWtTD1fDgbEMeVfszoIxg8Vw6xQf7M1SqP7VCrBWtBH1yLAYtu0blxvQvwmy2Yl5
PmnD6eNAw+I5OZolpznrvett/0DIo2dpN24AwwkoT6JjRfJhYhVTSu4Qw0OacgQV
JVKgO10Y5BhEUd+y4UXcgSATYjoWksoMb0yO4zkLW7nBiNemQOAAaZmZQRZNzN9s
WotpLn4EEe7y3tX6Iu2eEjYWndigYYE0Gnhm3MdiJw0ATBnEadQ=
=9MWV
-----END PGP SIGNATURE-----

--------------UyQ6gQVaYQRerK57zc4LgM8g--
