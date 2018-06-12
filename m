Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298F11F403
	for <e@80x24.org>; Tue, 12 Jun 2018 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934905AbeFLBFW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 21:05:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37624 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933495AbeFLBFU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jun 2018 21:05:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2B5CD60129;
        Tue, 12 Jun 2018 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528765519;
        bh=6JbpXs7b3QCzwB4xBp2IYvkzoq08oI4dQcp3v0/WKT0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=V+UooNOULp8F3lN6lJjm0f30AnrOOkBf0ZcoGqpWCcic5DBrmFfAh++jD1ER4gjHG
         sSMztQ0lcEalRIDNZnsU+HF+Vnw7a321gz5kDnC/nBeCasw20XL86Dq4prm6K/HELZ
         umSty+Ttj3KJ3hBvsqrfIn3Luq91AUIqWwht0rWvVt1z3eTn2vQUsTAx3/McSZ2L6R
         S7woOC4U1pzZWo5DI0kh14h9j9pvnkM7+7/wBh+VOeRu/AaxHNl17mb8fZ4XVCb16L
         pc7fDrsJh/qQoIQpT2TyPTn+Zz9x2YfeNidslEfaoZ7FQOG/BUIC7jChr/YdvPPE/8
         HeSF8tScibZ1xiRGNIqyNdA0v/4hqtlwdu00IxUmPBeYmYBGdbWxmmwpnNbdWI7HAP
         r3huxdGLcNUGIZsc142q58hRAf4jUFxRWTTvPKv7SPxz9JWRIvsK6CvmiAiz/ThPM1
         IMV1tm8/RcgXb1Rtiz1hYDtwltay6JlkW6iub1tuC2Z3/IbAkS3
Date:   Tue, 12 Jun 2018 01:05:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180612010513.GH38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
 <20180611074743.GA24066@flurp.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kHRd/tpU31Zn62xO"
Content-Disposition: inline
In-Reply-To: <20180611074743.GA24066@flurp.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kHRd/tpU31Zn62xO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 03:47:43AM -0400, Eric Sunshine wrote:
> On Mon, Jun 04, 2018 at 11:52:20PM +0000, brian m. carlson wrote:
> > Add a test function helper, test_translate, that will produce its first
> > argument if the hash in use is SHA-1 and the second if its argument is
> > NewHash.  Implement a mode that can read entries from a file as well for
> > reusability across tests.
>=20
> The word "translate" is very generic and is (at least in my mind)
> strongly associated with i18n/l10n, so the name test_translate() may
> be confusing for readers. Perhaps test_oid_lookup() or test_oid_get()
> or even just test_oid()?

test_oid would be fine.  One note is that this doesn't always produce
OIDs; sometimes it will produce other values, but as long as you don't
think that's too confusing, I'm fine with it.

> This is a very expensive lookup since it invokes a heavyweight command
> (perl, in this case) for *every* OID it needs to retrieve from the
> file. Windows users, especially, will likely not be happy about this.
> See below for an alternative.

I agree perl would be expensive if it were invoked frequently, but
excepting SHA1-prerequisite tests, this function is invoked 32 times in
the entire testsuite.

One of the reasons I chose perl was because we have a variety of cases
where we'll need spaces in values, and those tend to be complex in
shell.

> This is less flexible than I had expected, allowing for only SHA1 and
> NewHash. When you had written about OID lookup table functionality in
> email previously, my impression was that the tables would allow values
> for arbitrary hash algorithms. Such flexibility would allow people to
> experiment with hash algorithms without having to once again retrofit
> the test suite machinery.

I wasn't thinking of that as a goal, but that would be a nice
improvement.

