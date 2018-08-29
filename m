Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD7B1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 23:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeH3DVe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:21:34 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38382 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbeH3DVe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Aug 2018 23:21:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B07760428;
        Wed, 29 Aug 2018 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1535584936;
        bh=Va4mwhJRGgLX/sy4ZaXm5xAZ2X+2w0vBFFEj7hj1rN0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QDU5y7oKu+uN6FL7EvUF8H68p34hpYXsDKV2J4ElJPfolPJofaiSQtsUmC3blNHdo
         Nfy+3Bq/eNt8Mri19xd4kjOWQdbfZqXFRpZoht0oioQF4ZiMKYepjjPk6tIseyNdNy
         r8W+WaAgyapyMlBM5K6rY0C3I6hilJDTsmV5Ml0v6us6Fr9FzTin7zVbIVaiUWv3ED
         8qwzIAOUnE5gmAggKX8p7UzB3U+TPPSzCsUXcf67aBh+KfeWLeGOvyqU2CKqbTUh/3
         72ArxNU98PDBi2uMFILan75U9ZAhOu3614XPph/9pQFHecl10oskPztwmrLL2Jo/c3
         ZIc1GRrYhStU+nBUKpB1pWF1qhGe86jlc/xzTeg6qSbQqZAcnfGxJ0HlnJLLC8VvUq
         VMZbQfb3ou+NfSC5zL86he4+uUb4l5m2qpzf4RY99XKLmDnN4azKiW2a2Ju8rinYhA
         QBii2WbPwZOg3OZ5/Mx0yTCk2t99QL7Qz8lYZMVAbUu8vDwMpjX
Date:   Wed, 29 Aug 2018 23:22:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 01/11] t: add tool to translate hash-related values
Message-ID: <20180829232211.GF432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-2-sandals@crustytoothpaste.net>
 <20180829040548.GB197350@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20180829040548.GB197350@aiede.svl.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 28, 2018 at 09:05:48PM -0700, Jonathan Nieder wrote:
> >                                Add two additional helpers,
> > test_oid_cache, which can be used to load data for test_oid from
> > standard input, and test_oid_init, which can be used to load certain
> > fixed values from lookup charts.  Check that these functions work in
> > t0000, as the rest of the testsuite will soon come to depend on them.
> >
> > Implement two basic lookup charts, one for common invalid or synthesized
> > object IDs, and one for various facts about the hash function in use.
> > Provide versions for both SHA-1 and SHA-256.
>=20
> What do test_oid_cache and test_oid_init do?  How can I use them?
>=20
> Judging from t0000-basic.sh, the idea looks something like
>=20
> 	Add a test function helper, test_oid, that ...
>=20
> 	test_oid allows looking up arbitrary information about an object format:
> 	the length of object ids, values of well known object ids, etc.  Before
> 	calling it, a test script must invoke test_oid_cache (either directly
> 	or indirectly through test_oid_init) to load the lookup charts.
>=20
> 	See t0000 for an example, which also serves as a sanity-check that
> 	these functions work in preparation for using them in the rest of the
> 	test suite.
>=20
> 	There are two basic lookup charts for now: oid-info/oid, with common
> 	invalid or synthesized object IDs; and oid-info/hash-info, with facts
> 	such as object id length about the formats in use.  The charts contain
> 	information about both SHA-1 and SHA-256.
>=20
> 	So now you can update existing tests to be format-independent by (1)
> 	adding an invocation of test_oid_init to test setup and (2) replacing
> 	format dependencies with $(test_oid foo).
>=20
> 	Since values are stored as shell variables, names used for lookup can
> 	only consist of shell identifier characters.  If this is a problem in
> 	the future, we can hash the names before use.
>=20
> 	Improved-by: Eric Sunshine <sunshine@sunshineco.com>
>=20
> Do these always use sha1 for now?  Ah, t0000 answers but it might be
> worth mentioning in the commit message, too:
>=20
> 	test_set_hash allows setting which object format test_oid should look
> 	up information for, and test_detect_hash returns to the default format.

I'll expand the commit message.  They do use SHA-1 for now, but I have a
branch that makes them use SHA-256 instead.

> [...]
> > --- /dev/null
> > +++ b/t/oid-info/hash-info
> > @@ -0,0 +1,8 @@
> > +rawsz sha1:20
> > +rawsz sha256:32
>=20
> Can there be a README in this directory describing the files and format?

Sure, if you like.

> [...]
> > --- a/t/t0000-basic.sh
> > +++ b/t/t0000-basic.sh
> > @@ -821,6 +821,41 @@ test_expect_success 'tests clean up even on failur=
es' "
> >  	EOF
> >  "
> > =20
> > +test_oid_init
>=20
> Can this be wrapped in test_expect_success?  That way, if it fails or
> prints an error message then the usual test machinery would handle it.

Sure.

> > +
> > +test_expect_success 'test_oid provides sane info by default' '
> > +	test_oid zero >actual &&
> > +	grep "^00*$" actual &&
>=20
> nit: can save the reader some confusion by escaping the $.

Good point.

