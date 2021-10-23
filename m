Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB405C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 06:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B060F5D
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 06:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJWGX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 02:23:27 -0400
Received: from mout01.posteo.de ([185.67.36.65]:36583 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhJWGX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 02:23:27 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 641CA240027
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 08:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1634970067; bh=r8gsmzGAopfwQ7K6r7XAMIKQyL2iAkgmPcVXyBH3H1E=;
        h=From:Subject:Date:Cc:To:From;
        b=ryM7vkpx87MbCAFgpRytTzRb6KV7OP7AsgoQwOgp+xxOj8FXsNiMZMd2a49fesOeG
         Go1ZJj5lAVFtMuFZhrrJn/DNERBd9oXLBzbuoRwCKKVqaGPx7CsE7cLhmxs8GGLn2a
         LgFCWhSF2Ez4ZNFt40uHKwV6wakXsaoQVwhz1I4aOK7eBvSzXQmaboywo7IVoF2tHD
         BPvZcAFrk9xutuq5OeBvZsyvqe+NsDwuR0k+aUMJ2iAgdpCqADK/XeB/yODuPuWd4S
         +26148HqcDKfKyW/+GWybSqaWvh5tJHS7KpzJujhDIQ/27AWkY5wCx8mtFpZ0UdeHp
         abEH3bDw1celw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Hbrh306XJz9rxM;
        Sat, 23 Oct 2021 08:21:06 +0200 (CEST)
From:   "Schanzenbach, Martin" <mschanzenbach@posteo.de>
Message-Id: <F36A97CE-2245-4EF8-B63D-B917166308D8@posteo.de>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2B0E2827-215F-4AFD-A2E5-E73AEBAEFBAA";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: git log displaying wrong account information
Date:   Sat, 23 Oct 2021 06:21:05 +0000
In-Reply-To: <YXOopkKXrluffiuX@danh.dev>
Cc:     git@vger.kernel.org
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <9826C830-3680-4AC4-9ADB-5FA45222A15B@posteo.de>
 <YXOopkKXrluffiuX@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_2B0E2827-215F-4AFD-A2E5-E73AEBAEFBAA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks! I did not know about that file.

> On 23. Oct 2021, at 08:16, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh =
<congdanhqx@gmail.com> wrote:
>=20
> On 2021-10-23 05:58:37+0000, "Schanzenbach, Martin" =
<mschanzenbach@posteo.de> wrote:
>> Hello,
>>=20
>> there is some odd behaviour in "git log" which affects me in various =
ways:
>> For some reason, it "canonicalizes" the author/commiter information =
in our repository: https://git.gnunet.org/git/gnunet.git
>> 5 years ago or so I was using another email address for commits. I =
have been using a different email address since that.
>>=20
>> But if you clone this repo, and take a look at a recent commit such
>> as be9b998b3369056c7c8fb0ae84fb4e2a064b496c using "git log", you
>> will see that my email address is actually the old one and different
>> from the _real_ information.
>=20
> By old one, do you mean:
>=20
> 	Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de>
>=20
> It's because you have those entries in .mailmap:
>=20
> ---- 8< ----
> Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de> =
Schanzenbach, Martin <martin.schanzenbach@aisec.fraunhofer.de>
> Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de> =
Schanzenbach, Martin <mschanzenbach@posteo.de>
> Martin Schanzenbach <martin.schanzenbach@aisec.fraunhofer.de> Martin =
Schanzenbach <mschanzenbach@posteo.de>
> ---- >8 -----
>=20
> Which will map your:
>=20
> 	Martin Schanzenbach <mschanzenbach@posteo.de>
>=20
> into it.
>=20
>=20
>> You can see that I correctly set the author/commiter email here
>> using either cgit
>> =
(https://git.gnunet.org/gnunet.git/commit/?id=3Dbe9b998b3369056c7c8fb0ae84=
fb4e2a064b496c)
>> or a specific format such as
>>=20
>> $ git log --pretty=3Dformat:"[%h] %cd - Committer: %cn (%ce), Author: =
%an (%ae)
>>=20
>> This is driving me crazy as the information is just plain wrong and
>> when our CI tries to collect a blamelist when sending out
>> notifications, it also uses the info from "git log" instead of the
>> actual author/commiter emails, promptly sending the reports to the
>> wrong account.
>=20
> The original value is recorded in the commit. You can retrieve raw
> value with git-cat-file
>=20
>>=20
>> Any idea what to do?
>=20
> Change your mailmap entries to:
>=20
> ---- 8< ---
> Martin Schanzenbach <mschanzenbach@posteo.de> Schanzenbach, Martin =
<martin.schanzenbach@aisec.fraunhofer.de>
> Martin Schanzenbach <mschanzenbach@posteo.de> Schanzenbach, Martin =
<mschanzenbach@posteo.de>
> Martin Schanzenbach <mschanzenbach@posteo.de> Martin Schanzenbach =
<martin.schanzenbach@aisec.fraunhofer.de>
> ---- >8 ----
>=20
>=20
>> I really do not want to rebase and rewrite
>> thousands of commits with questionable success.
>> Doing that locally also does not change the output from "git log", in =
case you are wondering.
>> This problem will reemerge eventually whenever an author wants to
>> change to another email address it seems so is this a bug?
>>=20
>> Any help/pointers appreciated.
>>=20
>> Martin
>=20
>=20
>=20
> --
> Danh


--Apple-Mail=_2B0E2827-215F-4AFD-A2E5-E73AEBAEFBAA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPREGPBD5jRS9JNFHCwmY74b1m2oFAmFzqdEACgkQCwmY74b1
m2pKXQ/+OzyTHJVJ2eVHhmcizykFvo/gC27PVDA+VqudMynkjj9sm6+TIN9qrIby
ZuxNtPKptgil068LuI45T6rfz86By2/ni2ZuW9Sk8+XYhrrI+Opb3LhxFTWwg0HD
VpDJ2CPOjkf1fjSVsRAYsr12cC7aBskfOmVKItz5qrs3SxszcEtvelzWU7d6MxLl
T3BcJB4U26unqPBwuvzHO+J4bPR3/igc3BVfxOy7IjVebjhscO+nOVJ9gs82KjzW
YRXC8UQ+0vSMvTb8wVY69geWhxL7d7ZCwHRm8SvaUbss7qTmcc21mew7Iq6F7RwX
Ilh+KaYBIJcj5njk1nL51FWJ0fZe9K4MKaU4213qm8koDnTdtzFJfbmq84kIWtK+
nS/VyO1p4fSYgyRC1570mLXQOahHmTs8pN1kZX/zBy1e+VqCBUdeXLSE/JG7jLYi
rf3fcWHMgI5y+Nh50syl9h5nfv4eO+l+P8rhhpXe/HzRveIQVRejEVMbZdpL4+gk
ITD9MScVRUNOfsLMlAkJXi5AtUkb5iIZ4ncA7HVCU8XZG0pphULA47LL3vIvXVNW
Kq1LfBHlewrYenOTJpfUUPKA1QPxVbINJtOmYpG+DRq4KhQM+sBo/k/Gq/bBB13x
XrQ0m8l1YLPdlrcwR0Y3Pe138mOz96rFYOD7iOK3PSI+erUddqg=
=v3BW
-----END PGP SIGNATURE-----

--Apple-Mail=_2B0E2827-215F-4AFD-A2E5-E73AEBAEFBAA--
