Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28119C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 20:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E649861026
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 20:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhDQU32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 16:29:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236718AbhDQU31 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Apr 2021 16:29:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D848E60744;
        Sat, 17 Apr 2021 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618691339;
        bh=gGTeH8s9GZ5mV2kI5ej7t4GC/+d4jR2ZPf8s5TyYANQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nSqhSwxOeyy/2RKav9X+2Evku3d9hwUs/oKoDGKoSBm+/cPSSGT7KZB3x5jq46rWk
         GdZVYbonOoP/Xlc4FQH7+f4SY6WoMiJvX1nB8KdB41ufxLkhdCZP9+r2kih66CtCD4
         YJxx7Xt0v6UbJF1Asy626jg15PRxpXxYDS9fIYdtcKjDJUYGOeN7oycSZPmPjMdoEz
         JKm2u1xx2r+sE6aDfETI7YV+NU2SpputD0roLB5qysgyMQrqGLN9JS7jRLA7HZMhmR
         L8kVxVE6n3ESqDrGcrjnWoGab+kV61NKVYWZBMu3Re3/SqUam0Xoi/q8reGAfkIh6B
         LYe4u3gqG2gHx/zmo3Pq4EGAUjzgzFWh7Rew4TEml5ovGHYQ4ZbhSPvWWV2vVCQ1EL
         Y6JbTqi9tKCJKKg8hz0gAjtAs6ivCzs47vnHFyl/xdXeLmLbOyf6ow6HIDRX2s39Cv
         QDr05dQqYcWjjiA+upxDI31gIcJkkWhpWF3b9Onk9FoW/Rmmw04
Date:   Sat, 17 Apr 2021 20:28:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands in
 Perl/SH
Message-ID: <YHtFBeWxE2cFlShY@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
 <bcc64c2d-3469-38ab-3234-fa8984a3d0f9@gmail.com>
 <87r1j91427.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XEuGnqIlVymMB/Xj"
Content-Disposition: inline
In-Reply-To: <87r1j91427.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XEuGnqIlVymMB/Xj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-17 at 12:36:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sat, Apr 17 2021, Bagas Sanjaya wrote:
>=20
> > On 17/04/21 15.43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Since then the consensus changed to having no new such commands unless
> >> necessary, and existing ones have been actively migrated to C.
> >
> > What I implied that when we need to implement new commands, it must
> > be directly written in C (steeper learning curve and more tedious
> > than implemented in shell script), so I'm against this proposal.
>=20
> I updated the v2 of this to note that I'm not really proposing anything
> new, but just bringing the document in line with reality. For a long
> time now we've rejected any new non-C things being imported into the
> tree, unless those that fall under the "such as an importer to convert
> random-scm-X" language that's still retained in the CodingGuidelines.
>=20
> I think that even if you or someone else wanted to write a new thing in
> Perl or SH we'd want a new way of doing that now anyway,
> e.g. git-send-email.perl should really be a helper for a C program
> rather than a stand-alone thing.

I'm also kind of opposed to this change.  For example, I plan on adding
a utility to fill in SHA-1 compatibility things for SHA-256 repos, and
that will be written in shell.  The performance benefit of C here is
going to be minimal, especially considering the fact that people will be
running it literally at most once per repo, so I don't see a reason to
spend a lot of time writing C code.

I'm not of the opinion that we should never have shell or Perl code in
our project, nor does it intrinsically make sense to migrate everything
to C.  Typically we've done that because it performs better, especially
on Windows, but there are many situations in which those are not major
considerations and shell or Perl can be a desirable approach.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--XEuGnqIlVymMB/Xj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHtFBQAKCRB8DEliiIei
gdosAQDZyYPZlm1KzCm3DiKGGn40SjnYmq4YXEfbDAZt5RV9AQD/Y9+OqIcBLK7+
v9G6aUPj5Nw9pbmzOyHfwnh+p46IRw4=
=vAcv
-----END PGP SIGNATURE-----

--XEuGnqIlVymMB/Xj--
