Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCBC433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E305220693
	for <git@archiver.kernel.org>; Wed, 13 May 2020 22:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="iMK2FUhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbgEMWw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 18:52:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38336 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731276AbgEMWw0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 18:52:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2FE4D6044D;
        Wed, 13 May 2020 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589410345;
        bh=yMUpIO+spbAJTIV/VVOx8nDqR1Jv4CM+kTrmPu8wF44=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iMK2FUhNrvRTEDEwyHP2Kjq7wmxYytJuHDShNUeAKWag1n58cO4ILNpJdq60flrFj
         gGmUQKDBUlHQ1K0xssJ0UMGbyanT+TtfdzgRu3btcIgBoXYp7N6I5HJyDtZFwQSIHN
         rodWi9IC8YpEgeaNI5/2d66UmEsZUgW88f/55y6Y+RFzBF/f2nLiib4bwI++t/lBBK
         FHPlY+hh01en4iEI6XCdzzyx7acASpT1NKZJp6WKXN2JljJLGI17SuZXtHp3pbhuG/
         sTsCPY0Fan8UN4O4HEv8ol+qlZYLEiL/5Ep0hd4A2CUqnxHZGLXGBZw7Fc0jGFWZte
         IO+lbaODKeKK92lSsNo2z1oQlI+vX7XtnJiDZmE3eoK0sKRzSUAouC15F7IKPRlLwC
         +gvmX7O2051kd9ct/nyRzdI5f0GqtnkGc6mQDyVGetWdPCGMGa3EYRtkFL5f/+UhHV
         l51CBlx171obIPTUraYzV36m3MJEZsl+0HMqeaVgdbed3Kl7jyl
Date:   Wed, 13 May 2020 22:52:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 11/44] send-pack: detect when the server doesn't support
 our hash
Message-ID: <20200513225221.GF6605@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-12-sandals@crustytoothpaste.net>
 <CAN0heSqvy_y7tNkfs_499vfYL6iOvE6nH5s_42WOHAT-5iSgUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <CAN0heSqvy_y7tNkfs_499vfYL6iOvE6nH5s_42WOHAT-5iSgUQ@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-13 at 19:41:15, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:58, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > Detect when the server doesn't support our hash algorithm and abort.
>=20
> > +       if (!server_supports_hash(the_hash_algo->name, &object_format_s=
upported))
> > +               die(_("the receiving end does not support this reposito=
ry's hash algorithm"));
>=20
> I suppose this isn't the long-term wanted behavior? Would this be where
> we would later learn to realize that "oh, crap, we need to
> convert/translate on the fly"?

Yes, this would be the point at which we'd decide whether we could
support the remote side's algorithm and decide to rewrite objects.  We
might still fail, such as if we're SHA-256 only without a lookup table
and the remote side is SHA-1, but theoretically we'd do the conversion
here.

> > @@ -428,6 +432,8 @@ int send_pack(struct send_pack_args *args,
> >                 strbuf_addstr(&cap_buf, " atomic");
> >         if (use_push_options)
> >                 strbuf_addstr(&cap_buf, " push-options");
> > +       if (object_format_supported)
> > +               strbuf_addf(&cap_buf, " object-format=3D%s", the_hash_a=
lgo->name);
>=20
> This isn't advertised in the log message: If we do detect support, go on
> to reply with our choice of object format / hash algo name.

I'll update the message.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXrx6JAAKCRB8DEliiIei
gSGdAQDTg4c7/Abm4ghcYuGc92BanMwpSvHXGCUn9C18Eu22VAEAjlWG0AvdqZ+A
U9Gk2nXeSvUtrRGq0a2TncgNhtPv6wQ=
=z6Ev
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
