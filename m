Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CF6C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7172064C
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 23:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Tfiv81oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBFXt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:49:28 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55464 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgBFXt2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Feb 2020 18:49:28 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D70BB60479;
        Thu,  6 Feb 2020 23:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1581032966;
        bh=8wVoi5eNdgQJ1VzPS7bz4mvFk4yYHdT5zRg2v8ZXzWc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Tfiv81oPHSbtW+8UnLLr729FqjqiPPdWnwL4Hcq6q8620dsHZ0mEzdFJSyAJbO+jL
         ZYV4aiJvBAr68i4WUcjvcmYMhkRoAc9MRFEEA47u2/kt5N7Vl0a/YpM6aVAcV7NBYP
         mqkB+TTeI7YIJs14lMzKU337z8aQegJU/C03TgJ+p7iPS1BJE+oGGy+9pj3yK+aCBm
         HSYIMf6hzvFbfJaLYTWvbrh36z9xr61w7mnFXHxh6/2YQRwN8by1BhbXzMzraptO7R
         kD37+b1RY6sLVnvvgzLFJm6UWdH17KMZmVUF8SRi4mWuLqHajIW1tjYgM3QKH+KOjt
         GwqKW/oPk1gBzvacfXnykQmZDqQAHnQtiOYpLYPGbiCr/xOvZaRY/3YFk9nzyhoYcV
         NIyoH9R50miTPAsiyvkfM7yUFFOQ+BxTq11a/D19Fr8eXUqnKF78MZNSGw0fCg3nbS
         y4OurlUOsP/46R/VsNmHUPEJwhFz1EVYoRokGxmB2cVvT/tyzes
Date:   Thu, 6 Feb 2020 23:49:21 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v4 5/5] Reftable support for git-core
Message-ID: <20200206234921.GE6573@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
 <2786a6bf61d732570335f181540b0d1f7dd47b13.1581029756.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <2786a6bf61d732570335f181540b0d1f7dd47b13.1581029756.git.gitgitgadget@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-06 at 22:55:56, Han-Wen Nienhuys via GitGitGadget wrote:
> @@ -403,6 +417,10 @@ int init_db(const char *git_dir, const char *real_gi=
t_dir,
>  		git_config_set("receive.denyNonFastforwards", "true");
>  	}
> =20
> +	if (flags & INIT_DB_REFTABLE) {
> +		git_config_set("extensions.refStorage", "reftable");
> +	}

This does seem like the best way to do this.  Can we get an addition to
Documentation/technical/repository-version.txt that documents this
extension and the values it takes?  I presume "reftable" and "files" are
options, but it would be nice it folks didn't have to dig through the
code to find that out.

One side note: we typically omit the braces for a single-line if.

> +
>  	if (!(flags & INIT_DB_QUIET)) {
>  		int len =3D strlen(git_dir);
> =20
> @@ -481,15 +499,18 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
>  	const char *template_dir =3D NULL;
>  	unsigned int flags =3D 0;
>  	const struct option init_db_options[] =3D {
> -		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
> -				N_("directory from which templates will be used")),
> +		OPT_STRING(0, "template", &template_dir,
> +			   N_("template-directory"),
> +			   N_("directory from which templates will be used")),
>  		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
> -				N_("create a bare repository"), 1),
> +			    N_("create a bare repository"), 1),
>  		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
> -			N_("permissions"),
> -			N_("specify that the git repository is to be shared amongst several u=
sers"),
> -			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
> +		  N_("permissions"),
> +		  N_("specify that the git repository is to be shared amongst several =
users"),
> +		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0 },
>  		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
> +		OPT_BIT(0, "reftable", &flags, N_("use reftable"),
> +			INIT_DB_REFTABLE),

I wonder if this might be better as --refs-backend=3D{files|reftable}.  If
reftable becomes the default at some point in the future, it would be
easier to let people explicitly specify that they want a non-reftable
version.  If we learn support for a hypothetical reftable v2 in the
future, maybe we'd want to let folks specify that instead.

>  		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
>  			   N_("separate git dir from working tree")),
>  		OPT_END()
> diff --git a/cache.h b/cache.h
> index cbfaead23a..929a61e861 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -625,6 +625,7 @@ int path_inside_repo(const char *prefix, const char *=
path);
> =20
>  #define INIT_DB_QUIET 0x0001
>  #define INIT_DB_EXIST_OK 0x0002
> +#define INIT_DB_REFTABLE 0x0004
> =20
>  int init_db(const char *git_dir, const char *real_git_dir,
>  	    const char *template_dir, unsigned int flags);
> @@ -1041,6 +1042,7 @@ struct repository_format {
>  	int is_bare;
>  	int hash_algo;
>  	char *work_tree;
> +	char *ref_storage;
>  	struct string_list unknown_extensions;
>  };
> =20
> diff --git a/refs.c b/refs.c
> index 1ab0bb54d3..e4e5af8ea0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -20,7 +20,7 @@
>  /*
>   * List of all available backends
>   */
> -static struct ref_storage_be *refs_backends =3D &refs_be_files;
> +static struct ref_storage_be *refs_backends =3D &refs_be_reftable;

