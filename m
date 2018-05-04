Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0877200B9
	for <e@80x24.org>; Fri,  4 May 2018 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeEDBwK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 21:52:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39230 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751709AbeEDBwJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 May 2018 21:52:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2893860400;
        Fri,  4 May 2018 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525398727;
        bh=HxOgbFHPztCbmK79M5R8tMSMO7wFx0KQTDJGgFXVmj8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=02UIe5+mziHQx0lqkQ2MKZ73LcNwz1b8uCdYyDN7dF9m5ceQhxFgmycJw74rGaFRE
         +zaqCi5ID1kCzyGwwdz92WtMQvoINzGz4rf/nmgrxTZ7gy+GBEGkSnqceDaoHETEoU
         TlLeQbMt9yrfkZ/ZHeWJEZm1KOomju/onunqDi3a0xjkljrYh39j4wMmolMZ0ks6aU
         xA+FFb8e3o0qQT0Zw/hcCGypkOe3QHGGDtrG+Gtgs0Z5KNe5qwAgrGeAfIZAA8xsIb
         A0Y+EViXlPCPqR9N/MiSF4jYHoeVKyIu78RbZ9XSvm1WobI4gv5S1dqEKFDyhgE05M
         INEx3Wins8Mp2fYa6dv1R1/Qu8eANnzI+l/ktNBAlf3k+AQkdCRhP3vLhHT+JzoxzD
         D/C9Deoo5IR8oI1u3+6zjjs7iOz18aIf1kMOz3HiWdjkz7YRPaYpDOoBgDJtcaAH1a
         2Zj1M+CpOGxP1V4jFKpXXpEy5AYj3oH2u3afHv0/FMkRnwYiagE
Date:   Fri, 4 May 2018 01:52:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] revisions.txt: expand tabs to spaces in diagram
Message-ID: <20180504015202.GP13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180430210430.14611-1-martin.agren@gmail.com>
 <xmqq7eomwtid.fsf@gitster-ct.c.googlers.com>
 <CAN0heSqeMFq4yVHX=8Ug3wOTEzrLXwE=PcF7UFWTRg_AbZEWWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9lPOKfY2vCV97ybw"
Content-Disposition: inline
In-Reply-To: <CAN0heSqeMFq4yVHX=8Ug3wOTEzrLXwE=PcF7UFWTRg_AbZEWWg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9lPOKfY2vCV97ybw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 08:20:54AM +0200, Martin =C3=85gren wrote:
> On 2 May 2018 at 06:50, Junio C Hamano <gitster@pobox.com> wrote:
> > Martin =C3=85gren <martin.agren@gmail.com> writes:
> >
> >> The diagram renders fine in AsciiDoc before and after this patch.
> >> Asciidoctor, on the other hand, ignores the tabs entirely, which resul=
ts
> >> in different indentation for different lines. The graph illustration
> >> earlier in the document already uses spaces instead of a tab.
> >
> > Ouch.  We might want to teach Documentation/.gitattributes that
> > indent-with-tab is unwelcome in that directory, after making this
> > fix (and possibly similar ones to other files).
>=20
> I actually grepped around a little for a leading tab, to see if I could
> immediately spot any similar issues. But there are tons of tabs here
> (about 13000). Most of them work out just fine, e.g., in the OPTIONS,
> where we tab-indent the descriptions.
>=20
> So while we could try to move away from leading tabs in Documentation/,
> it would be a huge undertaking. Any kind of "do it while we're nearby"
> approach would take a long time to complete. And a one-off conversion
> would probably be a horrible idea. ;-)
>=20
> I just noticed another difference in how the tabs are handled. In
> git-add.txt, which I just picked at random, the three continuation lines
> in the synopsis indent differently in AsciiDoc (which indents them more
> than in the .txt) and Asciidoctor (which indents them less than in the
> .txt). To me, this is more of a "if I didn't sit down and compare the
> two outputs, I would never think about these indentations -- they're
> both fine".
>=20
> So it might be that the only places where leading tabs really matter is
> this kind of diagrams. Maybe we have a handful such bugs lingering among
> the 13000 tab-indented lines...

I took a look at this.  Asciidoctor does seem to have some weird ideas
about tabs, but I think how it's handling this is converting them to
spaces, which makes sense if you're working with HTML or XML (which do
some bizarre things with tabs).

However, it's not converting them to 8 spaces, which is really what we
want here.  We can help both AsciiDoc and Asciidoctor do the right thing
here (and keep our 8-space tabs) by enclosing the diagram in a block
like so:

[literal]
--
   Args   Expanded arguments    Selected commits
   D                            G H D
   D F                          G H I J D F
   ^G D                         H D
   ^D B                         E I J F B
   ^D B C                       E I J F B C
   C                            I J F C
   B..C   =3D ^B C                C
   B...C  =3D B ^F C              G H D E B C
   B^-    =3D B^..B
	  =3D ^B^1 B              E I J F B
   C^@    =3D C^1
	  =3D F                   I J F
   B^@    =3D B^1 B^2 B^3
	  =3D D E F               D G H E F I J
   C^!    =3D C ^C^@
	  =3D C ^C^1
	  =3D C ^F                C
   B^!    =3D B ^B^@
	  =3D B ^B^1 ^B^2 ^B^3
	  =3D B ^D ^E ^F          B
   F^! D  =3D F ^I ^J D           G H D F
--

and using the tabsize=3D8 attribute when invoking Asciidoctor.  I can send
a patch tomorrow which does this, which I think may be a bit nicer than
having to give up tabs.

Thoughts?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--9lPOKfY2vCV97ybw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrrvMIACgkQv1NdgR9S
9ose1g/+OLthvF9k70godolAli5Kml6rAiziy5/BD+7OAJPIqpDL2FDTngCUu1gD
Pdnw0kovKbEsIOOrbRNoSrULGkpdsqhsdLWMbCt0GgSN0d3nDc3oH9DQhBBi3DoB
TebH5exs7KVkPFynrnhLabtgx3jub4HmJrnRAH56Sk5Yo+p+lGuSY3MBAo1zizIq
uJGyDdrzxyAd2oTf6s2aoFMbZ9xX8gz7yC42U6Dmo5BwOvrQAd/DfJR5Drqn7zRb
H6jFtyIQLYyjidGPAS9SWLmdz9eJP10zyOZJ+pA0LJn/KaYE+V+Bu3kQwp5TQ+6o
q9hWaJy6Zz0iiexDjovi+9BQguL+295PgVWf4kP6nhAYFar0PunqK+G80ifowL+9
G+KG1SNUd7d0Re74/BkxEzTKD+PRRmnTf5Lty6bp2JURhbd0fb9u+VpPtc9d67nK
W+rmFG+uRPCrFERmKg8ooK7/igTtDNNZ/XGO0v63QbltfHzIL+kuLDYPXRGeoGvn
lNCCbtcDzTPuSt4eWXLgU2tynD4G55zEZ3UABXICTFdiaETJ5SXcpWYIea3gQzfX
mHBk8mK4gKhrX5HESOofC9PMFe/BiJ/hJgLecbZpeLhfxEV7YU3KPIyMFdcvwEbL
NhUX8pizS0JevVkjZJ/xinPlfPS7zWYuc7EV3YaAFIfZmQEEIQQ=
=LUOk
-----END PGP SIGNATURE-----

--9lPOKfY2vCV97ybw--
