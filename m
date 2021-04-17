Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54848C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 22:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2390D6108C
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 22:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhDQWLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 18:11:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35620 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231854AbhDQWLd (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Apr 2021 18:11:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E7A016078B;
        Sat, 17 Apr 2021 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618697436;
        bh=DdFAm1pcnra3sOB6LyImM2rLOt2l9AgKDL8zi9cTuyw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i51OGdcuxZB064rNwkj2v7hPws+W+/Cjeh+JwVA53Or8C0RTZBf5/Yr/jTymM0P0/
         Msxl1buutWPu/fOccKh2pIfVsk5DbxCT4UIKukxr3uN+0rmvMc2Gr7/01046jdUmKM
         yHz+1R97DjFA/l0coMGF6gyEMWbs0+WA9mRyPXeyLexRPaD6y7SOTEHz6M6xrqSIZc
         YuLBGrHb/dsYRgOVaN7zKEATqQu2j5J2Vdbf7cYarKxxnKnbV+IyaTf8zq/yjpf/hD
         8GTiORcHO6Tn+WsKhFmrMfofQaYirCwWTZW22kLgpkqG+weegD1CnK4pQpI1vKTciI
         DVzj4mvTwlbZeIosalECE0DkjwTSyPNpD/n0DVQXXGFZvgpl03quTdG/xe3XaWvczF
         QqbFrUqlJu9Vb65y7dMLfesZvqRP8V8RdopS8oDyD9dYoH4vZDscEzRI8EZXue9HLH
         nPH429JbT2bkuSoKgQmXoQUoufhYBBt/7KaeEOs8bX3RIDY7B5I
Date:   Sat, 17 Apr 2021 22:10:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands in
 Perl/SH
Message-ID: <YHtc1LZCv0PWbFpD@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
 <bcc64c2d-3469-38ab-3234-fa8984a3d0f9@gmail.com>
 <87r1j91427.fsf@evledraar.gmail.com>
 <YHtFBeWxE2cFlShY@camp.crustytoothpaste.net>
 <87k0p01tje.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3iCLM26hf1x6rti9"
Content-Disposition: inline
In-Reply-To: <87k0p01tje.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3iCLM26hf1x6rti9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-17 at 21:37:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sat, Apr 17 2021, brian m. carlson wrote:
> > I'm also kind of opposed to this change.  For example, I plan on adding
> > a utility to fill in SHA-1 compatibility things for SHA-256 repos, and
> > that will be written in shell.  The performance benefit of C here is
> > going to be minimal, especially considering the fact that people will be
> > running it literally at most once per repo, so I don't see a reason to
> > spend a lot of time writing C code.
>=20
> "This change" as in the patch or my informal summary of what I think the
> current status quo is?

The patch.

> The change being proposed here isn't to say that you can never write a
> new thing in shell, but advice that actively encourages that for
> prototyping.

I think in many cases it is valuable to use it for prototyping still.

> > I'm not of the opinion that we should never have shell or Perl code in
> > our project, nor does it intrinsically make sense to migrate everything
> > to C.  Typically we've done that because it performs better, especially
> > on Windows, but there are many situations in which those are not major
> > considerations and shell or Perl can be a desirable approach.
>=20
> ... but since we're sharing our own opinions :)
>=20
> As someone with >100 commits in perl.git, I don't think I can be thought
> to be uncomfortable with the language.

I am duly aware of this fact, having worked on a mainly Perl codebase
full-time for 6 years.

> So it sucks for the individual author, but at this point the trade-off
> of whipping something new up in e.g. *.sh isn't just that the thing
> doesn't need to be performant, but e.g. in the case of the gettext
> integration means we'll be stuck with the fixed costs of extending
> certain core APIs to shell-land forever, whereas currently it's looking
> like we might be able to "git rm" much/most of that stuff sooner than
> later.

I think it's worth keeping the shell script stuff around because I think
it adds a lot less friction to building new tooling.  I'll be frank: I'm
not massively in love with C, despite having known it since I was 10,
nor is our C particularly elegant (memory leaks, tons of global
variables, etc.).  I think there can be an argument made that in a lot
of cases, shell or Perl is the better option when performance isn't
essential, and so I think those should continue to be first-class
languages in our codebase, even if that means we need to put a little
more effort into maintaining them.

Moreover, we still have a decent number of scripts using the shell
tooling, so I'm not sure they're going away quite as quickly as you'd
hoped.  I agree they're not as numerous as they used to be, but they're
still not entirely gone, nor do I think they're going to all disappear
anytime soon.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--3iCLM26hf1x6rti9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHtc0wAKCRB8DEliiIei
gdAAAP93yFRxanx/Odi1sQaABT4LxlQctWDbKFhlMmeWsfGyjwD/erpOBcSr8DCt
607AnpO6MCrgamQEIZRy81k/dNDkIQ4=
=Dw7g
-----END PGP SIGNATURE-----

--3iCLM26hf1x6rti9--
