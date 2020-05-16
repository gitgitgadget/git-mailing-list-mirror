Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FD7C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 20:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373F7206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 20:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="URtWDqCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgEPU3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 16:29:02 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38440 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbgEPU3B (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 16:29:01 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1FE9760427;
        Sat, 16 May 2020 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589660940;
        bh=MIanbbS4VYqDcduGgLu6Ijs0G9v6HL4iXwENZOZj0m0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=URtWDqCJa7G1ojKgPipe9ApzWYsVr6wvbxXFPFtiXmqDAqW9CtBuS70JNQLekUpLv
         Hp85ZBa5JMJ5nhmNiK+WQc2Z/rg0Gizd25vEmtdC4MxhdQLfP8eiPe8NPbuaoppkUw
         /zQJPyz2EzHyqiXczmEdBczvDkFu++uQmK6KRNzywMoK3o/D2YT+vGbhMrC73Tubih
         5nd3O1vY+GPUG+SRTvL89b4MpQX+hJujq199h3mbT8JPJKQB1iUhXrSZ7yLhAU2OqB
         r5YetpOhTxUFHjIJBxf8RJ6LrRYf4MpUzZtZLYUX2KqWgx9/v40Csnewo4dMDzOjtN
         TLtC7D3Le+DdtKKmEol7ZJvw8lO+VsKZgaQrlseyPg1/4ln+XT/QAvCnsOpmw/nK2J
         xJFulKDY/wOVjsM7kt78r0OPW2C38EEt5VUshCfGBgrcVdSKxV1taIGjyXAj3uc18x
         nxET850dATbm3myIBItBQsW36ASmZE6OcqO3ZodXHMmvGsJlnXq
Date:   Sat, 16 May 2020 20:28:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 34/44] builtin/ls-remote: initialize repository based on
 fetch
Message-ID: <20200516202855.GH6362@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200513005424.81369-35-sandals@crustytoothpaste.net>
 <CAN0heSrLxatUNbJPZDmMC=NtF4R_AZF8gF-pUwJ+uQFMp3A6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <CAN0heSrLxatUNbJPZDmMC=NtF4R_AZF8gF-pUwJ+uQFMp3A6-w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-1-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-16 at 11:16:46, Martin =C3=85gren wrote:
> On Wed, 13 May 2020 at 02:58, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > ls-remote may or may not operate within a repository, and as such will
> > not have been initialized with the repository's hash algorithm.  Even if
> > it were, the remote side could be using a different algorithm and we
> > would still want to display those refs properly.  Find the hash
> > algorithm used by the remote side by querying the transport object and
> > set our hash algorithm accordingly.
> >
> > Without this change, if the remote side is using SHA-256, we truncate
> > the refs to 40 hex characters, since that's the length of the default
> > hash algorithm (SHA-1).
>=20
> Could we add a test that passes now but would have failed before?

The existing tests that call "git ls-remote" actually fail with SHA-256
if we don't do this, specifically "ls-remote works outside repository"
in t5512.  That's the thing with a lot of this series: our existing test
suite is enormously effective at catching these things, but writing a
new test is hard because we can't actually instantiate a SHA-256
repository (because then users could, and it's broken until the end of
the series).  Perhaps unsurprisingly, that's how I found this problem.

So while I would love to write a test for this case, I can't without
allowing users to corrupt and destroy their data in the mean time (or
tacking the final six commits to this series).

> >         ref =3D transport_get_remote_refs(transport, &ref_prefixes);
> > +       if (ref) {
> > +               int hash_algo =3D hash_algo_by_ptr(transport_get_hash_a=
lgo(transport));
> > +               repo_set_hash_algo(the_repository, hash_algo);
> > +       }
>=20
> This will modify `the_hash_algo`. Quoting commit 78a6766802 ("Integrate
> hash algorithm support with repo setup", 2017-11-12):
>=20
>   Add a constant, the_hash_algo, which points to the hash_algo structure
>   pointer in the repository global.  Note that this is the hash which is
>   used to serialize data to disk, not the hash which is used to display
>   items to the user.  The transition plan anticipates that these may be
>   different.  We can add an additional element in the future (say,
>   ui_hash_algo) to provide for this case.
>=20
> Don't we violate that here? Is it mostly luck that we can go on to list
> what we want to list and that we will never write to disk based on
> `the_hash_algo` being "wrong"(?)? Or am I missing something?

We do violate that and we also rely on it never having any effect on our
current repository.  Unfortunately, as things stand now, we don't
support multiple hash algorithms in the same running binary, and we
can't until we allow a member of struct object_id to vary based on the
hash algorithm.  That work is coming in a future series (after we have a
fully functioning SHA-256 stage 4 implementation), but at this point,
I'm still working through all of the crashes we get from random places
where we make assumptions about initializing things, so it's not a
straightforward fix.

For now, I think this is the best we can do without major additional
surgery to the codebase.  I'm fine with stating that git ls-remote can
read the repository (to parse remotes) but can't write to it, since
that's the behavior users will expect anyway.  I'll update the commit
message to reflect that wart and assumption, since it would be good to
document it.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXsBNBgAKCRB8DEliiIei
geHQAP9wkapRsZjC2//nO2ZFiREgnzpuvAn6YhCn2qcq1EE3aQD/b6i84J9kpuAF
tVzVXSoB4G+JR2mr7bknC501ujirWQw=
=89WL
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
