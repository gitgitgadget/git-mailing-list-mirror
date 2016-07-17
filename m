Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28ED82018F
	for <e@80x24.org>; Sun, 17 Jul 2016 22:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbcGQWEc (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 18:04:32 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59236 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751364AbcGQWEZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2016 18:04:25 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 71AB8282AF;
	Sun, 17 Jul 2016 22:04:22 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468793062;
	bh=4dUko42HaIKvioNwQNy8XuL1OHbx9yhCANVVHnVCMbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vjt8jfCOTi4mo4NoCSyx3Y1JM6PJgjQec917ON/l4EFBbKBG3uMrJMmdAIcKr+2jU
	 4TlYpqFMnl0Gi3YWAadQP6QlI/lfiAJ/xb8W8WZvXP8jyymnvnByO6I2jXTGyepUSL
	 QNAia6XyjOSVrn2P3uOyzd3o/Zd7gGFJ/ktTpibyjWfCMiuYtwKYHRZeYh37lYdwdS
	 hFufxVYxsvjJ+dU0BgGXfMg+QlSLwAsHALuL+020vth06OiMcj1wKsKv4150ZFMEKZ
	 EvGdtps2HmmrGGzg+e/nNFFiCq0mE3wp7xqfiZPhrPK7zatq+Zc8j+3A5+vv88PuZR
	 cnneLc3O/n+uN2YmSmF8B7xjYMLrtJgc5841+yscU/WN37I80I/amfi0REm/R+wEUW
	 k66ILD6sxemUpqWFNoGpRTPrW2hbxI5INYxliEzfGxoVnkHDEodJQqsLie7Y+bYpEW
	 s9biyoojnHbZtUJZMXpS5yJDPNY1S/9pjKPB6dI97C37VcM11tT
Date:	Sun, 17 Jul 2016 22:04:17 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Theodore Ts'o <tytso@mit.edu>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160717220417.GE6644@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net>
 <20160717162349.GB11276@thunk.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20160717162349.GB11276@thunk.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 17, 2016 at 12:23:49PM -0400, Theodore Ts'o wrote:
> On Sun, Jul 17, 2016 at 03:42:34PM +0000, brian m. carlson wrote:
> > As I said, I'm not planning on multiple hash support at first, but it
> > doesn't appear impossible if we go this route.  We might still have to
> > rewrite objects, but we can verify signatures over the legacy SHA-1
> > objects by forcing them into the old-style object format.
>=20
> How hard would it be to make the on-disk format be multihash, even if
> there is no support for anything other than a single hash, at least
> for now?  That way we won't have to rewrite the objects twice.

Other than the amount of work to change reading from the on-disk format,
nothing prevents us from doing that, although I would recommend storing
the object database with the tag prefix if we do so (i.e., instead of
=2Egit/objects/17, writing .git/objects/111417).  That future-proofs us
for when we change the hash.

I will say that the pack format will likely require some changes,
because it assumes things are 4-byte aligned.  It also assumes you can
use the object ID in the mmaped pack directly (4-byte aligned), which
you can no longer do.  We have some cases where we cast that memory
directly to struct object_id, which will no longer be valid, and even if
we add the two prefix bytes to struct object_id, that doesn't guarantee
that struct won't be aligned differently.

We could require that the pack format have two NUL bytes before the
hash, which would force it to be aligned.  We'd still have to make the
Git protocol negotiate the new extension and fail gracefully if the
version is too old.  We could do this by requiring a pack version 5,
which would simply cause older Gits to report errors.

It's a lot of work, and it's definitely a flag day.  That's why I had
planned to only do it with a new hash format: it would impact only
people who were moving to the new hash.  It also means that we get to
work out any problems with the design at that point and not be committed
to a design that might be inadequate.  This is a place where I don't
want to mess up.

> Personally, so long as the newer versions of the tree are secured, I
> wouldn't mind if the older commits stayed using SHA1 only.  The newer
> commits are the ones that are most important and security-critical
> anyway.  It seems like the main reason to rewrite all of the objects
> is to simplify the initial rollout of a newer hash algorithm, no?

The reason is that we can't have an unambiguous parse of the current
objects if two hash algorithms are in use.  tree objects don't use a hex
encoding of hashes; they use a binary encoding.  It's therefore possible
to create an ambiguous tree representation.

So when we look at a new hash, we need to provide an unambiguous way to
know what hash is in use.  The two choices are to either require all
object use the new hash, or to extend the objects to include the hash.
Until a couple days ago, I had planned to do the former.  I had not even
considered using a multihash approach due to the complexity.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXjADhAAoJEL9TXYEfUvaLVyQP/jfRrKhR3yK/jwtdH6p6QsUr
COdDb1GywzVAML0RZgNYXm69V5Dquqb7D9NPUZYJ9WjlnPCXcHU+8yBp1diBD5ya
HwUEyPMfL+60wurpWhX63IBQW2Sp1f9ZBDHlgUv9fq6q/MP1KSGsqx4wsGQXtMEh
2wAgbe1cr7c8b2K4IJ99IS2LZ6XhRyKrGkIrUQ1hMhFF1YJx7mRd5bQcH7KirEhM
uZz/BvgLLAbZSPQ0A3HZw+7lcTesI4ZRuUSkH95zsGSN3HKxMPspxtRc1gUGi4qR
X7SCzLGJ7GF709kVhrMkyB+SzywZfaO4lD76uNOOBjqO9btTO5MR0oS/K+yNh8D5
LXDLJ/Vrlcz883kuc3wTetLAq09QlAvOQQx41dNzdnlYTs2chVKcHps7P7YjUWHo
NSr9n5SVDzrzfCP5oBJX31ySeAcacwmlpWikHnS/Q+GHzmWC/gEFQwgQbIsfYn70
0GXS+e2jXjorCSXvzITEbTXdXfpfk67MvL2UaqNJMsvwn2woFUXPaSrUnwQUv7DV
p+mbEXvYv5LCu/lQzHBvvA2Ldqd7iZYF2lP9RXvkQTB3PlezkxJyxQANc0sG57/f
ho7UzZ+9wdJJ4uhRirLyuxoS0j5vltjogA99AI1X/vfG9N5FGR/dAJspbPAwWK1+
0o/F81C3mscqLnT8rz4r
=KFkE
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
