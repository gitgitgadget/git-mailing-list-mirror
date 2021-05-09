Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6262C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 00:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B425C6140F
	for <git@archiver.kernel.org>; Sun,  9 May 2021 00:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbhEIAXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 20:23:43 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50476 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhEIAXj (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 May 2021 20:23:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CF1F6042E;
        Sun,  9 May 2021 00:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620519737;
        bh=3BH3gbj/Q3TF1cTdMWKoMBZ8tqCIy0HbyjgZh+PyJnU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Np1n4JyASK1pehIb8N8irOwocftadGvFx6aA5wD9eHkaR5Qn9ppj9U3hwWKejDA1C
         ERBqZcvrcSSd2GxvgczHp47gNFO/xFJ2+DgUCr3O0K+i1cTQ9iiw4/mGJPMZk+K0t3
         xMpAWM8QluxCA77dQDr9QH0SaHPqKgcal9ELOi8v60a8Zo0/N+Wa3zibZfyU+Ysbfw
         k9uzxY3f2a98Ig9w5tge5Ia3C0toxCz/FssvAm8Rj47NyejUcjF/eReb31Uh0+jXyM
         hVxPhbFnZXoxbMIqAchzryOgoPpMVlbOlqD97UVWMC7N87ADgxVB913PGdx621Lel3
         tTnqpFDiXtVXcXPVsIx1THFFo69swHWKN9dfa1+11w3HKOZI7G3NnxAClGgJPojAQr
         9OrS6xPARTddsrsSw2pMz5o3PpoU/6Tp6k3gIS+/hIllaVxIQFAQxL9dIQ498W+bX+
         YPWr0Ya2e7KiqFVv3M16sGsavLYtp5BglJ+AYagJoPqF/AlF8t3
Date:   Sun, 9 May 2021 00:22:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJcrNXEwNJpB8G/0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <6095ceb984401_cfc7208b9@natae.notmuch>
 <YJXT7AaqCeCV4WcZ@camp.crustytoothpaste.net>
 <YJYBOrm2cQkkVteb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="A1ZOhmX9FyDOatwR"
Content-Disposition: inline
In-Reply-To: <YJYBOrm2cQkkVteb@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--A1ZOhmX9FyDOatwR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-08 at 03:10:50, Jeff King wrote:
> On Fri, May 07, 2021 at 11:57:32PM +0000, brian m. carlson wrote:
>=20
> > It's not quite that simple.  It requires changes to
> > asciidoctor-extensions.rb and we also need to consider
> > NO_MAN_BOLD_LITERAL and GNU_ROFF.  The latter especially is likely to be
> > inconvenient, since according to the Makefile, it's impossible to write
> > man output that works across troff versions.
> >=20
> > We will also want to preserve the ability to use xmlto because we
> > currently have doc-diff which helps us find divergences in the behavior
> > of AsciiDoc and Asciidoctor, many of which affect all formats, and that
> > will be completely useless if we use two different rendering toolchains.
>=20
> Speaking of doc-diff: with that patch applied, try "./doc-diff
> --asciidoctor HEAD^ HEAD", which shows quite a few of the complications
> (another one seems to be that all of the linkgit macros are broken).

Yes, that's because the linkgit macros are specified on a
format-specific basis by the extensions file and without updating
they won't understand how to generate output for the manpage formatter.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--A1ZOhmX9FyDOatwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJcrNQAKCRB8DEliiIei
gbA5AP0UMEmLKEtRh31oFdzsUOQszmiyGRl6Ki7ntMNoBGEdRQEA0vGKoVUYo2Vs
Qx+fRag2S8nmPpniFvyKuWQ/6iLcSA4=
=j0bs
-----END PGP SIGNATURE-----

--A1ZOhmX9FyDOatwR--