I'm not sure why we're making this change.  It doesn't look like the
default is changing.

> @@ -1913,7 +1916,7 @@ struct ref_store *get_submodule_ref_store(const cha=
r *submodule)
>  		goto done;
> =20
>  	/* assume that add_submodule_odb() has been called */
> -	refs =3D ref_store_init(submodule_sb.buf,
> +	refs =3D ref_store_init(submodule_sb.buf, "files", /* XXX */
>  			      REF_STORE_READ | REF_STORE_ODB);
>  	register_ref_store_map(&submodule_ref_stores, "submodule",
>  			       refs, submodule);
> @@ -1927,6 +1930,7 @@ struct ref_store *get_submodule_ref_store(const cha=
r *submodule)
> =20
>  struct ref_store *get_worktree_ref_store(const struct worktree *wt)
>  {
> +	const char *format =3D "files"; /* XXX */

If the question is whether we still want to default to "files" as the
default, then yes, I think we do.  Suddenly changing things would be a
problem if for some reason someone needed to downgrade Git versions.

Since we have two instances of "files" above, it might be better to
create a #define like DEFAULT_REF_BACKEND or some such.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl48pgEACgkQv1NdgR9S
9oviTg/+O2H4ZwdThwGK5hajU0rVaRFzsStyFODwc9zydj65CD0GTYq4Ax16emwn
aE0O/Kq/63pf6fms+06Mf539C0RsPYf3Qjz/mgu+OqYiouciDlLg4nyRw6BHWuyF
lOngCoqk9FpOMi6gBo1zZ7ImgmqI1dDuWuenv4iyjpZj9mW03k55ySGO2axkdCzk
TrMDnGAqqL8u7I25s2kbuENZVwla4sp52FCHz4T2KRIMPXnGsjWoEpUerPaXf0Fp
pQi1nzSIJ7IzIT/sNdvkT1XHTGt5fIwC3dC+Gey749FU6H3TPlHNaKOVuh+AD776
E5Zj6Jv5wpfUrkf3SlSRmwMAZej4+WcHxnAa9zvBDgjXIaF3KUMdb4m/e5h7J/Yj
pmAw26ANZiEXh3vttHBuAWPW3RO8gIjk8Fb7MPAUF5OINobVPQXf46cf7GMd7r68
s9Ej+DJz4IHIZddSECBXcyJVeOuMx4Q6BqI/laFTQ/l3RYz37BjNTrCwG86qQqU6
4wzbTBwTwi6Zm1dO6XOvRtxT/dLnum1lVgUreBsWRAYFesRft84zsf0VCsWSOcht
2VswJz5Xb7AdmnKiQlFUr7Ri8od5I67CSX9gIcVp8Hd1ZWUaqhGHd94RFplPUU5P
HC+9FUYgZku4xotAA/s516cHCn4wx7pDaEVnL43YIbuAHYEJc6E=
=d1jO
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
