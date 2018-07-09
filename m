Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA7A1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 23:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeGIX1G (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 19:27:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55030 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932844AbeGIX1E (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2018 19:27:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1062E6047B;
        Mon,  9 Jul 2018 23:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531178822;
        bh=Rxd9lvt5COWOsXAHpWaGSJr3uU09r+qVsZCLvo8w18g=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=rzpYtF4M7Ja89p19fDPy6tPx3xgnYDXTDKTtB8ZdNz5sePIixBHEAoWbMyJlIR113
         boZiXjhkNnL1o9wq9sIq323vxm8TpEaS0ZEeKTb/44BrS7V4MppzsdME6ysILWQ8B4
         2Gn2NAUK4RQSDnoTxI4hvhfSTvFfI16f879AB292PbDyDaN0yVyxzJC+KXBLTiNicT
         /XEGlhEYt++l2Hsi40xbzMh4M6u4b8kIMKtfhYDZHLiP2a7u6fDIhdAx/wRUFkHVJ8
         VhJ3bRssYthDH6pvgAwsksZWEYmjsaZ1hL9G9jIgSo2bSHW879plkIC06U2qZ7DL/n
         TZb2fNcjMlV9r/Kh+HEMG0ikE9J5eQN2y4ovN1AUAzfMi9+bo++YsPBZRuP3uW4lqG
         IWg2KB6QxWzdngz5wqULQ7dXSiT0bHrzUxU1SzC7I6S2i6esPO3thLLc8f8ebaZVG1
         mwDcvLeZrb2dnV7c8lqxKzmR79cHXuKUtjij2xd9xi7WnJikyeC
Date:   Mon, 9 Jul 2018 23:26:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/17] cache: update object ID functions for the_hash_algo
Message-ID: <20180709232656.GA535220@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-2-sandals@crustytoothpaste.net>
 <CA+P7+xq900ikNR3uBEo28rjrTh5iYJm-R8jcAjhq-7G2jh3iVA@mail.gmail.com>
 <CAPig+cRznUKdriPhHMt5ocb_pXbByY5a40A8ZOiqF=_0hm7avw@mail.gmail.com>
 <CA+P7+xoMSWfV1ZqokGDvoZVRP65puiiwhTKHbuaiUPS2suA3oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <CA+P7+xoMSWfV1ZqokGDvoZVRP65puiiwhTKHbuaiUPS2suA3oQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 08, 2018 at 09:31:42PM -0700, Jacob Keller wrote:
> On Sun, Jul 8, 2018 at 9:05 PM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> >
> > On Sun, Jul 8, 2018 at 10:38 PM Jacob Keller <jacob.keller@gmail.com> w=
rote:
> > > On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
> > > <sandals@crustytoothpaste.net> wrote:
> > > >  static inline int oidcmp(const struct object_id *oid1, const struc=
t object_id *oid2)
> > > >  {
> > > > -       return hashcmp(oid1->hash, oid2->hash);
> > > > +       return memcmp(oid1->hash, oid2->hash, the_hash_algo->rawsz);
> > > >  }
> > >
> > > Just curious, what's the reasoning for not using the hashcmp anymore?
> >
> > hashcmp() is specific to SHA-1 (for instance, it hardocdes
> > GIT_SHA1_RAWSZ). oidcmp() is meant as the hash-agnostic replacement
> > for hashcmp(), so it doesn't make sense to continue implementing
> > oidcmp() in terms of hashcmp() (the latter of which will eventually be
> > retired, presumably).
>=20
> Fair. I just saw that hashcmp was also updated to use the_hash_algo,
> but if we're going to drop it eventually, then there's zero reason to
> keep implementing oidcmp in terms of it, so... makes sense to me!

Actually, this reminded me that I have a patch that I had forgotten
about in my next series that updates hashcmp.  I'll squash that in in my
reroll, and undo this change.

As a bonus, it also has a nicer commit message which I will include
explaining why this is necessary.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltD70AACgkQv1NdgR9S
9ovVVg//WEEGUI1sZLfSMGYdF1//Zk5JqWXcaaoAh3HHROlrf9cPCqL7DA8kbgnf
gymggojYkcqN3OE/nmTINnusztM3xMsbCr+6bIMZ94CUDuoA1e+xCdjXE3v/C81E
w8AGKeJn6roSy6Yj4R9VXqQ69MXnlX4hsOkMgEtrGbub/l0IPcOnf8N14g2oyjrB
1ZHkePTbj3pxltq2CiqmhAf/1UCK4z1uaJLWPDbVDeG6G5exBUAdBq2WikBmEeaO
KGHQRrmJKP74iDIBu4VvaqpZqC7ggEDJEri/jCDANalshDNdlV7MdX9FhFWrLFZr
VQeKWaEsYB+8CaF6s0X6ZFw5Sl9UxHbJZAaZzfNgpo/W3MqracV5WCZhVzZpPVON
UvK4Ue62fet/iki4PErUfuIYT2A2zyNtB8ckpwA52g6Rn+sYPgaizehM2tSJPLaU
XqA/YWy8Uj8WfB6GGnu30N5xXOQccLQMltE0HLl58VFs3lxIl3wAayTd86/wYJnp
ecG/mRNYEzxpsvoDo7ZaWoAaIYAr6xyvuvLrZc1yQPQ3izqUY4EgMQ476F5dfQKV
U9cnkG4PLGvvXKFGW0avRS2k5m9T+ZDg567AofC+wUIa+ztzN3IxmhxZl9LovLiR
H+INAmcWGLX2PGsjJQlKawuU0O9seeqR/6LqRXlAiLcZCvOKNJs=
=Omu2
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
