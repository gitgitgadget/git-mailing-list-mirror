Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5111C433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 23:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3CD61074
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 23:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhDOXwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:52:21 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234865AbhDOXwV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Apr 2021 19:52:21 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8820F6042C;
        Thu, 15 Apr 2021 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618530687;
        bh=ySKE5a/YkpRiPqQXNlYyRKri6GP76XlwwKn7x/DhPQg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XerFP2satnWJrN3HPopvnMxtor7x1nz4gjaRpdabfB2mmSjgnqGsNI3keQ3Xjvebu
         DOcVZzYrJf4SOKpTp63z8ns43Ti4L0rj4MGgtPhyblhXpYFXSEO8V3jQWS2fTYsVJ2
         mZXGHLZQrSJV0UYJV10gVBcug2K2ZdRfg/B4HmNEZJTCbFE52j1fZ8oGCyHlfrfLF+
         d/M7IlE7PqgcGvtnu3XZJFf37pwU4dclurG6T7GoPHYqtqWaU4NB/CGY5dTDxGu8Kp
         yb6SxZQEAFFeQfA1VRg9xXDd55n5CudiMC2AAb/6XH379dEWw/s1DD3w8Nf7g1Ph+k
         HYEsyFWjTmhTy44vAPsyaAtVelClGzotyWNHVKf3UpvH1bgHx4EdNO6j3Jn98p3xGt
         JDh5J1ZwU5Wfvsq2m3xGmZ8KJK0rwWOKJf+KUkgpl5h/SrUCZB6rLUmBcOII84VDDf
         ePv5XeD+BTqooH/sB3GJ9ENSae151rQMOcQsE39S3BxBxP0LgEI
Date:   Thu, 15 Apr 2021 23:51:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] cache: add an algo member to struct object_id
Message-ID: <YHjReOSYlTF8XZL9@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
 <20210410152140.3525040-4-sandals@crustytoothpaste.net>
 <38f48634-077b-6351-5285-f8ecc6f552d0@gmail.com>
 <YHZApIpPBhpmwscP@camp.crustytoothpaste.net>
 <87pmyw0waj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UahcvgCK2rp+btiB"
Content-Disposition: inline
In-Reply-To: <87pmyw0waj.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UahcvgCK2rp+btiB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-15 at 08:47:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Apr 14 2021, brian m. carlson wrote:
> > I will do some performance numbers on these patches, but it will likely
> > be the weekend before I can get to it.  I think this will add 4 bytes on
> > most platforms, since int is typically 32 bits, and the alignment
> > requirement would be for the most strictly aligned member, which is the
> > int, so a 4-byte alignment.  I don't think the alignment requirements
> > are especially onerous here.
>=20
> I think if you're doing such a perf test one where we have SHA-1 mode
> with SHA-1 length OID v.s. SHA-256 (the current behavior) would be
> interesting as well.
>=20
> It seems like good SHA1s to test that are 5a0cc8aca79 and
> 13eeedb5d17. Running:
>=20
>     GIT_PERF_REPEAT_COUNT=3D10 \
>     GIT_SKIP_TESTS=3D"p0001.[3-9] p1450.2" \
>     GIT_TEST_OPTS=3D GIT_PERF_MAKE_OPTS=3D'-j8 CFLAGS=3D-O3' \
>     ./run 5a0cc8aca79 13eeedb5d17 -- p0001-rev-list.sh p1450-fsck.sh
>=20
> (I added a fsck --connectivity-only test)
>=20
> Gives us:
>=20
>     Test                               5a0cc8aca79         13eeedb5d17
>     ---------------------------------------------------------------------=
---------
>     0001.1: rev-list --all             2.46(2.22+0.14)     2.48(2.25+0.14=
) +0.8%
>     0001.2: rev-list --all --objects   10.79(10.22+0.14)   10.92(10.24+0.=
20) +1.2%
>     1450.1: fsck --connectivity-only   16.61(15.42+0.34)   16.94(15.60+0.=
32) +2.0%
>=20
> So at least on my box none of those are outside of the confidence
> intervals. This was against my copy of git.git. Perhaps it matters more
> under memory pressure.

I do plan to take a deeper look at this this weekend and do some
performance numbers, and I think these are great examples to use.  I
just have a limited amount of time most weeknights because, among other
things, I am taking French a couple nights a week.

