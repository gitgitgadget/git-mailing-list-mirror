Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0431F403
	for <e@80x24.org>; Sun,  3 Jun 2018 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeFCS1b (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 14:27:31 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60652 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750991AbeFCS1b (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jun 2018 14:27:31 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 47E3760129;
        Sun,  3 Jun 2018 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528050449;
        bh=cAFEypRH0i90ALAUQMw6B9KbwyiKMqMQsgKdA4PiA3o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ya1zGmyFjD3JaT8psgyys61QskaDYgrcSMqpZGkkHtNSr6AoLOTli+CWSGf211DWP
         r7k5iH8LlqQNRsSh0AOhKDA6DcSgE514qFOx+arYqCnkDHTRDF5NMuV3OWJ/uTjybw
         tjyjyJi2HI6J8qd8CQxThcGTzEFZAoSTOOLk8pDfEct2NnK/sXHJeuPwRS4tPAzHQM
         SkWf2kIWsBjIn8qSZTJtQT5HCgOnBD4MbFCrykLR/BwCcFwMhN8Zfoi+GLaS6Vhp11
         AbcYhiFHj4UFlVtx0HAHe/F7TuY2iE7iF+90HD6wW+F1U+ItIBWN83NhmzbHX1tedu
         Cka+DsqV4FzGCBSeIIsfRDtjawN2gIBZDezC0X1cwz7vgv0LtImLlRuhOwg625FgYP
         YoOs2yhm5IfYL+1ZI6AEDqHQ9jPsb8Yxa6/iFZD75QRj2W0ICJ78uM/QeWa4uKYSEn
         oOgNj2s6K48s8SIjGephkVuSZt1SaRjNgtuEjv9BYxxpUq30ZWp
Date:   Sun, 3 Jun 2018 18:27:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 02/22] archive-zip.c: mark more strings for translation
Message-ID: <20180603182724.GA288937@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180602043241.9941-1-pclouds@gmail.com>
 <20180602043241.9941-3-pclouds@gmail.com>
 <CACsJy8DZC1xd5O=Qf=HEQeDQ0xpwExnnLvgqemNE77mVwQckeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <CACsJy8DZC1xd5O=Qf=HEQeDQ0xpwExnnLvgqemNE77mVwQckeg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 02, 2018 at 08:17:47AM +0200, Duy Nguyen wrote:
> On Sat, Jun 2, 2018 at 6:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >         if (pathlen > 0xffff) {
> > -               return error("path too long (%d chars, SHA1: %s): %s",
> > +               return error(_("path too long (%d chars, SHA1: %s): %s"=
),
> >                                 (int)pathlen, oid_to_hex(oid), path);
>=20
> Off topic. Brian, do we have a common term to use here (i.e. in user
> facing messages) instead of "SHA1" after we move away from it? Is it
> still "object name", or "hash" or some other fancy term?

You could say "object ID" or "object" here.  It should be clear from
context what that means.  I tend to use "hash" for things which are not
necessarily object IDs (e.g. pack hash).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsUMwwACgkQv1NdgR9S
9ou0WA/+JJQbyomphCaiDf9nlyDVzfa8TennY4DDjqJyEo7FRmo432P3PuuIBPLB
/CUKZu3tB661mKsH8eOuE28WXbJM9mI9DzZIS0bRhWW+YA45zlUIpBQ7LVz99aNy
Qu8q1ADsZw9mYYgu0YaT8ZM3s0CoduUpsgPgBl5PwM6rnTlmrNwgJjzcbvkaDcln
IpVmliOaNwQl21BZKjPku6UJkoaJy2+TbGNtrB/HpbLnAIbUAMErqV8WvmH7T7Fm
RtNcG1kVoC9NiY52FbwZD+qmTqJU9jXgC7be/BKFQz/p51/2c+H39EB2bd9ZuBIM
xGvRJKyVgnMGEIFJYchjuaT2nCJH7ArgGYNpaaBzQpgZ0JMonHJNLGyINK7Lg94l
rVIyV14tmt+39ZkdLRzvBTeH+FhIsIxf7N0M48wXxq9OT5KWv5+Eq8a2U/W46TbR
lWyXCpyMUv4yh95iOel6Uyjc2IyPoNO1TS+loxCK1FUUhbYiDgcQLCPVlZF0WHJm
nnskxcrthql/l8lKw24gYEJPDrvSeZ1OVPjopWbMy6RpG7QICDarQL6X++ANOCti
3MDEDS7B0+92iqvTGL5B1ukKIIZv+l5cktz/nOX8+gqj30uGj/3Jg7+PbGK5+Wso
hKL1NkI5ApmEkF5+UiG1EqCIyuWm7qLJbPAPQZVN2PHrNB1ykFo=
=bl1c
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
