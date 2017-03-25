Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E215820966
	for <e@80x24.org>; Sat, 25 Mar 2017 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbdCYV20 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 17:28:26 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57790 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751299AbdCYV2Y (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Mar 2017 17:28:24 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 37F97280AD;
        Sat, 25 Mar 2017 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490477302;
        bh=7i21un10DnOyFkbj3VPdP8ag5ngutv94MdWDpLvIesI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPG2Ri8pq9BFBocR6XSv2NXws1bRKaGg6yEc1Ff8WlrSchuIRLrn/LUcYzQEqFuud
         YJ1daewIMg8O/i7lW/L1PXVsAm2WPufi8ojIw6wj9Krg3eaAj7fMqxA1K8QsmX9H9F
         XviCJQu60psK+4XPEBVe7Qk8KusZ8v6kWoMRjoCTSYGtd1pI1mOFBexE7z371CeBfo
         JiX8LwGKnSRg5gQvTvF7I919DzjSHpqQjduyzYMtevkic6inMLIt2gqhc7L+f+8umx
         RXgfBf30uf8B3MSe+YLRoDOBDr+np55zFXAW3keHSeAzDjKhV6dMXemotwYvEzuCzd
         +9iwmj9xHhdhaP4hf7SshOuiyw+/j9ANGrxMen0cQNw2o9GaqvjaHDkKYlmZC5zATW
         pqyot1SDIZNhWz3PLH4SOxgqE7F5C5sqVZ+1FrZF8fYL9wlNDUXE/d8ZEnKxVJ8FeF
         Wq1qwWJBnKmSPKB06eqW3R3M2qCevECVNUd+gEuZZ0nw9qYshe5
Date:   Sat, 25 Mar 2017 21:28:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH/RFC] parse-options: add facility to make options
 configurable
Message-ID: <20170325212818.2fdxhrywm4zxmmck@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
References: <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
 <20170324231013.23346-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stlapxf5wtobjd2t"
Content-Disposition: inline
In-Reply-To: <20170324231013.23346-1-avarab@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--stlapxf5wtobjd2t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 11:10:13PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Sun, Mar 19, 2017 at 2:43 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> > I don't know if this is what Duy has in mind, but the facility I've
> > described is  purely an internal code reorganization issue. I.e. us
> > not having to write custom code for each bultin every time we want to
> > take an option from the command line || config.
>=20
> Here's an implementation of this I hacked up this evening. This is
> very WIP as noted in the commit message / TODO comments, but it works!
> I thought I'd send it to the list for comments on the general approach
> before taking it much further.

For what it's worth, I think this is a good design.  It makes it easy to
add options when needed, but it doesn't override the defaults for the
entire command, which was my concern.

The potential for removing a decent amount of likely duplicative code
also makes me happy.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--stlapxf5wtobjd2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljW4PIACgkQv1NdgR9S
9ot6Yg//c1bZjpIebY/niE9ARW9mgICH1DA7qQaStTfT/5ix2ruxQRav9pd9P+hg
fgF2SFd/3AkVFNWKTXRxE2dJb4do7DcyRkb51sNJaLTL3fuSxWUFbXPVqfpQpij7
tzFUS7vgWAsDGX2Rnr7sbsvKljfOS+ASy3/euitY7KqYSAgu0Aq3q9h7+uzVCOkx
KWNr5BzbYqlhNcMAtNJCiuIf+nwPoHnr5dWY0k55uEPTHYI8LKRpSFmcCotL4sLj
1P2UQmjDUVX8LdxEfaA3WVdCrMoT9A5z+w0MCYaNE1KEambHjXPBGaSzxlqhXo4m
Ao8oTDMBxb9x33+fiR0hw07eum+UdZ+lFQhQ3+TOrxy+Q/i+wrvQNACUbr/2GjVX
nez9IJSiY+xy125leRXFUPahwkivpdS6Zcqv6kfiT08yKsMEsfDCk50+RadGtXac
n2OsVeWNn8Vx7fqpDNO0dFSkaTEPC+1SlOcYlZUtk/wrSnBKru62BKdpgRRgPbDf
TKau0L4ZVqfToqKU4SDQzUKSbrBsUI2jY8w3oRrWxXiQUcEseCkGFXZbdmqBfT+2
V9C2byO0Wg+cVoqEdcEYf6XYcjWIDNQVj79E7xJzpFtq09OCP90kxVANWP4BRlfP
D/Ze9S9p4SLrQgF7Xc45d5bMBp+nLmcVrqaP+xBfqYyDKlXZG3A=
=avcF
-----END PGP SIGNATURE-----

--stlapxf5wtobjd2t--
