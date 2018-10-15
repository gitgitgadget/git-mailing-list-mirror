Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6351F453
	for <e@80x24.org>; Mon, 15 Oct 2018 23:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJPHSL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 03:18:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50792 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbeJPHSL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Oct 2018 03:18:11 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:90d0:bd19:fb95:28cb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0283F61B73;
        Mon, 15 Oct 2018 23:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1539646241;
        bh=7kwHxLOn1dSlFqcGBkOayR6f5NXJS/pDIsHWYLVgRXo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=YsHaAzrNRbl4eB3XSexAotJ5xbtJ64BNPRvmna48FGAbyTW7pT5MBeG96C2Dj6M7K
         EiClfWZSKXVrENno989JNSSoN+aAgPBXrcOmefsdkxE6JV9DfkpNT5Gkv5D+Lzi3Gr
         5hNiftj0voeYJZsFcnXs0elB48DrTzXE1bsclTUanzqjGDVU7v9mxCp+KmI5hGSJX0
         sOAG3vvVqkjMgBPZ/W9/U+7y5p5YNzmxLOnBKpwbOUuGIdjoJA6EGVqoJgri+QtJwq
         8XorS0jobGcbTT0FF3m810w5xCcIsMGMfnd26aUjlRKsze4kPjpIn0ebkAdmrhN3vs
         eVRw3FKqSkYjicgVRMFgbpCJ5C2qVHSeZy6h2Lm3kSkKqtrogAv2J6nE4xS3NL99uE
         bMCsglaXr/CNChJkGJqJkAHqZRioJnld++ZrW3Fx48XYyLsUTr2rZ86V1Ch5nqd4iz
         b463BkoomeJB/Qi+7mnA3qOtif/DEEgavBXegWYaPHATIzRADw2
Date:   Mon, 15 Oct 2018 23:30:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 10/13] Add a base implementation of SHA-256 support
Message-ID: <20181015233035.GB432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-11-sandals@crustytoothpaste.net>
 <CACsJy8AOu-SdLu+MQKOzVLEy0SM0r45TjwZYkD_S5W756hWRpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XCAWwTQADTZzNDLi"
Content-Disposition: inline
In-Reply-To: <CACsJy8AOu-SdLu+MQKOzVLEy0SM0r45TjwZYkD_S5W756hWRpw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XCAWwTQADTZzNDLi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 04:59:12PM +0200, Duy Nguyen wrote:
>  On Mon, Oct 15, 2018 at 4:23 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > SHA-1 is weak and we need to transition to a new hash function.  For
> > some time, we have referred to this new function as NewHash.  Recently,
> > we decided to pick SHA-256 as NewHash.
> >
> > Add a basic implementation of SHA-256 based off libtomcrypt, which is in
> > the public domain.  Optimize it and restructure it to meet our coding
> > standards.  Place it in a directory called "sha256" where it and any
> > future implementations can live so as to avoid a proliferation of
> > implementation directories.
> >
> > Wire up SHA-256 in the list of hash algorithms, and add a test that the
> > algorithm works correctly.
> >
> > Note that with this patch, it is still not possible to switch to using
> > SHA-256 in Git.  Additional patches are needed to prepare the code to
> > handle a larger hash algorithm and further test fixes are needed.
>=20
> At some point I assume SHA-256 will become functional and be part of a
> git release without all file formats updated to support multiple
> hashes. Should we somehow discourage the user from using it because it
> will break when all file formats are finally updated?

In order to activate SHA-256 in the codebase, currently you need a patch
to force it on.  Otherwise, the code is simply inert and does nothing
(other than in the test-tool).  I've included the patch below so you can
see what it does (or if you want to play around with it).

Without this patch, Git remains fully SHA-1 and can't access any of the
SHA-256 code.  I have some very preliminary patches that do wire up
extensions.objectFormat (branch object-id-part15 [sic]) but I haven't
picked them up in a while.  (I need to finish test fixes first.)

Making the codebase run in SHA-256 mode with a Git that supports both
algorithms but defaults to SHA-1 is currently seriously broken, even
with the object-id-part15 branch.  When those patches go in, they will
be behind a developer flag to prevent wholesale chaos and segfaults.

So in summary, no, I don't think a developer flag is necessary at this
point.

-- >% --
=46rom 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
=46rom: "brian m. carlson" <sandals@crustytoothpaste.net>
Date: Wed, 25 Jul 2018 23:48:30 +0000
Subject: [PATCH] Switch default hash algorithm to SHA-256 for testing

Set the default hash algorithm to SHA-256 for testing purposes.

This is a test commit and should not be used in production.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 repository.c            |  2 +-
 setup.c                 |  2 +-
 t/test-lib-functions.sh |  4 +---
 t/test-lib.sh           | 13 ++++++++-----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/repository.c b/repository.c
