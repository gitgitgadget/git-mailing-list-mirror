Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E93DD1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeHTBD1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:03:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55318 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbeHTBD1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 21:03:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2E7E96047A;
        Sun, 19 Aug 2018 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534715428;
        bh=lNu+BBUGDfiuVRv2VDMODu8lCUciUjk6LtTzGnyuVbk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dyEOIT9QzyIff8bn0/+Cqw9hdRIBH2IIJYhChSa9I1UUgbH4pNclT5O2LHB7ifbja
         GEFczvt4/gmRM2s2SMhYXQ92kauxTr6PzIcHNJpwozqbQi9f0Xp+FKPv7uY9iPJxdD
         RrS7woGxvLdrK3+XHDXVkku1046DXHZhO4OShWsmOosPnwAnyUgC3v6YT6+kLKII4g
         ecJj2XToE1cWStrTz7seKgfiQOD6QaN7celmRyKbgpJDvsfhfMjIzmF8o16pxdIx1x
         NvrLqADx/TF2aHmLr4aX9TQoDpfwueYgQ3P9dYIa/Qd2sOUx0ua0rueIDYRzNThqYk
         Dm4HMlkiKKbY+m9LI0ShR7gXfjRinA1w7AEOVyI6kkdFyIx+8y6JEeyM0CHI99HqVn
         EkfQPP0VEPuswoP/GJbjZ8SXaoe/qY/angxyQ5sP8sco2aji/yqw3I8Ful8DHj6M/+
         SrNeVcynnRimjx4D5qLb65dNzLO38TohybDHwVktryu66/Ox8Sz
Date:   Sun, 19 Aug 2018 21:50:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/11] t: add tool to translate hash-related values
Message-ID: <20180819215022.GH70480@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
 <20180819175351.449973-2-sandals@crustytoothpaste.net>
 <CAPig+cRZsJ00wNW08-jxmD=aW0V1hJJYEa9EVTMQT4=r0B+jeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <CAPig+cRZsJ00wNW08-jxmD=aW0V1hJJYEa9EVTMQT4=r0B+jeQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2018 at 03:40:22PM -0400, Eric Sunshine wrote:
> On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/t/oid-info/oid b/t/oid-info/oid
> > @@ -0,0 +1,29 @@
> > +# All zeros or Fs missing one or two hex segments.
> > +zero_1         sha1:000000000000000000000000000000000000000
> > +zero_2         sha256:000000000000000000000000000000000000000000000000=
000000000000000
> > +zero_2         sha1:00000000000000000000000000000000000000
> > +zero_2         sha256:000000000000000000000000000000000000000000000000=
00000000000000
>=20
> Too many zero_2's. I guess the first one should be zero_1.

Ah, yes, you're right.

> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > @@ -821,6 +821,35 @@ test_expect_success 'tests clean up even on failur=
es' "
> > +test_oid_cache hash-info oid
> > +
> > +test_expect_success 'test_oid_info provides sane info by default' '
>=20
> Is "test_oid_info" in the test title outdated? I don't see anything by
> that name. Same question regarding the other new tests.

Probably.

> > +       test_oid zero &&
> > +       test_oid zero >actual &&
>=20
> If the lookup "test_oid zero" fails, it's going to fail whether
> redirected or not, so the first invocation can be dropped.

Right.  I think that might have been a debugging statement.  Will fix.

> > +       grep "00*" actual &&
>=20
> Do you want to anchor this regex? ^00*$

I could.  That would probably be a bit more robust.

> > +       test "$(test_oid hexsz)" -eq $(wc -c <actual) &&
> > +       test $(( $(test_oid rawsz) * 2)) -eq "$(test_oid hexsz)"
> > +'
>=20
> If $(test_oid rawsz) fails to find "rawsz" and returns nothing, this
> expression will be "*2", which will error out in a
> less-than-meaningful way. Perhaps it would make more sense to dump the
> results of the two test_oid() to file and use test_cmp()?
>=20
> Similar comment regarding all the other "test ... -eq ..." expressions
> here and below: I wonder if it would be better to dump them to files
> and compare the files.

I think what I'd like to do instead is store in a variable and make
test_oid return unsuccessfully if the value doesn't exist.  I think
that's better for writing tests overall and will accomplish the same
goal.

> > +test_expect_success 'test_oid_info can look up data for SHA-1' '
> > +       test_detect_hash sha1 &&
> > +       test_oid zero >actual &&
> > +       grep "00*" actual &&
> > +       test $(wc -c <actual) -eq 40 &&
> > +       test "$(test_oid rawsz)" -eq 20 &&
> > +       test "$(test_oid hexsz)" -eq 40
> > +'
> > +
> > +test_expect_success 'test_oid_info can look up data for SHA-256' '
> > +       test_when_finished "test_detect_hash" &&
>=20
> Should the previous test also do this test_when_finished() to protect
> against someone coming along and re-ordering them some day? Or someone
> inserting a test between the two?

Yeah, that sounds like a more robust solution.

