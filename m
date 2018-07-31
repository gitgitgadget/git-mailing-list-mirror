Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70FB1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 01:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeGaCk6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:40:58 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727478AbeGaCk6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Jul 2018 22:40:58 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b423:857:b27f:2f08])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 810B060779;
        Tue, 31 Jul 2018 01:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1532998997;
        bh=UAUKov2kJCH1kAPHpe1mSaU1u0spo2EtJ2LixUzhsF0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Lm6tUh5QSgItZjYWkhD3fcmo2I32qtW8tVr5XDmmrbM/TCqon6+JnLSnlNvA5eUNB
         0hKCtBxwOll2cq4iAIhMT/3gxX4O5YS3eNDWYFj7fOx2BOxb5iGeTasJYhPt+u4su0
         GQ2rivFAcCQR4rmn65+3kytsnkMfNBazG0axp9zslZEklM2AHxeTY8bXEe+TaBJzY5
         N1bPjVBkvTr1GAot/zZhtB2QIX8Yrf5rpxtuLeCGacQ2IsFv6/s72lgOO2gv8a+GoF
         yHn+w7G9fAw1bZ3XZu7df6+Mf6Ecugt628u1e3xv5RcTU4Scl/C35MfYcRBKITJJs4
         bwhvFyRS//1YzJqBrhXf/cIIk/7CJbwg0JDi3ELTwJlFoi1md3uv242Xu37trkLAqi
         o8kjaSggyvxNLcgWHqRi5fUsQSlrE6T3cx5ALdIppdR/+IjVxXU4AMjIP2aVqAxHLs
         qw9TEiGq3myjyVYYxBVrCyRphk964EZFhnYvUR/cJkEFU3S6c71
Date:   Tue, 31 Jul 2018 01:03:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     hanwen@google.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Highlight keywords in remote sideband output.
Message-ID: <20180731010312.GA45452@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>, hanwen@google.com,
        Git Mailing List <git@vger.kernel.org>
References: <20180730123334.65186-1-hanwen@google.com>
 <20180730123334.65186-2-hanwen@google.com>
 <CACsJy8CSh5uqWepdY7wCzP024WYcRFM719uXoKzJ4oziHHxwjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <CACsJy8CSh5uqWepdY7wCzP024WYcRFM719uXoKzJ4oziHHxwjw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 04:52:40PM +0200, Duy Nguyen wrote:
> On Mon, Jul 30, 2018 at 2:34 PM Han-Wen Nienhuys <hanwen@google.com> wrot=
e:
> > +       struct kwtable {
> > +               const char *keyword;
> > +               const char *color;
> > +       } keywords[] =3D {
> > +               {"hint", GIT_COLOR_YELLOW},
> > +               {"warning", GIT_COLOR_BOLD_YELLOW},
> > +               {"success", GIT_COLOR_BOLD_GREEN},
> > +               {"error", GIT_COLOR_BOLD_RED},
> > +       };
>=20
> Please let me customize these colors. "grep color.*slot
> Documentation/config.txt help.c" could give you a few examples.

Yes, please.  I use a transparent terminal and I have trouble seeing the
default red in some cases due to lack of contrast, and some people with
certain forms of colorblindness may be unable to distinguish these three
colors at all.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltftVAACgkQv1NdgR9S
9ou6CA/+KFWgoYDX4+GLb8HrmbOJBAVv0YRAJHDsa2/fHiXUu0Z746EkIEWv0amK
XrcxBtgr3QPBL+q0Gbxk3vTWqqGPuI0gUaD54NKYyABe94h2N781z3epE4bIfioy
zffuA47ml6+iuF99umvjOEdGJm2gp7uhYvDumFBxAb0R08ecwGzuSFdthHByIp5N
tIxxEQfhafHmmTNqLY6uzpL7stAZNdHOsH/91I9zrKQpaBye+EhSAckDLCY/s8Vk
n88Nu5FVK2KlXZv1gD8gW6VS2YaBuMG2eCO+WDq1rTVBoN3ZXcpGc+2sVMv70kUq
P86/vhkqNPswtY/0O/U5LktRNmOzm49B+n5yorCcEJ05bg7hgY5tt+zTdLwrnzz/
YQ+aUy7gtb/moyFJHICBC2tzoO01j3rJ3UoKqX44CtJjTEi98O58tBNQ+CzC5UnS
x64DFh0QbGop17F/c3B2MRBQN14mp7f2ivl4tqjDw9PgnllJFPVh7BOUntpOzXMT
AjOZ9rZi1DDS9rphvHAEeK+TyMFGJIwuzPufMJyLxCHdJUVkKgsidbqdmgFbE233
yKpjAq7tz8r41vOEEvgahB8un94moL7QEUE/nEj4KFb8BsUDqygd//wqevGYxjXR
DL4ul/do8BxGGlqW79uYmsng79MpB1sGHY7f7LmDZrLonQiBnEs=
=iAos
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
