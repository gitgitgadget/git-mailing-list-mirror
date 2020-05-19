Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E2DC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 00:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D29C2075F
	for <git@archiver.kernel.org>; Tue, 19 May 2020 00:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NFQhAR5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgESAbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 20:31:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgESAbG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 May 2020 20:31:06 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0CDE56044D;
        Tue, 19 May 2020 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589848265;
        bh=ItkroCIxAEi70X8O7ETXaDiyYWGxrb7Hpn6NW+QypYo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NFQhAR5CcGuX813HWzfMlwt2DGTY58gavc6ZsrOnFJD9BghxUk+JPzgbHlzQ/u0nx
         EHlFvyq8PXyG/Qb74T0MkT5j4RbnXAG3nMAYJ1TnJONkLOr+S7Gf3LQJePSxKI1fEI
         tigM3HIWsx4DxTqvVeu5Eh+hKCHI+Xx2rQhkFxKBK5FA2V/LTNJcpLhqPfCr/dqNFS
         9xFBbpBeNf6yQtooFasodaxsvYjteSBqfSuLavr2pcR7cxkR3aV+XaA5WPkBsU0Hq3
         twfohXt3C8MbIkzm1eEBXrPKCmx21O7KEq560YufFjEXFBNQ2TOedLQelUAGgMOHRc
         LD5P8cAZsGesefBToqJ0UKgfr85BVr4Ti8DEeaW3icsEPYXvg1ChWEvFPX9duQEiRM
         DTtU+hJ+QiC5AEQOukmZgRjqNZDk2a8Bkuk6IpsYBc5Y1FFAwU9v5u5zsvdo1aSk5X
         w2FMFoKoB7LOGISVICL4XvRyDlEJMLJhSrVIYejWzNgdkQDD6fM
Date:   Tue, 19 May 2020 00:31:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 27/44] builtin/show-index: provide options to determine
 hash algo
Message-ID: <20200519003100.GN6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-28-sandals@crustytoothpaste.net>
 <xmqqimgt5i61.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline
In-Reply-To: <xmqqimgt5i61.fsf@gitster.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-18 at 16:20:22, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > It's possible to use a variety of index formats with show-index, and we
> > need a way to indicate the hash algorithm which is in use for a
> > particular index we'd like to show.  Default to using the value for the
> > repository we're in by calling setup_git_directory_gently, and allow
> > overriding it by using a --hash argument.
>=20
> I think you meant to say that "show-index" does not autodetect what
> hash algorithm is used from its input, and the new argument is a way
> for the user to help the command when the hash algorithm is
> different from what is used in the current repository?

Correct.

> I ask because I found that your version can be read to say that
> "show-index" can show the contents of a given pack index using any
> hash algorithm we support, and the user can specify --hash=3DSHA-256
> when running the command on a pack .idx that uses SHA-1 object names
> to auto-convert it, and readers wouldn't be able to guess which was
> meant with only the above five lines.

No, that's definitely not what I meant.  I'll adjust the commit message
to make this clearer.

> Do we say --hash=3DSHA-1 etc. or --hash-algo=3DSHA-256 in other places?
> Would the word "hash" alone clear enough that it does not refer to
> a specific "hash" value but the name of an algorithm?
>=20
> The generating side seems to use "index-pack --object-format=3D<algo>"
> and the transport seems to use a capability "object-format=3D<algo>",
> neither of which is directly visible to the end users, but I think
> they follow "git init --object-format=3D<algo>", so we are consistent
> there.
>=20
> Perhaps we should follow suit here, too?

Yeah, as I mentioned to Martin elsewhere in the thread, I'm going to
make this consistent and use --object-formta.

> > diff --git a/git.c b/git.c
> > index 2e4efb4ff0..e53e8159a2 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -573,7 +573,7 @@ static struct cmd_struct commands[] =3D {
> >  	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
> >  	{ "show", cmd_show, RUN_SETUP },
> >  	{ "show-branch", cmd_show_branch, RUN_SETUP },
> > -	{ "show-index", cmd_show_index },
> > +	{ "show-index", cmd_show_index, RUN_SETUP_GENTLY },
>=20
> Hmph, this is not necessary to support peeking an .idx file in
> another repository that uses a different hash algorithm than ours
> (we do need the --hash=3D<algo> override to tell that the algo is
> different from what we read from our repository settings).  Is this
> absolutely necessary?
>=20
> Ah, I am misreading the patch.  We didn't even do setup but we now
> optionally do, in order to see if we are in a repository and what
> object format it uses to give the default value to --hash=3D<algo>
> when the argument is not given.  The need for RUN_SETUP_GENTLY
> is understandable.

Yes, this is designed to make us do the right thing when we're in a
repository (e.g., with --stdin) by autodetecting the algorithm in use
but not fail when we're outside of a repository.  I'll update the commit
message to make this a lot clearer, since I clearly omitted a lot of
things that were in my head when writing this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsMoxAAKCRB8DEliiIei
gVi9AP9S1yajtkdafCA9SZ448Wz8BDupZl3K1taX8dgRGJ6uEQEAoXT4Hjj7ag9V
RxUzCLU8kA7a5/p4qD5tBdZQbE7T6AI=
=DFx7
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
