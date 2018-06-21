Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19D361F516
	for <e@80x24.org>; Thu, 21 Jun 2018 22:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeFUWj2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 18:39:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43710 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933653AbeFUWj1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Jun 2018 18:39:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b0c3:20dd:704c:b59d])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BB33B6048F;
        Thu, 21 Jun 2018 22:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1529620764;
        bh=wL04ocSB5/r7GTBnUTMszJpRTYpsQnhmcVPTcXLFV98=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=fWQCyDOuVV/dNc3aW9EvKu/s9k8r6jgoNzaR1IHpc09OsihD1LOtC57ReRkYixx1f
         4sHdkpKMC5+10qq3Nz5OdYfySqfQhCMZxLytbaeGbaDnyuFSzdZOywArFVgnjiuO9v
         uiIoNCW70LShJDV/trI90iP5w2t3bOIVeGZsVnokAjFfOWO9gpMa2xUX1jL963Up0b
         v2UyPyJIc1N2lFj+/o+PkLvgt7qhtS1E6/lSDLTWcxxYKAWP+uoYf62bKVkF39adPz
         ukBv+ODQKSH781FF64J2QwTVV81drqh7T8mXjj5+BR9zmvr1zZa0ZP/gkhXGXiUQvh
         H8Sb/CpznyYP76iA4/0TRosuqTm47QEJDHb1l3oY/6KXHsFT5ezIhaoFD3DKmB148x
         UQumTH7uff3jug+svnYoeXeeCIRV6vm+FQXiSoVYAoJTi44s2RMWSEE90Z65V66MyV
         NoghWzUCvTxWoWSrt8B75k70f0DwR9DI9pQ0ZbMXfHgL6ubp4tN
Date:   Thu, 21 Jun 2018 22:39:16 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Adam Langley <agl@google.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Hash algorithm analysis
Message-ID: <20180621223916.GA787060@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Langley <agl@google.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
 <20180609224913.GC38834@genre.crustytoothpaste.net>
 <87bmchvx69.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <87bmchvx69.fsf@evledraar.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 11:19:10PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> This is a great summary. Thanks.
>=20
> In case it's not apparent from what follows, I have a bias towards
> SHA-256. Reasons for that, to summarize some of the discussion the last
> time around[1], and to add more details:

To summarize my view, I think my ordered preference of hashes is
BLAKE2b, SHA-256, and SHA3-256.

I agree with AGL that all three of these options are secure and will be
for some time.  I believe there's sufficient literature on all three of
them and there will continue to be for some time.  I've seen and read
papers from the IACR archves on all three of them, and because all three
are widely used, they'll continue to be interesting to cryptologists for
a long time to come.

I'm personally partial to having full preimage resistance, which I think
makes SHAKE128 less appealing.  SHAKE128 also has fewer crypto library
implementations than the others.

My rationale for this ordering is essentially performance.  BLAKE2b is
quite fast on all known hardware, and it is almost as fast as an
accelerated SHA-256.  The entire rationale for BLAKE2b is to give people
a secure algorithm that is faster than MD5 and SHA-1, so there's no
reason to use an insecure algorithm.  It also greatly outperforms the
other two even in pure C, which matters for the fallback implementation
we'll need to ship.

I tend to think SHA3-256 is the most conservative of these choices as
far as security.  It has had an open development process and has a large
security margin.  It has gained a lot of cryptanalysis and come out
quite well, and the versatility of the Keccak sponge construction means
that it's going to get a lot more attention.  Pretty much the only
downside is its performance relative to the other two.

I placed SHA-256 in the middle because of its potential for acceleration
on Intel hardware.  I know such changes are coming, but they won't
likely be here for another two years.

While hashing performance isn't a huge concern for Git now, I had
planned to implement an rsync-based delta algorithm for large files that
could make storing some large files in a Git repository viable (of
course, there will still be many cases where Git LFS and git-annex are
better).  The algorithm is extremely sensitive to hash performance and
would simply not be viable with an unaccelerated SHA-256 or SHA3-256,
although it would perform reasonably well with BLAKE2b.

Having said that, I'd be happy with any of the three, and would support
a consensus around any of them as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlssKRQACgkQv1NdgR9S
9ouLag/+K++QqnFDB46sCSV0IqfcDp0fglXwTSOLfi/Dc+SkvK9yFYmcNCLRfqpS
1+u4fUZJjqc7epHfSRLpXsJWqaXCL73daj+bs5BTC8RQxSExcNeZkf0mMJ0VnEvC
/6sCWmwgixiE0Xg8HRNrKCb7HnUFc/SBa8zXwpCsiX1GZWHBRvR5wqtTgY7tMhFw
zNmZhzgYqPHG6wZDgTBL0TBskqvEGO7+LS6Of+D1+7f6nj0W9DZ/+cTl2Iq0G3ou
nW1Z19+3PhDMbpZP3fuwUpKJh/rOcubd0qBmC3+y4cyNCRSJWLDeyeY70vKkNUjE
FDAtzCHj96cXtJWKPwOcGp775M3QgE+LmRjyO829Vyj7LmImQa3NAXN0NMX0wv4Q
nNStyeKcsgBlHz/g8OO387JMAeJVoQqT66l4FT+1VqWd0nwbD/FL2swdyOZtV4BX
V1L8UNUbdXxquX6DaX11LTjh6lqqOyH+8mNwTqSvkeRCvjI/agvSI5NA3ATAi3MC
HypabifoN5icppNneHSv036+Soe+cFgTr5pX8fFRLKYOYDhOVkr3m26f0xr2Io5o
Kjpe2p1lqAjjUregTy2wAFgRE+cjdDpvy0Wzo0P56zYZusWG6JOlC2/Mdi3Isc/S
gSL8j1YOWhyjrYroclpX+vWRejqMDUoIoYO9mTK0yaZlPBjgp5Y=
=FbgL
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