> > +       test_detect_hash sha256 &&
> > +       test_oid zero >actual &&
> > +       grep "00*" actual &&
> > +       test $(wc -c <actual) -eq 64 &&
> > +       test "$(test_oid rawsz)" -eq 32 &&
> > +       test "$(test_oid hexsz)" -eq 64
> > +'
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > @@ -1147,3 +1147,39 @@ depacketize () {
> > +test_detect_hash () {
> > +       if test -n "$1"
> > +       then
> > +               test_hash_algo=3D"$1"
> > +       else
> > +               test_hash_algo=3D'sha1'
> > +       fi
> > +}
>=20
> Mmph. Outside of t0000, do you expect other callers which will need to
> set the hash algorithm to an explicit value? If not, this sort of
> polymorphic behavior adds extra, perhaps unnecessary, complexity. Even
> if you do expect a few other callers, a dedicated test_set_hash()
> function might be clearer since test_detect_hash() has a very specific
> meaning.

I'm not anticipating one.  I can split it out into a separate function.

> > +test_oid_cache () {
> > +       test -n "$test_hash_algo" || test_detect_hash
> > +       if test -n "$1"
> > +       then
> > +               while test -n "$1"
> > +               do
> > +                       test_oid_cache <"$TEST_DIRECTORY/oid-info/$1"
>=20
> What is the benefit of placing test-specific OID info in some
> dedicated directory? I suppose the idea of lumping all these OID files
> together in a single oid-info/ directory is that it makes it easier to
> see at a glance what needs to be changed next time a new hash
> algorithm is selected. However, that potential long-term benefit comes
> at the cost of divorcing test-specific information from the tests
> themselves. I imagine (for myself, at least) that it would be easier
> to grok a test if its OID's were specified and cached directly in the
> test script itself (via test_oid_cache <<here-doc). I could even
> imagine a test script invoking test_oid_cache<<here-doc before each
> test which has unique OID's in order to localize OID information to
> the test which needs it, or perhaps even within a test.

Putting them in a separate directory makes it possible to do something
like this:

   (cd t && ./t0002-* --verbose)

and then use shell editing to change the command line.  If we put them
in the same directory as the tests, we make developers' lives a bit
harder.

You mentioned the desire to experiment with additional hash algorithms
as a hope for this series.  I don't know if that's still something
desirable to have, now that we've decided on SHA-256, but I felt it
would make it easier to find all the places that need updating.

Since you seem to have a strong preference about keeping them in the
test script, I'm happy to make that change unless other people have
strong feelings one way or the other.

> So, I'm having trouble understanding the benefit of the current
> approach over merely loading OID's via here-docs in the test scripts
> themselves. Perhaps the commit message could say something about why
> the current approach was taken.

I can do that.  The idea is that we have lots of common uses of certain
values that will need to be loaded, and it's better to load some of
those values from a file.  I felt it would be ugly to have to write out
the full "$TEST_DIRECTORY..." piece every time.

> > +                       shift
> > +               done
> > +               return $?
>=20
> Why, specifically, return $? here, as opposed to simply returning?

A simple return is probably better.  I think I wasn't clear on whether
POSIX required a bare "return" to return $? and may not have been online
at that time to look.  I remember being very clear that I didn't want to
return 0 unconditionally, though.

> Mmph. This polymorphic, recursive behavior in which test_oid_cache()
> can load data from a list of files or from its own standard input adds
> complexity. One alternative would be to have a separate
> test_oid_cache_file() function. However, I'm wondering why such
> functionality needs to be built in, in the first place, as opposed to
> clients merely doing the redirect themselves (test_oid_cache
> <whatever). I see that you want to support specifying multiple files
> for a single invocation, but is that likely to come up (aside from
> t0000)?

I expect that we are going to have a lot of uses of the hash-info and
oid files.  A separate command should be fine.

> > +       while read _tag _rest
> > +       do
> > +               case $_tag in \#*)
> > +                       continue;;
> > +               esac
>=20
> This handles "# comment" lines, but what about blank lines?

Good catch.

> > +               _k=3D"${_rest%:*}"
> > +               _v=3D"${_rest#*:}"
>=20
> Should this be doing any sort of validation, such as complaining if _k
> or _v is empty? Or if _k contains weird characters?

_v could be validly empty in some cases.  _k is probably worth checking.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlt55h4ACgkQv1NdgR9S
9otcSQ//d5HH0QfjefgjzCT1KlGGTJRFGOmArf+Ngh/5KNQ+BlOgKkbkUkF+IpjV
r+uzG+P+U+G8z1fTeNPTQYyywu8uiww+ZWfl21OXtaWItMQ59yO4GAp9Bxhb4+kq
/e5vXlZGIyLK3Nz5xTIh2xUNOBZ76YQOHGT8D5GQ36NXsH4kDJY+MSUPtJu7Egcr
0pVwddYJf3F9gW+SiYi6jwoGI+wPw7901bukh9SSo2ja4Ct4Cjc/G88AIeqCq/wv
gVQtdN6ZHa5P8b7IR+5+Dl3L1s38xv6e1iXX8Bq5mFzrz9xm8S3tD+BD2ifoZ/r2
s9YbkNotGzXRwMNCY/S+AFXKYlF8o++kn/B4vzaIQwD2iOYOKB2SMyjwImYHknEf
nGY8cZFnCIrjMwG5aOp9eVae4yt9Lpb24lVQp8mWeOcwLmoYut8L5CpEjI9bCgd6
fdySiCgvUkcnCjZRlU4VrZlLBwEcmTGUeWENEr1QmQGK42p5ByWbD1wPYqYv4I79
ve68tCkorO25qbbaGJkzkyM5MbcJcy6vrseOyGGCunCIutrCceLSRDytyQ+nELj1
2a6qjs9QegKZJVUObbd8NCfVTpLi1ro0xWOnjiVIwWEj6m2ejrNtTTzcqGadFFRT
0kC6RWTztfeYuRFtYiFsWMatMKjwVMxDu4ai3mmgOQ1ggog59Pc=
=nt1A
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--
