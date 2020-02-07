Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC25C35247
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D111820838
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 00:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="L/zK0vl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBGAQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:16:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55488 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726543AbgBGAQT (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 19:16:19 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 50BA460791;
        Fri,  7 Feb 2020 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581034577;
        bh=khUfnGLVWVUrPHjNd1GtjuoeySy6Y70zKoRWAbeKHEI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=L/zK0vl9RK+CGhTkXixuK8JGVopJYU1HXVMrmaddq4OavySyqSv37+xnwTisUPdig
         BGGsWi0QSfIegto8m5YJf2bOpquh1wBmvON6KC8f2W8jmlawysDpKh2yFvl14IHzfk
         JjxSRkzJQnlvVrRZQhCOUwpaEbyle5HxeIkt8ZkL3FoEaz8yxUYHDL31nl6fBRND7z
         C7PWIyyW6LF/LhhC7Wv0NN8H81BfwDATWINMKG0EXxH3UN0zQ3YhZWfSiNaTZu7MWM
         NByWioUoHwHfOwESiZJkxFHl2uLouTIIcJ1VxeivsF+X5CTHLkDLHcjmF0oqiQHhgr
         kvtY4wPlSg5GNYxNGI4SiU+ZfWuyUqtqSrQNtAvPuTHk0EDkMzOBafy+9k8OG8P3UN
         h1XH77XnJQNRkIYxbd8era4rHkcxMFnmwFYeRaB8OY5v5gwg9o0VQN6cN4biPx/h9G
         MzEHGS5uNmrbxX9z/Gf2Oat/nKaHEYDqSqIr9+G/Sbo8KNU+5gV
Date:   Fri, 7 Feb 2020 00:16:12 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
Message-ID: <20200207001612.GF6573@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
 <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-06 at 22:55:55, Han-Wen Nienhuys via GitGitGadget wrote:
> diff --git a/reftable/README.md b/reftable/README.md
> new file mode 100644
> index 0000000000..f527da0380
> --- /dev/null
> +++ b/reftable/README.md
> @@ -0,0 +1,19 @@
> +
> +The source code in this directory comes from https://github.com/google/r=
eftable.
> +
> +The VERSION file keeps track of the current version of the reftable libr=
ary.
> +
> +To update the library, do:
> +
> +   ((cd reftable-repo && git fetch origin && git checkout origin/master =
) ||
> +    git clone https://github.com/google/reftable reftable-repo) && \
> +   cp reftable-repo/c/*.[ch] reftable/ && \
> +   cp reftable-repo/LICENSE reftable/ &&
> +   git --git-dir reftable-repo/.git show --no-patch origin/master \
> +    > reftable/VERSION && \
> +   echo '/* empty */' > reftable/config.h
> +   rm reftable/*_test.c reftable/test_framework.*
> +   git add reftable/*.[ch]
> +
> +Bugfixes should be accompanied by a test and applied to upstream project=
 at
> +https://github.com/google/reftable.

I think this particular statement may be problematic.  The upstream
project requires a CLA, which is a non-starter for many folks.  I don't
think we can expect folks who are working on Git to necessarily send
patches upstream with that condition.

For example, if I end up needing to patch this series to work with
SHA-256, I'm happy for Google to have my changes under the BSD License,
but I won't be signing a CLA.

> +#define SHA1_SIZE 20
> +#define SHA256_SIZE 32

I'd rather we didn't hard-code these values here.  If you need a size
suitable for allocation, we have GIT_MAX_RAWSZ and GIT_MAX_HEXSZ.  Those
are guaranteed to be the right size for any future hash.

> +	{
> +		struct merged_table m =3D {
> +			.stack =3D stack,
> +			.stack_len =3D n,
> +			.min =3D first_min,
> +			.max =3D last_max,
> +			.hash_size =3D SHA1_SIZE,

This is going to cause problems with SHA-256.  We'd want to write this
as the_hash_algo->rawsz, since it can change at runtime.

> +static byte zero[SHA256_SIZE] =3D {};

It would be better to refer to null_oid here.

> +#ifndef REFTABLE_H
> +#define REFTABLE_H
> +
> +#include "system.h"
> +
> +typedef uint8_t byte;

I think we typically prefer writing "unsigned char" or "uint8_t" instead
of "byte".

> +typedef byte bool;

I suspect this is going to cause a whole host of sadness if somebody
ever includes stdbool.h, or if that header ever gets included by an
OS-specific header, since bool is a #define constant for the built-in
type _Bool.

We typically use int for booleans, but I'm not opposed to using
stdbool.h for it on those systems that we know have it (which, in 2020,
is probably all of them).

> +struct writer *new_writer(int (*writer_func)(void *, byte *, int),
> +			  void *writer_arg, struct write_options *opts)
> +{
> +	struct writer *wp =3D calloc(sizeof(struct writer), 1);
> +	options_set_defaults(opts);
> +	if (opts->block_size >=3D (1 << 24)) {
> +		/* TODO - error return? */
> +		abort();
> +	}
> +	wp->hash_size =3D SHA1_SIZE;

Another SHA-256 problem.

Once this series has good test coverage, I'm happy to send a patch that
squashes in SHA-256 support if you don't want to implement it yourself
and you CC me.  If you do want to implement it yourself, you can grab
the transition-stage-4 branch from https://github.com/bk2204/git.git,
rebase your series on top of it, and run the testsuite with
GIT_TEST_DEFAULT_HASH=3Dsha256 to see what breaks.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl48rEwACgkQv1NdgR9S
9otllxAAsheYFOCHRS95Z+F9QehWiuU2t03gqQY7VtV9iq+DXrkTmsGFUP+AZJNP
AyZy5ln9RR2gzVMV0NIqtg+khJLa9nerPZlMhfTR01p4ib8F6E5aSF4pF7n7MMbf
vzFxRmsd9k3VpnDZG88EHvxUsts7N/8nsso28yrq0DDJPFfBy14XepcGUqjFr/sJ
Gh4VrT4ERsiaP5bqv0PiRiFrUWmF+cFsZrE28gBNGdE8hYzxCiSZ+Lm01Hze8cT9
32+IEVDX88lhKUsUJIesj+pdJPOBjcI782Zh5xRQ2yMeLSean6t/MOY3v7kf9x5K
oPya8L5Ss6saIp9K8RWKsYbsHytfVHY98+E/9VfLkaA+0tlAS5r1HXs6m5EGTSQU
aFxktOFH+h1qpLQx/zZytn15QJemWiJRuyEYyFZTn0c93tVq4gHEUYIFz4rCDoYO
P+R28XUkl2T8Gncc/cs/iu3qp3n1FbNkEsiFri7UnYuxBjQ17N0WTMU6yAOaweRo
mvTusFfjfPoEeVVFa5GSHbGiWTIxrmK3kdT1IvyLdTX40MyA0qZxYEvTppcC5nTk
Zxjw685ARSvtgJAt4GGJMTZPf1KYrm6Bapvag/hF+On5xoJyu1hMlhg3/LtTBwr4
JtsC6P7OHedkNXtbaEQ+VHmgQo0DSAgS4Vkoj907NuNXPYZBQeM=
=tm/2
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
