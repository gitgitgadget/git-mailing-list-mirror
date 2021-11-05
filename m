Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F20C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D453461244
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhKEPAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:00:20 -0400
Received: from kitenet.net ([66.228.36.95]:50518 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229680AbhKEPAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 11:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1636124246; bh=vOH/vLu1sn3OGk/8q6bNwSGlVrCo6oSzVTW28DDzvb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ks6+u5flK7WI5rWBOWxZMQ7jYgPeJCMwwgTrv1LbJ7hEKjBd8tTHVKgM2ENw92rNx
         D2r1TYpX7MAOsPESl8WVr/3COhVOIkIYaY02EdAVlDt1kAND4Mztk00i4bR/YM1dMD
         pnZrmGpE4csqeQHMNDZ5HGoW5oxXz+g5/dqEHv/U=
X-Question: 42
Date:   Fri, 5 Nov 2021 10:57:26 -0400
From:   Joey Hess <id@joeyh.name>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: surprising value of LARGE_PACKET_MAX
Message-ID: <YYVGVoaJBzMDfyqi@kitenet.net>
References: <YYQtjWSb+z4taphX@kitenet.net>
 <CAHd-oW6q67u=XGCGK=n25Kjph+ceuqPHLxQ0LH=Vydn4xctZ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N1xWPjUN6RwJ6eI/"
Content-Disposition: inline
In-Reply-To: <CAHd-oW6q67u=XGCGK=n25Kjph+ceuqPHLxQ0LH=Vydn4xctZ-A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N1xWPjUN6RwJ6eI/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Matheus Tavares wrote:
> Could it be that you consulted an older version of this file? The
> current [1] version of the doc says:
>=20
> "The maximum length of a pkt-line's data component is 65516 bytes.
> Implementations MUST NOT send pkt-line whose length exceeds 65520
> (65516 bytes of payload + 4 bytes of length data)."

I'm sure I did read the current version, so I think I must have glanced
at 65516 and seen 65535. I don't see FFFF in decimal very often.

I think FFF0 would have stood out better to me, but still the current
docs are ok.

--=20
see shy jo

--N1xWPjUN6RwJ6eI/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmGFRlYACgkQ2xLbD/Bf
jzjClA/+IdRy0tKkzZDxYlGAqEVhOBSbCBpx/NfvFgq9X8c6GWJ6+DB++Ah56Uyt
6sCuH0U8OyiTYPtj7ljWYKvWHHF57gO0I739zshcX5bDXLF+0eNbDhj6QU7fn6yA
XUTqnEawTBxzDx0H9ry54O6ipthHYlw5AYj7G4UszOVBxt8auoqc2+Vg+lyEhKnj
FNomPS/pdk239Z7oJm9HIozPs3rnXQW7r9ELdapAdIMnAZiOLn25aHPg1lcRGqnZ
17NbphLblU8RHgKLFUw8nBaNT+XGvvVtZAXe37NKsWUfhRr4i7wIqQ5aUXclDKAl
O5IBHm86Xtygc1Axeg5eZQr6133t/eWRsXbhd9q4lyC+rxlxCdpCQeH8cn3sS67n
DXJ/UW2BjVSkSY941Q0tRSmiyIHjFhBfoLftzn6uAgvVMrWiuVWPsKT3vvslw9jf
J8/8DxFzFnZcgXIZ+rKaQZ7mhaAqjGuzwz7WA2Lpj4HhvADnKP22Zr+oNSOL9HkT
YbkFnHM9izBHTsJP6W/6Llon4QvEy3T+aywbgZ5tdyQPzZx8v9EqhqCTkb8BNdft
h+aCMkrWa8SdwWWYjUwjx8t54kYbbgEfKXEHMfnpZGoZCof0k7hIwtQeiIAfNu5k
5T6X673uMKkNJ3KBvyzAS8GlV8SuXpwIqit7DMi3VSCzBDGv1m8=
=ouna
-----END PGP SIGNATURE-----

--N1xWPjUN6RwJ6eI/--
