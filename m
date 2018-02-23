Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54481F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeBWWaA (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:30:00 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33716 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752497AbeBWW36 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Feb 2018 17:29:58 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 717CE6096B;
        Fri, 23 Feb 2018 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519424996;
        bh=FMjsbxZMFXqpOpa+bMEu2wLFcqkBjeckZtY3ovA5mrU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BAOG11Dll+kP4HG/EdElxw3b9bm2ujwmJkEqvORlxtrqTJrllAZ1c3VF6rZb5mw1H
         Dz6xVwYVKpTemkuQKwPCdLjhT+PTHAfVh6es47vbJqqasJFdeEUuHz1Z0dbGkyB7hF
         3MIUqlc5Bq4vT5YsFMzq+Ii78KID+q18MTlmOcO21mg0p1OkJ8YRkVNizUFKH9AkYM
         oNwgwswrMZlzLDBunBYo3/+q1myD9Z4DcmC1q916jpfaXzsyGDSI3oq3ePhMTKmnyQ
         04Z8lMHpP0ZK+aapUCIRr2hJildW5+bwLTgK3g03PWJKIQT52qxWOb9R/oTzMUfYLh
         h2fGl20Q6pHPkLW6h25/r/qf09ePycJGTjCkC7h3nFVF0pLKfkxZfJ/sSqhJR4uJvd
         CFwflmTYz8Q9DyVnRCZhTR+L7WaszKhSzZHilnomTvbDem7I43rQlHitmJSeVVv5rW
         47+aF5bH4Leef/8EGUuaDET6rv0pDcFZo57mfob0lFhvgsHaqiT
Date:   Fri, 23 Feb 2018 22:29:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
Message-ID: <20180223222950.GK6619@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20180214180814.GA139458@google.com>
 <20180223095640.25876-1-pclouds@gmail.com>
 <20180223095640.25876-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iKKZt69u2Wx/rspf"
Content-Disposition: inline
In-Reply-To: <20180223095640.25876-3-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.14.0-3-amd64)
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iKKZt69u2Wx/rspf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 04:56:40PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 7e3e1a461c..8ee935504e 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1673,6 +1673,11 @@ int cmd_index_pack(int argc, const char **argv, co=
nst char *prefix)
>  	if (prefix && chdir(prefix))
>  		die(_("Cannot come back to cwd"));
> =20
> +	if (!the_hash_algo) {
> +		warning(_("Running without a repository, assuming SHA-1 hash"));
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +	}

Is this warning going to be visible to users in the normal course of
operation?  If so, people are probably going to find this bothersome or
alarming.

>  	for (i =3D 1; i < argc; i++) {
>  		const char *arg =3D argv[i];
> =20
> diff --git a/common-main.c b/common-main.c
> index 6a689007e7..12aec36794 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "attr.h"
> +#include "repository.h"
> =20
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -40,5 +41,8 @@ int main(int argc, const char **argv)
> =20
>  	restore_sigpipe_to_default();
> =20
> +	if (getenv("GIT_HASH_FIXUP"))
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

I'm lukewarm on adding this environment variable, but considering our
history here, we had probably better.  We can always remove it after a
few releases.

>  	return cmd_main(argc, argv);
>  }
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 0ed5f0f496..f038f665bc 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -241,6 +241,11 @@ void diff_no_index(struct rev_info *revs,
>  	struct strbuf replacement =3D STRBUF_INIT;
>  	const char *prefix =3D revs->prefix;
> =20
> +	if (!the_hash_algo) {
> +		warning(_("Running without a repository, assuming SHA-1 hash"));
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +	}

Again, same concern.  I can imagine scripts that will blow up loudly if
git diff --no-index spews things to standard error.

I'm not opposed to making this more visible, but I wonder if maybe it
should only be visible to developers or such.  The only way I can think
of doing is that is with an advice options, but maybe there's a better
way.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--iKKZt69u2Wx/rspf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.4 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlqQld4ACgkQv1NdgR9S
9ouqqw//bH/oYHTtq5OAiw35hRWxxdWEwCxQOui5X6sb62j3pT7xpu6IY0R2Szkc
RjkgTX9wbT8MhtfaxEbLB11dDkgMHfv4jBQ4R5+PDMi1HE10M+2PpHze789bw4B8
5zRzq7vr2F80+hJN++JA5rWd+ZyrkXilMLfag/Cy+Z1doyJuNfvdk0Ycq1qo+r3L
3nP1VmT+w+dlCvbSo3lUBkMsuvwcQmnlwuLwbex+baQaUSAX7vxR3rHuBbe+eBHF
8uyfms2ME/U81UbJiY/IlYx2Oey3dG6LHmL7ZXoj6I9XyFEg3ZRtFCAvKHmUnrqK
GEd8ynW0PTnUmqe4fBMeg3+cwdbyK13Jq3VYaz1fYRlXBnNsWjx6IIWngXObwSIk
UnBuuoJSIenBrgvunPkQmrEdqI5WgrqTgQnnN/ZLchm3oTb/i1PUn4/TkgIQm5CR
Sl9IJPZLB8fEYM1P3eBW5d3BN8S33KCRkbItmqZbNhi+Cd2RUtNA0UbiuZ1wj1i+
/PMxSRrP1K/s42SUL72SMu9aIUPgC+rY95EkJ8WYw7BzIWTXgUm7hBZozc3o3XAw
pNBfDluShbiYnUbvaBu8cunUA5OXFZ0ue9akqoSGpN5yI86itvQDeFUBvJ8t3itC
/BiBK8G29a83PkvhxHYh8dB0Np9eh1rVm8jtqItAylnNDQy65ZI=
=QbSr
-----END PGP SIGNATURE-----

--iKKZt69u2Wx/rspf--