I talked with Stolee today about this approach and the desire for
performance, so I think we're on the same page about trying to make this
as fast as possible.  I plan to try a couple alternative solutions which
may work as well (or at least, I will make notes this time about why
they didn't work) and be less impactful.

> >> I assume that we already checked what happened when GIT_MAX_RAWSZ
> >> increased, but that seemed worth the cost so we could have SHA-256
> >> at all. I find the justification for this interoperability mode to
> >> be less significant, and potentially adding too much of a tax onto
> >> both SHA-1 repos that will never upgrade, and SHA-256 repos that
> >> upgrade all at once (or start as SHA-256).
> >
> > The entire goal of the interoperability is to let people seamlessly and
> > transparently move from SHA-1 to SHA-256.  Currently, the only way
> > people can move a SHA-1 repository to a SHA-256 repository is with
> > fast-import and fast-export, which loses all digital signatures and tags
> > to blobs.  This also requires a flag day.
> >
> > SHA-1 can now be attacked for USD 45,000.  That means it is within the
> > budget of a dedicated professional and virtually all medium or large
> > corporations, including even most municipal governments, to create a
> > SHA-1 collision.
>=20
> Is that for vanilla SHA-1, or SHA-1DC?

Well, for SHA-1 in general.  SHA-1DC doesn't do anything except detect
collisions.  People can still create collisions, but we detect them.

> > Unfortunately, the way we deal with this is to die, so
> > as soon as this happens, the repository fails closed.  While an attacker
> > cannot make use of the collisions to spread malicious objects, because
> > of the way Git works, they can effectively DoS a repository, which is in
> > itself a security issue.  Fixing this requires major surgery.
>=20
> Can you elaborate on this? I believe that we die on any known collision
> via the SHA1-DC code, and even if we didn't have that we'd detect the
> collision (see [1] for the code) and die while the object is in the
> temporary quarantine.
>=20
> I believe such a request is cheaper to serve than one that doesn't
> upload colliding objects, we die earlier (less CPU etc.), and don't add
> objects to the store.
>=20
> So what's the DoS vector?

That assumes that the server is using SHA-1DC and that the object can't
be uploaded any way except a push where its hash is checked.  Those are
true for many, but not all, hosting providers.  For example, anyone
using Git in a FIPS-validated environment can only use FIPS-validated
crypto, and I'm not aware of any SHA-1DC implementations that are.
Also, some implementations like Dulwich don't use SHA-1DC.

Once someone can get that object to a standard Git which does use
SHA-1DC, then the repository is pretty much hosed.  I probably can make
this better by just dropping the non SHA-1DC mode here and in libgit2,
to at least disincentivize poor choices in the most common
implementations.

> > We need the interoperability code to let people transition their
> > repositories away from SHA-1, even if it has some performance impact,
> > because without that most SHA-1 repositories will never transition.
> > That's what's outlined in the transition plan, and why that approach was
> > proposed, even though it would be nicer to avoid having to implement it
> > at all.
>=20
> There's no question that we need working interop.
>=20
> The question at least in my mind is why that interop is happening by
> annotating every object held in memory with whether they're SHA-1 or
> SHA-256, as opposed to having some translation layer earlier in the
> chain.

This is a good question.  Let me provide an example.

When we speak the remote protocol with a remote system, we'll parse out
several object ID of the appropriate algorithm.  We will then pass those
around to various places in our transport code.  It makes it a lot
easier if we can just run every object ID through an inline mapping
function which immediately does nothing if the object ID is of the
appropriate type rather than adding additional code to keep a check of
the current algorithm that's being used in the transport code.

It also makes it a lot easier when we let people store data in SHA-256
and then print things in SHA-1 for compatibility if we can add an
oid_to_hex_output and just map every object automatically on output,
regardless of where it came from, without needing to keep track of what
algorithm it's in.  For example, think about situations where the user
may have passed in a SHA-1 object ID and we reuse that value instead of
reading a SHA-256 object from the store.

So it's not completely impossible to avoid a hash algorithm member, but
it does significantly complicate our code not to do it.

> Not all our file or in-memory structures are are like that, e.g. the
> commit graph has a header saying "this is a bunch of SHA-1/256", and the
> objects that follow are padded to that actual hash size, not the max
> size we know about.
>=20
> My understanding of the transition plan was that we'd e.g. have a
> SHA-1<->SHA-256 mapping of objects, which we'd say use to push/pull.

Correct.  That code exists and mostly works.  There are still a lot of
failing tests, but I have a pack index v3 that stores that data and a
loose object store.

> But that by the time I ran say a "git commit" none of that machinery
> needed to care that I was interoping with a SHA-1 repo on the other end.
> It would just happily have all SHA-256 objects, create new ones, and
> only by the time I needed to push them would something kick in to
> re-hash them.
>=20
> I *think* the anwer is just "it's easier on the C-level" and "the
> wastage doesn't seem to matter much", which is fair enough.

I think that's accurate.

> *Goes and digs in the ML archive*:
>=20
>     https://lore.kernel.org/git/1399147942-165308-1-git-send-email-sandal=
s@crustytoothpaste.net/#t
>     https://lore.kernel.org/git/55016A3A.6010100@alum.mit.edu/
>=20
> To answer (some) of that myself:
>=20
> Digging up some of the initial discussion that seems to be the case, at
> that point there was a suggestion of:
>=20
>     struct object_id {
>         unsigned char hash_type;
>         union {
>             unsigned char sha1[GIT_SHA1_RAWSZ];
>             unsigned char sha256[GIT_SHA256_RAWSZ];
>         } hash;
>     };
>=20
> To which you replied:
>=20
>     What I think might be more beneficial is to make the hash function
>     specific to a particular repository, and therefore you could maintain
>     something like this:
>=20
>       struct object_id {
>           unsigned char hash[GIT_MAX_RAWSZ];
>       };
>=20
> It wouldn't matter for the memory use to make it a union, but my reading
> of the above is that the reason for the current object_id not-a-union
> structure might not be valid now that there's a "hash_type" member, no?

Probably at that time we didn't have the formal transition plan and
didn't anticipate interoperability as a concern.  I do think that using
a single hash member instead of a union makes things easier because we
generally don't want to look up two different members in cases like
printing a hex OID.  We ultimately just want to print the right number
of bytes from that data, and the union just makes things trickier with
the compiler when we do that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--UahcvgCK2rp+btiB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHjReAAKCRB8DEliiIei
gcVoAQD5H0s3SHzCnfeekxc/9Uin/Cnito+L0mdf1WQL4PFwFwEA69r39VpxUSz4
3z9V0xglP75tCdLuYsRviHFgYxRerws=
=YTpt
-----END PGP SIGNATURE-----

--UahcvgCK2rp+btiB--
