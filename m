Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9299A1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 23:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfHZXEf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 19:04:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58362 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfHZXEf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 19:04:35 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 631056140C;
        Mon, 26 Aug 2019 23:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566860673;
        bh=kywkWgv9H6EW8wTEFMXbSE61JiQqM6K8UifH9BgqAIo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NHIRyWmxviFCDQ6D81eq56QDA4VMlXo2H9gsSjOVq0SKsMbTBp1yNizIp0vC8HIGX
         8HPL6SpxWvFPxOQgXS1d+ue5BQNeAEbDJy2QGN2rFB46FwFhQBljay+a/pxewuIrJ2
         RMOvEfTZwk3d3w6RithcGZCs5Kx1eqYB6rjgBExvcLMDpEqdLqSeyOrEXK5xEpy9L8
         u2+XuiwHIE5tjJQk96VlDHiS58lH41nf8FewEraPiqIJumZS8RzcM7LgvqbFTvqpmH
         vJVQ9kpOLYj8F65ecdxIcsfPn9XNHNe0n4/ABH0fZj19RtNu2Mt3NSdfOTjYKZF/us
         z57elwhxNpIhd07+KwwEn4h413vuq5yOk44/9a/yTQlgwwahnve5jnvlUJloshIN9a
         nKEove4gfdUBzU8NpQ/+PgGnJX0MBi3OVLlnSWgUCdY0mV5Kdc2S/5Q6rfPkcVOeVv
         JAVRr1X6AhDqYFNc05WhL2WYtI0n7qnO5ztycAu5hPGI/T78XZZ
Date:   Mon, 26 Aug 2019 23:04:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ibrahim El <ibrahim.el@pm.me>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] Signing API: Added new signing interface API
Message-ID: <20190826230429.GB11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ibrahim El <ibrahim.el@pm.me>, git@vger.kernel.org
References: <CkxnpIEi2c1o1FmI2ZJP8CJQybGMZFbL6uQAd3w7ApKdaki4vcCrlgbTWmPMrrfIedBSvLV56q6txzvCo7bnO1wHlS6cB3bUYpYfNW80w_s=@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <CkxnpIEi2c1o1FmI2ZJP8CJQybGMZFbL6uQAd3w7ApKdaki4vcCrlgbTWmPMrrfIedBSvLV56q6txzvCo7bnO1wHlS6cB3bUYpYfNW80w_s=@pm.me>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-26 at 19:58:00, Ibrahim El wrote:
> From: Ibrahim El Rhezzali <ibrahim.el@pm.me>
>=20
> 7e3e6c9e4 Added new signing interface API
>=20
> Adding files for the new signing interface and also support drivers for t=
he two existing GPG and GPGSM X.509 tools

I'd like to see an explanation here why a new signing interface is
necessary and we need to make a wholesale replacement of the existing
one instead of making incremental changes.

> diff --git a/signing-interface.c b/signing-interface.c
> new file mode 100644
> index 000000000..c744ef499
> --- /dev/null
> +++ b/signing-interface.c
> @@ -0,0 +1,487 @@
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include "cache.h"
> +#include "config.h"
> +#include "run-command.h"
> +#include "strbuf.h"
> +#include "signing-interface.h"
> +#include "signing-tool.h"
> +#include "sigchain.h"
> +#include "tempfile.h"
> +
> +extern const struct signing_tool openpgp_tool;
> +extern const struct signing_tool x509_tool;
> +
> +static const struct signing_tool *signing_tools[SIGNATURE_TYPE_COUNT] =
=3D {
> +	&openpgp_tool,
> +	&x509_tool,
> +};

It looks like we've hard-coded only two tools here.  I was under the
impression this series was supposed to make signing pluggable with any
tool, but that doesn't seem to be the case.

> +size_t parse_signatures(const char *payload, size_t size,=20
> +		struct signatures *sigs)
> +{
> +	enum signature_type st;
> +	size_t first;
> +	size_t begin =3D 0;
> +	const struct signing_tool *tool;
> +	struct signature *psig =3D NULL;
> +
> +	first =3D size;
> +	for (st =3D SIGNATURE_TYPE_FIRST; st < SIGNATURE_TYPE_LAST; st++) {
> +		tool =3D signing_tools[st];
> +
> +		if (!tool || !tool->parse)
> +			BUG("signing tool %s undefined", signature_type_name(st));

If this is supposed to make parsing generic, won't we have to add
support for each individual tool in the codebase so tool->parse is
defined?  Having to do that would defeat the point of having a pluggable
interface set up in the configuration.

> +	buf =3D xstrdup(var);
> +	t1 =3D strtok(buf, ".");
> +	t2 =3D strtok(NULL, ".");
> +	t3 =3D strtok(NULL, ".");

I don't think we make a lot of use of strtok.  Perhaps you'd like to use
parse_config_key or another function in config.c?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1kZXwACgkQv1NdgR9S
9ouVRQ//W1J14eyQJz+EW9Qw653l1ZCG6XoOMe9T3O22ec60X6oRIDledLixkuxJ
fhafbcOcujzx7L9GUEXZOEHiVQMJmyvmf+TG5JMVROEOrmCWYj5cSutnMqi88Vos
0NZMW08mHdE+qKlnbVAqRpeMmPmWzKtcw0rw+9K/R0lyuG3tnGi2nXwgjKzIkL1X
Ri03kl/an7n890+FpfD8qdhAaL1+Q6IdC/xwwZCkyMfDZl2boNrQRe0yA1Vk81aF
KjCZsuaGhylhabehWXw/or2lidWluHJK3x1La/yeJfwkJ8E0SOTb8CLc4vCbG2xl
lP7W8cHOs4RYB8T2J+wwjogKC2/skSbRGOk7eeqNVuZi/y8Em2//rdT0BPo9U30U
wBXiY3v/KbpytPmxDKzBhmKFMUdS9QffMhcQbvoK4HvrfpG46xT+Yk684/q9e7Kr
jg2w0oQBSemTCTBIQLONkVam8YnhxQxoix1oW3qCRxijt3TgjqjWLZrNzgPAH21l
hxWp32f57thrT2zvoJnrLPQlzCXKVEm/+UaztKAyxAsuoknVqO9kW/Pi6S8BaJpW
mrlIksda7HTGkCwMOnubTxVQ/ShYzuihEZUhMeSpRh6EYSsq9oeECuNh0z9ijNT4
tMxNzGRLCvGdrBAkmFXVY6GGiO7x+Zhitg4x0fzLHuafxKmz/VI=
=XJjG
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
