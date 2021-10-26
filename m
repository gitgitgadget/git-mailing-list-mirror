Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53956C433FE
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB3360FE8
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 20:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbhJZUIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 16:08:54 -0400
Received: from mail.archlinux.org ([95.216.189.61]:56270 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbhJZUIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 16:08:53 -0400
Message-ID: <5e2233d8-f63c-d786-ee9f-31865d6c208c@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635278787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3XoPqOx1werSEjx0NKJAeFFtfFnYzyEzgysRFKJjuE=;
        b=XBX0kMdELHb0Cxq6eVpUmQ3AVcodno2EeJPrFRdF/zqjqr1xN5D00AX4bSYELvpt1SWl4p
        Vdgqaj51zaUZMMAU4JX9ibQN2Avr+pBJfnZxGZWyS/84nbXgFKxaBpsBBG8b1qpLffuKK0
        e1mX3DxhEMNitRhfhxF1qodCsZ5bxYq/P+ONz4ZnzXbi+B82x8lcGAbw5IrhUP+2GER+Gt
        zZByXgvvPMs/DpIwrr0MaANIObKQcI/P4IvqoHXJZ2Y8TM0HyBNDpxqZElVrW6nCPEntge
        IP2WERiWKkDTRL0ZY/6VeQylF1UY1DnByBGAWn5Q/ek51Ldve3jmdLyPUoMxAf+ErcmtIG
        NDAYYwlefgyMAoaJ7UM+zGCAc3+zrJasM/Q42nc7BcK+0CrP6r358UkjlHJQV5P+lp4SVG
        KLlITuy6shaLac4xi5Q7EOy2HhAKBbwb8ysGOhhoLZdollupS0TCHNvEGjyUErileACW/u
        Bw0mPtFvlgLur6xMlfu7WiDM2OOCxSy9OMcAnz9k+/XC9Sq02qlv+DExpDNw1xIMaPmt7u
        iwd4TCcTFyxuB1Mambnp9CxXDVl6t7tsAzZuwlPM2pKX3ZjHQkKStGDC7mgF5UZYj9L9tC
        Gfq7RakSrepHHRBRankSAuNVf9SsodOi4TF0jKd5yC2DtZ9fgB99A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635278787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g3XoPqOx1werSEjx0NKJAeFFtfFnYzyEzgysRFKJjuE=;
        b=eNmB1Wi+MkG95Z5/h89mFrzQCF52lmPpHZ5JYz9cYmsVX3mo9iAPiH3bhx8N2tJqEzOoG3
        Y0Y8wW/drJCzdYAA==
Date:   Tue, 26 Oct 2021 16:06:25 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] pretty: add tag option to %(describe)
Content-Language: en-US-large
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-3-eschwartz@archlinux.org>
 <CAPig+cTe9iMCteUYZZP_8cYoOzbg-95ptuVdvvk0SKUGMgrDjg@mail.gmail.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <CAPig+cTe9iMCteUYZZP_8cYoOzbg-95ptuVdvvk0SKUGMgrDjg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5xrYU6Mv6p9FRpv0L2r1qY21"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5xrYU6Mv6p9FRpv0L2r1qY21
Content-Type: multipart/mixed; boundary="------------9j2FtEfPdnFy3Q4hWWFhWwgS";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git List <git@vger.kernel.org>
Message-ID: <5e2233d8-f63c-d786-ee9f-31865d6c208c@archlinux.org>
Subject: Re: [PATCH v2 2/3] pretty: add tag option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-3-eschwartz@archlinux.org>
 <CAPig+cTe9iMCteUYZZP_8cYoOzbg-95ptuVdvvk0SKUGMgrDjg@mail.gmail.com>
In-Reply-To: <CAPig+cTe9iMCteUYZZP_8cYoOzbg-95ptuVdvvk0SKUGMgrDjg@mail.gmail.com>

