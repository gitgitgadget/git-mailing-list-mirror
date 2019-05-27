Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856611F462
	for <e@80x24.org>; Mon, 27 May 2019 20:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfE0UIt (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 16:08:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36750 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbfE0UIt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 May 2019 16:08:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5881:abd5:52a:5d54])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9C69360443;
        Mon, 27 May 2019 20:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1558987726;
        bh=BO0F+2NJYEyj7ZkvcNcr7vO10BmZaGCCACwYoUf0DX4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=WRfiWn9PHDTCG4o06NmjEp3Lf8mQbUvBP4TI5p9UtF6nZJihr7vsAGNfDh9FMB5c1
         /HChMbmNa0Y3kDnzeZPW27+Sjzrvye75rO7bsojiOaEDimEmTKYImqI6sStXhLIfgt
         laYuCm4It+3aAOjSaIpiN3Vb6mtq0r74FwkfhES8iZdbdxKGsp2tQebJ5PN33AeCE+
         cJDqFKtimVXnG3WLGuo/HYGd4L6xnKeE0GPvnUrYSbQ3VTK9MKs1lf0rSnhC6udX6B
         Cd74wXz7u6VNXd8ZGUw7Vi0y6lF4znYyR63kH9gabxyAcfNXcW0Xg0WHC8KvrHtLQK
         T4g4TK3ujZhZEOKFe4n6i5DoXr63S6VjX7rjidNcio0A/FWaiAZV426x1TZ9D0g3RF
         iniRhJZMcIuI4xwFvOca+Hs03clxl3TTiF1sweF94IEYBLF5eRrt6EfFlZ9/AUqiRy
         LIbA374gNXrEDjpdvpyYzZyNtHPDP5kwoYeORrc6Qcrsy6ZQHWW
Date:   Mon, 27 May 2019 20:08:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object
 database
Message-ID: <20190527200838.GF8616@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.226.git.gitgitgadget@gmail.com>
 <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-27 at 19:59:14, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> The deal with bundles is: they really are thin packs, with very little

Generally a colon can only follow what could be a complete sentence, so
maybe we want to say something like "The deal with bundles is that they
really are=E2=80=A6" or "The deal with bundles is this: they really are=E2=
=80=A6".

> sugar on top. So we really need a repository (or more appropriately, an
> object database) to work with, when asked to verify a bundle.
>=20
> Let's error out with a useful error message if `git bundle verify` is
> called without such an object database to work with.
>=20
> Reported by Konstantin Ryabitsev.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  bundle.c                | 3 +++
>  t/t5607-clone-bundle.sh | 6 ++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/bundle.c b/bundle.c
> index b45666c49b..b5d21cd80f 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -142,6 +142,9 @@ int verify_bundle(struct repository *r,
>  	int i, ret =3D 0, req_nr;
>  	const char *message =3D _("Repository lacks these prerequisite commits:=
");
> =20
> +	if (!r || !r->objects || !r->objects->odb)
> +		return error(_("need a repository to verify a bundle"));
> +
>  	repo_init_revisions(r, &revs, NULL);
>  	for (i =3D 0; i < p->nr; i++) {
>  		struct ref_list_entry *e =3D p->list + i;
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index cf39e9e243..2a0fb15cf1 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -14,6 +14,12 @@ test_expect_success 'setup' '
>  	git tag -d third
>  '
> =20
> +test_expect_success '"verify" needs a worktree' '

Did you want to say "needs a repository"? Or do we really need a
worktree?

Other than that, this looks fine to me. This is a much better experience
than a BUG and a nice improvement overall.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzsQ8YACgkQv1NdgR9S
9osC6Q/+Lg2GjZAmFicKGRGKvcczKapILixvmf0EmQcrAmjMJTXkmaRhjKPkrJzC
eTzxi63Ek63+t9Qf5l9AghUoQ5HBbzIWyoYavoFZcnjiY0vcg34HHHsC6Bvdx8Ck
hjHCSiEx0fIcTIxxKONJrDeee8GkQaiG+SuYflUrBBhrlM3PhykCafrCs55s3qlH
yEU0qTavOmpzZs9IGJEHvqSYVcHL7rmRFKqUxY8oQUQRzc2Nh1brUQ0+zWABQBQ0
6vpOH4pS2Gs6DGBsa77sYok9LUHbdzH1HSWkTsqZVjAFm7ht/v5p+mkUaLadWO12
jNa6IWmr4W744MTkILmQ1edE2tXYJdxJFiarN37UKl9qB03VVhb/nqFaP/Eq54p1
WvnAnn+knbRrDrTSLfd/2tQ3WMwnmB9KrNWVB2pnKTGQbG2JB5OfrkQNRdlQShLo
hQ7aN6Eh4510eUWs6Uj3tY45NNPp47sSrZYhddirApfnPbXmwX9FW2inNTpdax0V
94QLxpjVA+5JAPklRXmbXmqMWrItwbu6mEpYVegKTPOJx8rTPSmjs7NSY6bPGjRJ
wMD8MoA1FmNq5jyvWjVGlHsiI3A03f4y0ULhzWVCDiSjUXrrblymFDh9M9itL/St
XFLKRC52mSNhUMTSJTJFcdhPOvakuwlaNr7iV+hSf/UdJntIj0U=
=EStS
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
