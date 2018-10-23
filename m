Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE6E1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 23:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeJXH3A (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 03:29:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51868 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729075AbeJXH3A (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Oct 2018 03:29:00 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e0bc:761d:9be1:27bc])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 79A6B61B72;
        Tue, 23 Oct 2018 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540335808;
        bh=RkFOZxgKQjMwXrgjKzknmC5NvF+qZ3pzlaQqADaEf38=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=TA6cQVRl+JUugMZmW0o5wnb+VzmABGr4idrs2OjDPqFdVKyGSpeu6FcMrMxv8DryQ
         LN/kZZ2EGypkBvP1ZWUf7SEJ7j7S6NyDikefy9NnXPBdJelozXijY7rsXSc7f3xwHQ
         AYhyNEp3OV/LvxDAJboU/IU9C6HpI/iYEOxyxudtAn76b+AIygLKNm6T2oEnX/PbIu
         jFHrkS6mpnRgOnURdqJh9r3TYMx+mu3Ukn6EwATstj0W/jSKmODTYQMbVX72+GJmtP
         NNxpPBoY3/JVk8km8dr30Rcq/pPQbXqcdAW/q60bCwQVIM3KyS5gv/fit39o6O8X0i
         5Ey8AJUbeH8jRsfjzCSWP2FAAZ+qsxkyf+lSF7rJh7bBUCRyi2EvlR1Pz2XXV13QvD
         dqGGRP+3ex4CUBRe/n0R3t1U/t5mKWdR2a7IHR5Y4wcjkelYyaGIxPm4BsqoIj5yuH
         rP2lLICivGQN4iwWrEY0yX+8ZTtCeaQ+CabWxhj9pWwEWaHRsug
Date:   Tue, 23 Oct 2018 23:03:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Tommi Vainikainen <tvainika@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git pull defaults for recursesubmodules
Message-ID: <20181023230324.GC6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tommi Vainikainen <tvainika@gmail.com>, git@vger.kernel.org
References: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <CAGshahkvn3fcyuqtD-WQE9tn+7rSad84+mtA_cfkz+t42xqPdw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 12:04:06AM +0300, Tommi Vainikainen wrote:
> I configured my local git to fetch with recurseSubmodules =3D on-demand,
> which I found the most convenient setting. However then I noticed that
> I mostly use git pull actually to fetch from remotes, but git pull
> does not utilize any recurseSubmoddules setting now, or at least I
> could not find such.
>=20
> I would expect that if git-config has fetch.recurseSubmodules set,
> also git pull should use this setting, or at least similar option such
> as pull.recurseSubmodules should be available. I'd prefer sharing
> fetch.recurseSubmodules setting here.
>=20
> I've attached a minimal patch, which I believe implements this
> configuration usage, and a test case to show my expected behavior for
> git pull.

Typically, we prefer patches to be inline; descriptive content like this
goes after the --- line in the patch, or in a cover letter.

> From e4483ec5b3d9c38a6e30aa0ab9fa521cba582345 Mon Sep 17 00:00:00 2001
> From: Tommi Vainikainen <thv@iki.fi>
> Date: Tue, 23 Oct 2018 23:47:58 +0300
> Subject: [PATCH 1/1] pull: obey fetch.recurseSubmodules when fetching
>=20
> "git pull" now uses same recurse-submodules config for fetching as "git
> fetch" by default if not overridden from command line.1

You have an extra '1" at the end of this line.

Also, missing sign-off.  See Documentation/SubmittingPatches.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 798ecf7faf..ed39b0e8ed 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -347,6 +347,9 @@ static int git_pull_config(const char *var, const cha=
r *value, void *cb)
>  		recurse_submodules =3D git_config_bool(var, value) ?
>  			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
>  		return 0;
> +	} else if (!strcmp(var, "fetch.recursesubmodules")) {
> +		recurse_submodules =3D parse_fetch_recurse_submodules_arg(var, value);
> +		return 0;
>  	}
>  	return git_default_config(var, value, cb);
>  }
> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
> index f916729a12..579ae5c374 100755
> --- a/t/t5572-pull-submodule.sh
> +++ b/t/t5572-pull-submodule.sh
> @@ -75,6 +75,17 @@ test_expect_success "submodule.recurse option triggers=
 recursive pull" '
>  	test_path_is_file super/sub/merge_strategy_2.t
>  '
> =20
> +test_expect_success "fetch.recurseSubmodules=3Dtrue triggers recursive p=
ull" '
> +	test_commit -C child fetch_recurse_submodules &&
> +	git -C parent submodule update --remote &&
> +	git -C parent add sub &&
> +	git -C parent commit -m "update submodule" &&
> +
> +	git -C super config fetch.recurseSubmodules true &&
> +	git -C super pull --no-rebase &&
> +	test_path_is_file super/sub/fetch_recurse_submodules.t
> +'

Can we have a test that --no-recurse-submodules overrides
fetch.recurseSubmodules?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvPqLwACgkQv1NdgR9S
9oui4Q/+Ipm3s0I/MF/T+wn3ImjABWshiTdlaHkdKSZ17wQVmXA+gPPZ8XrY2sOj
clC9wiySVVcP/v+DWJuWXwvSpbfKQdwzkdabEa5YACL9HQN7qU8kOcwqzYOjj1Xw
vgsjrF3nzvxAz+jCZZcsbJPZexxWU7GHu7nXWKOnz6xBekrjQMnEzJT0V58vO+Ft
NnrOexnnxSd5wfnCGtIYRxv/j4IzCo2+pPN+3ZLh2WyvdvZHXJ5oK5YNtb3c7aCt
SVOfFvRIorMAvhmWGR05wMy65iJQYlhOpkRwXb7ddgXp9GjCozuefEWs6iQ1utzL
m62KwBCaBdExeIG1VBqeXrL2BrnKiNxs71ueg7FTwYeMSuCNih9yb1Z4IrM9QppV
ivEzkrelR7aPErNqNbpfjifoV3VofYIXh2Inm0Ne1WLptplkMkfnNEjmbe/rIT0B
qF1ck62SChlOv2LlD8Z5mLaaF+t5a94AlGN1/EXSzGYPmCU/2BOJTkan6sXWVbd1
CTeHuRt0WWcNyo3kBvjaIhJfQH7cmNoECt909A0W7z1I45Ec2I0meymh+WOT2HUH
Etgy7X4d+q6rVSxVt4yKDmW4k0XS+z5wxEFXoGTAobwm0+WY52yKzsO42gLQVXk9
e6rjawLjDipl3RL0lXURbMqD20Gaeg124EpDJcUS2cfZZT2BCG8=
=42Du
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