> > +	rawsz=3D"$(test_oid rawsz)" &&
> > +	hexsz=3D"$(test_oid hexsz)" &&
>=20
> optional: no need for these quotation marks --- a command substitution
> assigned to a shell variable is treated as if it were quoted.

That's good to know.  I will honestly say that looking through the Git
codebase and getting reviews on the list has taught me huge amounts
about the intricacies of shell.

> [...]
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -1155,3 +1155,47 @@ depacketize () {
> [...]
> > +test_oid_cache () {
> > +	test -n "$test_hash_algo" || test_detect_hash
>=20
> Should this use an uninterrupted &&-chain?

Yes.  Will fix.

> > +	while read _tag _rest
>=20
> This appears to be the first use of this naming convention.  I wonder
> if we can use "local" instead.

We probably can.  There was a discussion about this elsewhere, and we
determined that it's probably safe, and if it's not, it should be
relatively easy to back out.

> > +		esac &&
> > +
> > +		_k=3D"${_rest%:*}" &&
> > +		_v=3D"${_rest#*:}" &&
> > +		{ echo "$_k" | egrep '^[a-z0-9]+$' >/dev/null ||
> > +			error 'bug in the test script: bad hash algorithm'; } &&
> > +		eval "test_oid_${_k}_$_tag=3D\"\$_v\"" || return 1
>=20
> This is dense, so I'm having trouble taking it in at a glance.
>=20
> I think the idea is
>=20
> 		key=3D${rest%%:*} &&
> 		val=3D${rest#*:} &&
>=20
> 		if ! expr "$key" : '[a-z0-9]*$' >/dev/null
> 		then
> 			error ...
> 		fi &&
> 		eval "test_oid_${key}_${tag}=3D\${val}"

Yes.  I take it that you think that's easier to read, so I'll rewrite it
that way.  I will admit a tendency to write code that is more compact,
sometimes (unintentionally) at the cost of readability.  Thanks for
providing a sanity check.

I agree that expr is probably better than the echo and egrep.

> > +	done
> > +}
> > +
> > +test_oid () {
> > +	eval "
> > +		test -n \"\${test_oid_${test_hash_algo}_$1+set}\" &&
> > +		printf '%s' \"\${test_oid_${test_hash_algo}_$1}\"
> > +	"
>=20
> I'm also having trouble taking this one in.  Maybe splitting into two
> evals would work?
>=20
> 	var=3Dtest_oid_${test_hash_algo}_$1 &&
>=20
> 	eval "test -n \"\${$var+set}\"" &&
> 	eval "printf '%s\n' \"\${$var}\""
>=20
> What is the initial test meant to do?  Can this function get a
> documentation comment?  Are we relying on "test -n" to return a failing
> result if the variable is unset, or could the test be omitted (relying
> on "\${$var}" to evaluate to "" when the variable is unset)?  Should
> this call 'error' when the variable is unset?

Yes.  The test -n will return false if the variable is unset, since
${$var+set} evaluates to nothing if the variable is unset and "set" if
it is set.  I will admit that I had to look this up in the shell
documentation, so I'm not surprised that this is confusing at first
glance.

Switching to error is probably better.

> Can t/README describe the new test helpers?

Sure.  I wasn't aware that there was one to add this to, but now that
you've pointed it out, it makes sense to add them.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAluHKqIACgkQv1NdgR9S
9ouojxAAgFRXRlFEPF+NFaMTQct/JV02MuCxzkRjbvjf8OHz3KZvDvg2+tU4pqBr
rmJhzI6uaTgB7u6Vc3euWezovhVp01jMqCsBwOONp4S6+uGjG9B8tLSzg6WcL4AI
6+gEO7ikYOqk7k1hcsB146zTkFrPmb7APUyKlgmE2ZE/gHTv+qugjw3fnxJQexr6
PjiG5pmArisRP8OLLlsLxDjTzZ8KWTlaDb/M4sqBi7jah0KXISBZbc7E3VBvZzEc
rOcP5iHBe8zC6IzBCNs4OcISqb5a6SroVh/nYf2SOvgvwhlCd28s3oo4n6CKux+K
CMGWzkXyQFEMm/bt1ciezaJ7I4cQMd3Al+JcoF54WYwjQHJO7b9yHNCh91AeQ+kW
OAapNTnYBY0DPJv++Ndr4LRqdz/IVf4e3qun2CF+KHewrkM53pe+VkbqImAvjRHj
MfyzrO8RJ+eJ0TzN+JgmKYcDJJK9sz9VZ2J8NdtqL5PDHfNmK4u4MHOdB4b4EVGa
payDBxzxe/T9k/wW6p7gnxdONeEcz+ENeEAm00lSDF6NiXpo7Uf4Hw05WnZJkYKd
JgpfBYVSVko88rfQmqd7avTnYtUxaaABAyn7BcJ+pxL3Vd8sOnXVEC0aAl0ISKIY
FIkquHvJNShPGijOyqX2JkZJN2xPp65qwsWsXyB4Immvn6AMKkA=
=nE4o
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
