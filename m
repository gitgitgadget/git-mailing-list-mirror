Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF96C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 20:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A0D20709
	for <git@archiver.kernel.org>; Sat, 16 May 2020 20:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="KbWEHD9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgEPUrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 16:47:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38450 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbgEPUrR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 16:47:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2EEEA6045A;
        Sat, 16 May 2020 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589662035;
        bh=AU84jPEUmwk3UrfBZy86o6g8q0snxxK3gGlaPcCDJiI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KbWEHD9JD8tkReunJmukHsExwi6MNKCVU66puF0UDZ03VLNsiKUp4pQ6I7px3UlEc
         l8IlnEbHLGNJrQyjEidL0xxlBs+Vf9WndyK4R/qbMzF5Oyq+6H00lMSuKuUlMQQlRb
         wQz05X+X82d6eU5tlXc0RybKEDb1JNyjZPw1T39lBQwqU7Lm4maQWfrGeVx6vrqzsj
         9XipPTdEmpv6yRssU8Fu7u3t4Rbm4x5xq8/CvwZjAdNa4SOJh//g18gXhtZpkqmPXh
         QVgX6s2qnCgK2hQ7n3wBbtvaHPKV6s4VnwRvyNBOqcofRjH60mtmc2OFO63ZXe/SQ1
         7tZiII+WDDZdTFG39dHdap9FPyqmXomG2yObLpVAbw23kKOmAcqox8YLPIFOWQ526h
         iTozJfHZ2RbwSImawyoXzRR8zRO6Jeo6kpHDy+eSUjeU0k2Io6z2HyjoOKwwYatgNk
         m1ydDHx6F0NgDAV+y6w2QwBDeKM0l4QPfrQy2KUa2p+qpU+JLC0
Date:   Sat, 16 May 2020 20:47:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 36/44] builtin/index-pack: add option to specify hash
 algorithm
Message-ID: <20200516204710.GI6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-37-sandals@crustytoothpaste.net>
 <CAN0heSqpqAyKyaz+Er-SppR8k5W=zfw31rLR=Z8yZzqu=BCnTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MFZs98Tklfu0WsCO"
Content-Disposition: inline
In-Reply-To: <CAN0heSqpqAyKyaz+Er-SppR8k5W=zfw31rLR=Z8yZzqu=BCnTA@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MFZs98Tklfu0WsCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 11:18:12, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:56, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > git index-pack is usually run in a repository, but need not be. Since
> > packs don't contains information on the algorithm in use, instead
> > relying on context, add an option to index-pack to tell it which one
> > we're using in case someone runs it outside of a repository.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> >  builtin/index-pack.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index 7bea1fba52..89f4962a00 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1760,6 +1760,11 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
> >                                         die(_("bad %s"), arg);
> >                         } else if (skip_prefix(arg, "--max-input-size=
=3D", &arg)) {
> >                                 max_input_size =3D strtoumax(arg, NULL,=
 10);
> > +                       } else if (skip_prefix(arg, "--object-format=3D=
", &arg)) {
> > +                               int hash_algo =3D hash_algo_by_name(arg=
);
> > +                               if (hash_algo =3D=3D GIT_HASH_UNKNOWN)
> > +                                       die(_("unknown hash algorithm '=
%s'"), arg);
> > +                               repo_set_hash_algo(the_repository, hash=
_algo);
> >                         } else
>=20
> Patch 27 added `--hash` to `git show-index` and I almost commented on
> "hash" vs "object-format". In the end I figured the object format was a
> more technical (protocol) term. But now I wonder. Should we try to align
> such options from the start? Or is there perhaps a reason for those
> different approaches?

I'll bring them into sync.

> Similar to an earlier patch where we modify `the_hash_algo` like this, I
> feel a bit nervous. What happens if you pass in a "wrong" algo here,
> i.e., SHA-1 in a SHA-256 repo? Or, given the motivation in the commit
> message, should this only be allowed if we really *are* outside a repo?

Unfortunately, we can't prevent the user from being inside repository A,
which is SHA-1, while invoking git index-pack on repository B, which is
SHA-256.  That is valid without --stdin, if uncommon, and it needs to be
supported.  I can prevent it from being used with --stdin, though.

If you pass in a wrong algorithm, we usually blow up with an inflate
error because we consume more bytes than expected with our ref deltas.
I'm not aware of any cases where we segfault or access invalid memory;
we just blow up in a nonobvious way.  That's true, too, if you manually
tamper with the algorithm in extensions.objectformat; usually we blow up
(but not segfault) because the index is "corrupt".
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MFZs98Tklfu0WsCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsBRTgAKCRB8DEliiIei
gdRSAQCnptE7KbK1kX2eAtWmmZdovWMG5mD6xvo2Q9MDOEHRtgEAsa2eVbIra4nf
crNBWaYNgxZR8IMdJmKEscA1GRJWoQ4=
=QJUE
-----END PGP SIGNATURE-----

--MFZs98Tklfu0WsCO--