index 5dd1486718..4ce50ea670 100644
--- a/repository.c
+++ b/repository.c
@@ -17,7 +17,7 @@ void initialize_the_repository(void)
 	the_repo.objects =3D raw_object_store_new();
 	the_repo.parsed_objects =3D parsed_object_pool_new();
=20
-	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
+	repo_set_hash_algo(&the_repo, GIT_HASH_SHA256);
 }
=20
 static void expand_base_dir(char **out, const char *in,
diff --git a/setup.c b/setup.c
index b24c811c1c..2b4cc4e5a4 100644
--- a/setup.c
+++ b/setup.c
@@ -490,7 +490,7 @@ int read_repository_format(struct repository_format *fo=
rmat, const char *path)
 	memset(format, 0, sizeof(*format));
 	format->version =3D -1;
 	format->is_bare =3D -1;
-	format->hash_algo =3D GIT_HASH_SHA1;
+	format->hash_algo =3D GIT_HASH_SHA256;
 	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
 	return format->version;
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index dfa1bebb46..91cf2b9d40 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1165,9 +1165,7 @@ test_set_hash () {
=20
 # Detect the hash algorithm in use.
 test_detect_hash () {
-	# Currently we only support SHA-1, but in the future this function will
-	# actually detect the algorithm in use.
-	test_hash_algo=3D'sha1'
+	test_hash_algo=3D'sha256'
 }
=20
 # Load common hash metadata and common placeholder object IDs for use with
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3f95bfda60..bb507f2d4f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -176,18 +176,21 @@ esac
=20
 # Convenience
 #
-# A regexp to match 5, 35 and 40 hexdigits
+# A regexp to match 4, 5, 35, 40, and 64 hexdigits
+_x04=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x05=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x35=3D"$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 _x40=3D"$_x35$_x05"
+_x64=3D"$_x40$_x05$_x05$_x05$_x05$_x04"
=20
 # Zero SHA-1
 _z40=3D0000000000000000000000000000000000000000
+_z64=3D0000000000000000000000000000000000000000000000000000000000000000
=20
-OID_REGEX=3D"$_x40"
-ZERO_OID=3D$_z40
-EMPTY_TREE=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
-EMPTY_BLOB=3De69de29bb2d1d6434b8b29ae775ad8c2e48c5391
+OID_REGEX=3D"$_x64"
+ZERO_OID=3D$_z64
+EMPTY_TREE=3D6ef19b41225c5369f1c104d45d8d85efa9b057b53b14b4b9b939dd74decc5=
321
+EMPTY_BLOB=3D473a0f4c3be8a93681a267e3b1e9a7dcda1185436fe141f7749120a303721=
813
=20
 # Line feed
 LF=3D'
-- >% --
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--XCAWwTQADTZzNDLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvFIxsACgkQv1NdgR9S
9ovbkBAAxw+g02WSPzRHUewEGiEMst9U10P0eLo3NeGYkx3wrJZbuYY6tecyjjqF
AnNqmW8PFfz1XljEAX4dhx8o8N7zTckkyRn6ykVE5wda8fyZYfNxrYdexaA5VS3C
wAlnAD0/gY2+kVomckUO7JiCkKJ4CYWe9xBjjX2E8zufrXEq8CNcOqqR56pD7j3F
mZzM1+dPhedMT7GiGOMRReHFQZzk+fKpLLfOyQwCny6DLcncH6sPRRQlyM/le7i3
XQddg3Dm8j4juSFPMtHM4ooKKxMclGRFQ9n0/B6s1k8+I4fUWYxrg66K82hdDRM9
f0BtQpfCLCI1ldAjwW/LDi9pGF6nrSl8nBVhi4ZlRKA1zSt1Sabm1CqGmTvCD+iX
wNTnDScqesGeGzzvR6+xfR5tFxaeo/M/b16wBRqZm6w0ui3wjrTJzPy3f6uu9C8J
cwnUMk4tRWM+u+ELTFq8vQc/juBIhIk8ADg7nOybYJ6qBSq3cQkKDv+D5BBxvgKn
FxI4l0JdiAmqWcT4tlwPgYGq0tN9/LGanS5UczICmfjI+tpNwbBfPRB57W+bihww
XPoeg2I8z3Uw2/lQpfDSMB334SfpH02KG/VMBbPNn6ODdye4hcgchs6a83hbiBN2
MvXU0Wwn2swlzc74UtFwvp8DDxOw83+aEI8XEZO/B4i87p8Odcg=
=gnZE
-----END PGP SIGNATURE-----

--XCAWwTQADTZzNDLi--