> Here's what I had envisioned when reading your emails about OID lookup
> table functionality:
>=20
> --- >8 ---
> test_detect_hash () {
>     test_hash_algo=3D...
> }
>    =20
> test_oid_cache () {
>     while read tag rest
>     do
>         case $tag in \#*) continue ;; esac
>=20
>         for x in $rest
>         do
>             k=3D${x%:*}
>             v=3D${x#*:}
>             if test "$k" =3D $test_hash_algo
>             then
>                 eval "test_oid_$tag=3D$v"
>                 break
>             fi
>         done
>     done
> }
>=20
> test_oid () {
>     if test $# -gt 1
>     then
>         test_oid_cache <<-EOF
>         $*
>         EOF
>     fi
>     eval "echo \$test_oid_$1"
> }

Using shell variables like this does have the downside that we're
restricted to only characters allowed in shell variables.  That was
something I was trying to avoid, but it certainly isn't fatal.

> test_detect_hash() would detect the hash algorithm and record it
> instead of having to determine it each time an OID needs to be
> "translated". It probably would be called by test-lib.sh.

We'll probably have to deal with multiple hashes in the future,
including for input and output, but this could probably be coerced to
handle that case.

> And, when specifying values from which to choose based upon hash
> algorithm:
>=20
>     $(test_oid bored sha1:deadbeef NewHash:feedface)

This syntax won't exactly be usable, because we have to deal with spaces
in values.  It shouldn't be too much of a problem to just use
test_oid_cache at the top of the file, though.

> A nice property of how this implementation caches values is that you
> don't need test_oid() for really simple cases. You can just access the
> variable directly. For instance: $test_oid_hexsz

Because we're going to need multiple hash support in the future, for
input, output, and on-disk, I feel like this is not a good direction for
us to go in the testsuite.  Internally, those variable names are likely
to change.

> Another nice property of how caching is implemented is that someone
> testing a new hash algorithm doesn't have edit the existing tables to
> tack the value for the new algorithm onto the end of each line. It
> works equally well to place those values in a new file or new here-doc
> or simply append new lines to existing files or here-docs. For
> instance, someone testing algorithm "NewShiny" can just add those
> lines without having to modify existing lines:

That would be convenient.

I like a lot of things about your implementation.  This has been helpful
feedback; let me think about it some and reroll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--kHRd/tpU31Zn62xO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsfHEkACgkQv1NdgR9S
9otq1w/+O8sQh8l9WzFVo2XR0w12cCM/oUV/A39h69Kc9i3ZDEw6pKItw+VsXDG5
ktFBtGKUx0wMmdXdJChDQbHA4ftYI/0CcUh6JQI0JPu8ee+ACNOIMZ6QUDxxxF7D
VUASknnt7QjrFeXRmE/G4K10gOUECOqziGEVxb0EY3Q6599YZQuX4KiI07PDpfO8
VMqJa1z8qbYAREKY/kG0YGa2DJfdEn4VaQyoSmX4ikJZUDMq2yWMQ0xlPmskp9Np
HcQENSmfRgs02eUWGnNjfmtPugXMmPmMM4DoTOQX20u2tBqG8lcM8b1HbvAGDeO2
qmW7UvoOiegPovi1ycs9G0Q3NCEn19GYySbl1GTbGzshLRE+5gmUayA32KhOYGoq
CSc1315ZpoM5gZ+N31rJbUJQEwvca+856rctEolLdyQKcVhUk4NKPFMa+lPnKX6A
WfSPQdQ/bpY7X7KX7KCT/B+CHarwGnm91xMPyB/9Eo7/FZHxPDp+zJVhMGTnEN/m
Uk455cMvjjaM+4kHl1nd+NrMgGZkWU6zMFKEEywLijZAB+XhHjNqQT8deYc2oKRp
gw5qLgYxPuonHFBUNr6GpAgf/jzEPxm2P6KZnr/OKqxoCmEVobYF3QDTpr8Scq1c
/+I10Y1kB4A8bEC6gYTDi8BxooT0fn5k+RL58GtcFLqA4dLrTZc=
=bjhy
-----END PGP SIGNATURE-----

--kHRd/tpU31Zn62xO--
