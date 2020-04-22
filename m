Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13E8C2BA19
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA262072D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ff72sg1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDVBKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:10:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37492 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgDVBKT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 21:10:19 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 61C4B6088E;
        Wed, 22 Apr 2020 01:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1587517788;
        bh=XxjnQiZGVFLyV7jiHyR99n3GQQjIpQaF6SZB5ZrK3Kk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ff72sg1uBhHeSxg8J5l+DwMUFJ+1/HSlu69fxOritpXQvHoC5rpbeHse8R3xxMiAc
         bEtE9rdMko5ebQymIJlKUx6BjAm3WUI3/EAuOsHk4c5a14dA40C89HzPnfMOUdLpHc
         +ZKJg6g3qINxq2rKrd23mnARVKflPlCcKDH4h/LAgyX7gRpgEVmv2ZRDWPh58E0TVv
         4n/ivtS9nOtgEerZL9r6t8KtlhtK9y2dgpnshr+0o0rny1sxAu+euWzSoI7f2z4Vul
         dqJfTG4juvHHW86oyAiLqa6VZhWvKrkbKlAZYD5WT187f9ef/J2PU/bbL8nZ0/9f8t
         SQaI6o0c0eWC51iDDzTPE7YWqA0Mbmaeyd73Tfuc0tdOpJ3XRdKI7C5ntmfRGBlaRQ
         3evAWJ7n6ZlqUGazYmHhy3eVGwzQPrFSGkUq4sApoTqiN7+Zi6e1dgsfLfAO1fvQdp
         RJrorZa1wtRTAyxtqT6/4cVlJWZNQxK2gB0vflnNcsxgvJq1tmU
Date:   Wed, 22 Apr 2020 01:09:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
Message-ID: <20200422010943.GD6465@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
 <20200421225837.GB3515235@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20200421225837.GB3515235@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.5.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-21 at 22:58:37, Jeff King wrote:
> On Wed, Apr 22, 2020 at 01:31:46AM +0300, Ilya Tretyakov wrote:
>=20
> > Credential helpers are no longer invoked in case of having sub-folder
> > parts in a repository URL.
> >=20
> > For example, if we have a "/my-proj/" part in the repository URL.
> > The following configuration doesn't invoke a credential helper script
> > in 2.26.1 version of Git but invokes in 2.24.1.2.
> >=20
> > [credential "https://git.exaple.com/my-proj/my-repo.git"]
> >     helper =3D !'/c/some-path/bash-git-credential-helper/git-cred.sh'
> > provide  repo_b
>=20
> This is unrelated to the recent helper fixes in v2.26.x. Here's a simple
> reproduction:
>=20
>   url=3Dhttps://git.example.com/my-proj/my-repo.git
>   echo url=3D$url |
>   GIT_TERMINAL_PROMPT=3D0 \
>   ./git \
>     -c credential.helper=3D \
>     -c credential.$url.helper=3D'!echo username=3Dfoo; echo password=3Dba=
r;:' \
>     credential fill
>=20
> which should print a filled credential (with "foo/bar"), but will fail
> with recent versions. It bisects to brian's 46fd7b3900 (credential:
> allow wildcard patterns when matching config, 2020-02-20).

Yeah, I can reproduce this.  It looks like what's happening is that
we're percent-encoding the slash in the paths as %2f, which of course
isn't going to match in the urlmatch code.  We probably need to tell the
percent encoding function not to encode slashes in this case.

I'm testing a patch now and hope to have it on the list a little later
this evening.  Thanks for reporting and bisecting, and sorry for the
breakage.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXp+ZVwAKCRB8DEliiIei
gbMPAP9LB4XZxiFc6CMzQd9CIm4tuFESpe3ftd+pXQQRXAK4mwD+IHIZnJZHj6V3
Ek6cydIy9HNfd3HS0nwk70lBrBp/sgs=
=mYzm
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