--------------9j2FtEfPdnFy3Q4hWWFhWwgS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/26/21 1:25 AM, Eric Sunshine wrote:
> On Mon, Oct 25, 2021 at 9:36 PM Eli Schwartz <eschwartz@archlinux.org> =
wrote:
>> The %(describe) placeholder by default, like `git describe`, only
>> supports annotated tags. However, some people do use lightweight tags
>> for releases, and would like to describe those anyway. The command lin=
e
>> tool has an option to support this.
>>
>> Teach the placeholder to support this as well.
>>
>> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
>> ---
>> diff --git a/pretty.c b/pretty.c
>> @@ -1229,10 +1230,21 @@ static size_t parse_describe_args(const char *=
start, struct strvec *args)
>>                 for (i =3D 0; !found && i < ARRAY_SIZE(option); i++) {=

>>                         switch(option[i].type) {
>> +                       case OPT_BOOL:
>> +                               if(match_placeholder_bool_arg(arg, opt=
ion[i].name, &arg, &optval)) {
>=20
> Style nit: add space after `if`


Oops, I am not sure how this happened. It's wrong in the switch too.


>> +                                       if (optval) {
>> +                                               strvec_pushf(args, "--=
%s", option[i].name);
>> +                                       } else {
>> +                                               strvec_pushf(args, "--=
no-%s", option[i].name);
>> +                                       }
>=20
> We would normally omit the braces for this simple `if`:
>=20
>     if (optval)
>         strvec_pushf(...);
>     else
>         strvec_pushf(...);
>=20
> ... or maybe even use the ternary operator:
>=20
>     strvec_pushf(args, "--%s%s", optval ? "" : "no-", option[i].name);
>=20
> but it's highly subjective whether or not that's more readable.


Although the braces feel more natural to me for clarity purposes, it's a
good point that the git coding style says to omit them for single
statements, and I should have followed that here.

The ternary doesn't feel readable to me, however.

=2E..

Thanks for the style review!

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------9j2FtEfPdnFy3Q4hWWFhWwgS--

--------------5xrYU6Mv6p9FRpv0L2r1qY21
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF4X8EACgkQzrFn77Vy
K9YNsw/+KHV0Dxf8YAw6lT0UupR1PKLPAMrElBFWHjdsAuGxHfJ5V431UaxKW2Q4
uNUNYbxFNSLSTnjHJ7x/ILewufGyEmEArfOLXNnOzs8Owbto8PBN7MwEIyp2ZaLP
Hb5c7RwbIn2bngS4QeFl/b3pizZjUzheO2ZUVw3LSyOHThcfBVrXsXhMRbchVeqo
WRFjpJiVzffCYxl2bKaovjiePFfxIvYMyyHMfW7ARQ4bw7A/10cJ7MTZVG7y8VmL
Ml8hYEzjnJ2S/ApaEYBzo3375iqP4TDEq99kd2C39AX5P0L6yaJTQqD94w904DJh
eX/3609ZVmB5e0YKMr/rV98lKoTQNJfW5vmZTtC2zUkvQBrIvKX5aizXQ1OXDyqC
wCE7W8K6EbZXhQr9gH5vEhDlyQTpb6Awzedh5ZrFUYDg3dkKXsFeS4hFDucDM7KH
LxOwLYk8ImeBPzOBfB+ntFLwCk6LMlTfY49ImfkMrqOCSWCVQRQ+RQYMTqCr1vme
7hut9e5bBvrIhbv/wUf88I+e2mr7ltz3KuKKBjSGIiGmJxRXrwOyHE4GTp7XJVmn
YLHZ7pLcYTQRyXEOBbpG1NNM5tDaUo7DfO3OrxFkULe5FSxT4/w/gertFL+iiY7j
WFH8YauTigC8txX1ehlXq/ltfYyrj0WGsj9hO6s70uzCw8hKK/A=
=r5Fp
-----END PGP SIGNATURE-----

--------------5xrYU6Mv6p9FRpv0L2r1qY21--
