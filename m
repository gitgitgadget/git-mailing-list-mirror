Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F0ECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 00:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIVAId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 20:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiIVAIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 20:08:32 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD0A00E8
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 17:08:29 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 81B275A0EA;
        Thu, 22 Sep 2022 00:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663805308;
        bh=ctd1drrVZY+Cl7SDJVT1bcGYN2+itmXr3lIuFLDUiUQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=l+PVj/eRL0H5EeX4cCXvlyaeR3HzL5DbHlEY2MiAjxFF03WyiIp2BtY9gSGZmp7hw
         7UAJAGiSKUymnZRZFzkkSrcOW0sXiiC5tMmcmJvLy8wUc3mKePKzU2b2OxDmYZbSY1
         uUm6hQRb2XL1Kc+n94dfysdkzDGqRwlpeB8xeiS7PVH4CyjjJ6iOADSTBmLOy4WZ5u
         T6a3nXpBF1+jcGaotC90zQDp6qdcUkDoadzHOrNpyeO/oJ3/N7l2Jp3jVopeq5fPD0
         fk04u9XhMS/SkMA8Egz9E8nkW2eu55ZdM7JSpJTD2PFekV68h4vj2S90tj+JTYqGrZ
         e9eAxljgFa57AjpvCeh3et5kZUNNVk4arpK8xCDNMCPYx//lyFiiD8rtxiFlW5SQQA
         q9sIVYsBU4GGmFWVsi5JyzoD2t8Qh4Fpzw6aXpcJWZ2s9/LodXJxFSttfI2KSRhqGh
         pJUiKcdnhVcDb1L3KnXbHjCIBi3LebG+2p0iLRhxPa7sO4wSUYW
Date:   Thu, 22 Sep 2022 00:08:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/2] docs: document a format for anonymous author and
 committer IDs
Message-ID: <Yyune8ZNhWGWaTf2@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220919145231.48245-1-sandals@crustytoothpaste.net>
 <20220919145231.48245-3-sandals@crustytoothpaste.net>
 <220920.86a66u5mnt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P8gRee6otOz9Ku2o"
Content-Disposition: inline
In-Reply-To: <220920.86a66u5mnt.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--P8gRee6otOz9Ku2o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-20 at 10:51:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Wouldn't we get the same thing if *by convention* we just supported
> authorship like this, (which we already support):
>=20
> 	UUID=3D$(get-some-uuid)
>         git config user.name X
>         git config user.email $UUID.uuid.git.example.org

You can indeed use a UUID if you want.  However, it's not deterministic.

Using a key hash also means account linking is trivially implemented in
forges.  If we use a UUID, then there's no way to prove ownership of the
identifier, which means that people can claim other people's commits.
Signed commits don't help here because you can't embed arbitrary
non-emails in X.509 (or in OpenPGP, because nobody will certify such an
ID), so you have no way of linking the commit identity to the key and
therefore signed commits are worse than before.  At least with an email
you can verify that the owner of the account owns the email address, but
you can't do that with a UUID.

I want a design that works whether or not you use a forge, but realizing
that most developers use forges these days, I want to make the workflow as
simple and straightforward as possible for those who do.  I also want a
design which is going to be acceptable to forge implementers, and
working for one, I think this design is going to be easier to implement
and more likely to be accepted than an ID which requires extra work and
isn't verifiable.

For ease of use, I would be implementing tooling to make setting this
=66rom an existing user.signingkey or SSH key on the system.  I literally
envision this being as simple as something like `git id --set -f
~/.ssh/id_ed25519` or `git id --set --generate-ssh-key`.  (This is just
an example; we can argue about the details later.)

> So you'd end up with e.g.:
>=20
> 	X <98ab8d66-38d2-11ed-a261-0242ac120002.uuid.git.example.com>
>=20
> Or whatever, we could bikeshed about the format, but the point is that
> it's not codifying *how* that looks.

I do very much want to codify how this looks because people are
absolutely going to rely on it, whether we want them to or not.  People
already parse GitHub's fake no-reply emails for information.  Everything
that Git does people rely on, whether we like it or not.

Keeping it in the form of an email maximizes compatibility for existing
implementations.

> We'd then just support this refs/mailmap mechanism you're suggesting,
> where we'd have a mapping like:
>=20
>       =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> X <98ab8d=
66-38d2-11ed-a261-0242ac120002.uuid.git.example.com>
>=20
> Which could be force-pushed.
>=20
> I can see why you'd *also* want to formalize the ID generation, but I
> just don't see why we'd want to make that as one leaping change rather
> than something more incremental.

We can make it as incremental as folks want.  However, the longer we
have people embedding their real names and emails in an immutable Merkle
tree, the longer we're going to run into deadname problems.  Thus,
encouraging this new form of ID sooner means that people will adopt it
sooner.

If this is the only impediment, we can make it more gradual.

> I.e. even if you don't have opaque IDs in the first place this mechanism
> would allow you to maintain a "mailmap" ref on the remote, which would
> already be useful.
>=20
> E.g. now if I use a hosting provider and have my .mailmap in various
> repo I need to maintain then in each repo, but this would allow for a
> magical ref which would keep it up-to-date in various repos...

That's part of the goal.

> I obviously see why you want the "force push" aspect of this (the
> deadnaming), but I still wonder if it's really a good trade-off for git
> as an SCM to make that the default.
>=20
> We've been going in the other direction for e.g. tags semi-recently with
> my 0bc8d71b99e (fetch: stop clobbering existing tags without --force,
> 2018-08-31).
>=20
> By having that force-push default we make it so that a plumbing command
> (that makes use of mailmap) will give you one result today, but a
> different one tomorrow, with no easy way to get back.

I think force-pushing semantics has a nicer behaviour for my use case,
but it's not essential.  If the mailmap is in a separate ref, then if I
work at $MEGACORP and need to update the mailmap because of a name
change, I can still just rewrite the history, and as long as we preserve
the force-fetch behaviour by default, then it will just work.

I _do_ think we should retain the force-fetch behaviour by default.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--P8gRee6otOz9Ku2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYyunewAKCRB8DEliiIei
gchqAQDyeG5iO+UbZxHkJppFyjcglTjnVsHjVEQPvL3ADm0+WQEAs5R6vkoAD2b7
GAzNHgCMVnV8ljezsyNxT0zViz5zSQ0=
=E0IT
-----END PGP SIGNATURE-----

--P8gRee6otOz9Ku2o--
