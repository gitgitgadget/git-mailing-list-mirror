Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE35C35250
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A6F20715
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dfdGoWJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgBIQjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 11:39:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57482 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727698AbgBIQjF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2020 11:39:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 46F6360791;
        Sun,  9 Feb 2020 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581266343;
        bh=pTmzRT5IJ0DGuCranmG+/W2xQsDzpnTOlbh04z1hQDs=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dfdGoWJa6KsUBRBdC/Frwo7JDQPc5WERFE+Zj0dmnXqQJCPBvjgMB3gUPgX7HNqJd
         7B37PJRhBQAXDhfwWdNvu3sHkYhl5Blg2Y4BJQmdgSaID33vZMqzVcjjZdZ0PgCPj9
         LFOMiYqA1Pf0aZBU+Ibep7iTFqx24CGPvKwjpmSqajqBLJkdmTFoEwHzZDPCuSCjin
         dzU2oyshgZiF1yeQa+hwQAgQLSdGEn0h+LFr/VB8fAVE5Mm17QwA3uK0ZBORetx9OW
         3ykRlikF/x9RwSBvKgLqjvwPyeTOXHzSPLfKmwmnO6KYB0d7fbEdF247H67CZeEcg9
         IsgMhU91ygAy2HOyqlcbcybA/Jh62xDfPsKPSHHhWOClnW/2l90oVx/P32gp7yJYzZ
         AJFJZOaah0rB2Uoqognog2wrOLmObCO2hVCLzN3fHAFmCEAD9BQlbBNdt/mJ/pQKif
         IysitdKl5NHYmFuiX9CBd53pzBftFu2O3eFLLjOnAon/VjgsKsj
Date:   Sun, 9 Feb 2020 16:38:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     paul@pauldsmith.org.uk
Cc:     git@vger.kernel.org
Subject: Re: Support 'help' for custom/alias commands
Message-ID: <20200209163857.GA7054@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        paul@pauldsmith.org.uk, git@vger.kernel.org
References: <VI1P192MB025548BB0508125DF9B5852DC81C0@VI1P192MB0255.EURP192.PROD.OUTLOOK.COM>
 <005001d5dda3$5bc12510$13436f30$@pauldsmith.org.uk>
 <20200207234618.GH6573@camp.crustytoothpaste.net>
 <00df01d5df4a$e422af70$ac680e50$@pauldsmith.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <00df01d5df4a$e422af70$ac680e50$@pauldsmith.org.uk>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-09 at 13:14:42, paul@pauldsmith.org.uk wrote:
> Brian,
>=20
> Thanks for considering this.  I've not tried MANPATH but will take a look=
 - my employers use both Linux and Windows so this would only address half =
the issue but I also understand your comments on "one config to rule them a=
ll" and the HTML/MAN issue.
>=20
> I've used ASCIIDOCTOR already to create config but I feel it would be nic=
e if that could be rolled up into some sort of bundle but it users don't wa=
nt Ruby then yes, it's not going to work for them.  My personal take is tha=
t anyone wanting docs for their custom applications should create them like=
 core Git does - and with Docker and similar it's easy to isolate an enviro=
nment so perhaps a Docker image might be the way to go.

I don't see a problem with us shipping the stylesheets and tooling we
use for our conversions as something people can use, and then if they
want to install AsciiDoc or Asciidoctor, they can use the same scripts.
That wouldn't be that hard to do.

Personally, though, I find that I don't benefit from them much when I
write documentation, and so I don't use them.  Other people may feel
differently, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5ANaEACgkQv1NdgR9S
9osFgw//V/YIXBCYfoqS1V9zfK592B06pYU/Gz9S+VhcRsWvnPrt3WYCwvOj5TIR
/+9ZvnTzbqGbXTU/6KwC/RBeTg8M4AGNc5RBHYkhHjpENP4rw9VV8nkzbFUHkF1J
ytzPC9AeKNecHN4zbK8i2q+Xbrxh63V9PVSiUNcct5LIdq5KG9qr7HaYtiDGSoYj
7zZg2Dfi2iCvhKDbnR20/0CEfpJJGSG4EgEjAdr08cWLWCnxpkhRCG87macor/S1
8pO9e3/WesVZ1NjweWIRK9zDJfti4FN+aF0gLs/6IISXlZNlbMpzQwKxBmSNo/Y8
ian85ez/9DZwrhBAJ7NNNnnUuGbQ9QRhhSXWRSpeR8lMJBPmx6gSOpy5rliVfEUp
b4tCiLF9V9lVDGv+Q6lTcFd9T9PdfDXvnId9XGutk3JrI3MfGbdjY2JD4QK5iQjE
Pt8NTijXvhRaq4I6kkJLG5e+BQ52100Z9qUgnAtu3UIdrCiGlHqkUWhpCe4oPZZC
UwEJljM4PLLFSKJ9+dW1NASftHSxPl+Q8nwBIP+ey0MF7rh2UyHvilMf3kAOCJtS
5VAS5hS1B719Ae1hH8mUIRIUzy0Mf36PBG10BIz2yKQOombmBsXox2E+0sBT3j3b
FACbMB0DY7ctkzQe1oROaupDZVnaapY54A46kFwCw3/Z4MnN0H8=
=+RVq
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
