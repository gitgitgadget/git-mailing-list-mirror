Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94475C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiADOig (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:38:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:48999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbiADOif (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 09:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641307084;
        bh=k+qCJ/6GbfUhv2T5iGJMpP/veD+47Ay47kBHjVveAUw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cSUWyI+15V5Ac35SDdYaKnpVNVZaAZwm+cefZxnkrA++IWySXk7dzL5c+LhFKraPU
         cK0XPaBHrH3M5DHoh4NcCbfX7O77UGKygpdMIoikVkfZt3PLQ6Zk+oQMBT+pajX9gG
         o9e5RB2pQDbjYwbbJPHROyIUudEuLce1oF9sKJaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1mSeFF0fCH-00hN5i; Tue, 04
 Jan 2022 15:38:04 +0100
Date:   Tue, 4 Jan 2022 15:38:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Teng Long <dyroneteng@gmail.com>
cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 8/8] ls-tree.c: introduce "--format" option
In-Reply-To: <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet>
References: <cover.1641043500.git.dyroneteng@gmail.com> <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nS4G/G4JtdLH+pm1FB3dCnH87r2P8mh95FzaQ9Mn++QozRDsluU
 PJjS+p5Pe9wbr+b8ZijUjVQ3cVFX4n0NsWBTViaA3lqhT3DOiNrEuMdjgOZmK1Nny1s/0XB
 I04LahK/NB0LPmLlOEGBAYoiUJePbpJZgfHsomF2vusC3wVlf+260SEspdmkdTl650v0AVL
 B16XpT0u3+2SZLcBxFShQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KgXV1+Vkz5g=:azeE4oLElBzqz5dle7N2wD
 ji+BJYoVJsGypglR/Jvu8Ny5nXsSfApityCP/JQ4Okz9BTd2bUOI+MxC8usZylj63STZOs4EA
 /sGUKSgjxGww17oBhfvW97310fC6JNyEMnYwWs7PBJ5qR1S3gPomD1kndfbtBywFC2BYi0t8Z
 p7G64l7dgU8VszpBLJhw/ZfbiXouy2iVd2+ieUQDxk86elk8eb4qir7NeatFTy8EbOd+24Qyr
 yRbzsQ7CSo5OhHffWN3r0KqyhlmOPDq6pXWdLoIqCwGX662EtRhNIB7l/NF/9vUeYFxIxbjzY
 tjcKKCihaeDmb/o26A5HUQ4jw29UgDVL/FwOlxJ9Gicd7jYcghm0d2xoB35DyZv4da1bmoVV8
 3wP9lITwbbN2sFYT9AaZZkcAFxZMijaEyDVKzhAeVdV2ufZKno/INaEFb9dp0FEuiqCzh6b48
 8JzhjZbhS4zlLK7xNN4zBIPJBXa/tGZWMtKsFkhlk+K+h8/pot3i3F2d1B1/DfQbbuPid7Po6
 lIQSGsPZ8hUO8m0WnHHoVjsqucQqnFBRkJPrhpltHsPffOtmJ0oaQj2itwIur0h1citH4xfxd
 ToydwmkK+K4HxJMyinH1h1MrTylmzaxmJodrquQciNK4UNiGtk6k05PWEJgUbPXZr2+ePNPW8
 uuLHnbuH2NuaOZRQ+/rJkBYjm1ObgOAi83RkjpIjuiTH9rKrxCz1UJKyJnfPyBfV+oMgq7aCh
 7MQAe18ks9gM91ZChT7NCyHwp3YzRtC8UFxo4ujbbi1IH6tZVHv8FxX/U8iZ/STN28NW+buNc
 kAufJ41FHKruIFXKa2zX8AUqjUeIvDSYa3JpDeNMsiShIKnHlKZT5fPytvAixzYtc/E9jLLXj
 Z7u3WEIj1eIoZQ+b4mMLGNYY0d4eXx0PDBK+TKrIchdXwWdJCaojEJH7cdIru26Yrx/AH6LAm
 +crwn5k6Qvi2aTROOG6DoRfZxXuwtJF0JrvbevxSe1SjNbP6r3WR7MUs4tsOAg1hrYKA3L0P/
 OCrDPFPqjrSoFVb6kYaQt849CGxQiaAyZYYdZVNDDeQVRSSRIIan5Rxa43UCxK5AYcc1dwxUF
 GrskC96k53LYoM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng,

On Sat, 1 Jan 2022, Teng Long wrote:

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 009ffeb15d..6e3e5a4d06 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -56,23 +56,75 @@ enum {
>
>  static int cmdmode =3D MODE_UNSPECIFIED;
>
> -static int parse_shown_fields(void)
> +static const char *format;
> +static const char *default_format =3D "%(mode) %(type) %(object)%x09%(f=
ile)";
> +static const char *long_format =3D "%(mode) %(type) %(object) %(size:pa=
dded)%x09%(file)";
> +static const char *name_only_format =3D "%(file)";
> +static const char *object_only_format =3D "%(object)";
> +
> +static void expand_objectsize(struct strbuf *line, const struct object_=
id *oid,
> +			      const enum object_type type, unsigned int padded)
>  {
> -	if (cmdmode =3D=3D MODE_NAME_ONLY) {
> -		shown_bits =3D SHOW_FILE_NAME;
> -		return 0;
> +	if (type =3D=3D OBJ_BLOB) {
> +		unsigned long size;
> +		if (oid_object_info(the_repository, oid, &size) < 0)
> +			die(_("could not get object info about '%s'"),
> +			    oid_to_hex(oid));
> +		if (padded)
> +			strbuf_addf(line, "%7" PRIuMAX, (uintmax_t)size);
> +		else
> +			strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
> +	} else if (padded) {
> +		strbuf_addf(line, "%7s", "-");

This, along with two other similar instances, triggers the
`static-analysis` job in the CI failure of `seen`. The suggested diff is:


=2D- snip --
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6e3e5a4d0634..8301d1a15f9a 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -75,7 +75,7 @@ static void expand_objectsize(struct strbuf *line, const=
 struct object_id *oid,
 		else
 			strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
 	} else if (padded) {
-		strbuf_addf(line, "%7s", "-");
+		strbuf_addstr(line, "-");
 	} else {
 		strbuf_addstr(line, "-");
 	}
@@ -110,7 +110,7 @@ static size_t expand_show_tree(struct strbuf *line, co=
nst char *start,
 	} else if (skip_prefix(start, "(size)", &p)) {
 		expand_objectsize(line, data->oid, data->type, 0);
 	} else if (skip_prefix(start, "(object)", &p)) {
-		strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev));
+		strbuf_add_unique_abbrev(line, data->oid, abbrev);
 	} else if (skip_prefix(start, "(file)", &p)) {
 		const char *name =3D data->base->buf;
 		const char *prefix =3D chomp_prefix ? ls_tree_prefix : NULL;
@@ -119,7 +119,7 @@ static size_t expand_show_tree(struct strbuf *line, co=
nst char *start,
 		strbuf_addstr(data->base, data->pathname);
 		name =3D relative_path(data->base->buf, prefix, &sb);
 		quote_c_style(name, &quoted, NULL, 0);
-		strbuf_addstr(line, quoted.buf);
+		strbuf_addbuf(line, &quoted);
 	} else {
 		errlen =3D (unsigned long)len;
 		die(_("bad ls-tree format: %%%.*s"), errlen, start);
=2D- snap --

But I think that the first hunk indicates a deeper issue, as `%7s`
probably meant to pad the dash to seven dashes (which that format won't
accomplish, but `strbuf_addchars()` would)?

Ciao,
Dscho

> +	} else {
> +		strbuf_addstr(line, "-");
>  	}
> -	if (cmdmode =3D=3D MODE_OBJECT_ONLY) {
> -		shown_bits =3D SHOW_OBJECT_NAME;
> -		return 0;
> +}
> +
> +static size_t expand_show_tree(struct strbuf *line, const char *start,
> +			       void *context)
> +{
> +	struct shown_data *data =3D context;
> +	const char *end;
> +	const char *p;
> +	unsigned int errlen;
> +	size_t len;
> +	len =3D strbuf_expand_literal_cb(line, start, NULL);
> +	if (len)
> +		return len;
> +
> +	if (*start !=3D '(')
> +		die(_("bad ls-tree format: as '%s'"), start);
> +
> +	end =3D strchr(start + 1, ')');
> +	if (!end)
> +		die(_("bad ls-tree format: element '%s' does not end in ')'"), start)=
;
> +
> +	len =3D end - start + 1;
> +	if (skip_prefix(start, "(mode)", &p)) {
> +		strbuf_addf(line, "%06o", data->mode);
> +	} else if (skip_prefix(start, "(type)", &p)) {
> +		strbuf_addstr(line, type_name(data->type));
> +	} else if (skip_prefix(start, "(size:padded)", &p)) {
> +		expand_objectsize(line, data->oid, data->type, 1);
> +	} else if (skip_prefix(start, "(size)", &p)) {
> +		expand_objectsize(line, data->oid, data->type, 0);
> +	} else if (skip_prefix(start, "(object)", &p)) {
> +		strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev));
> +	} else if (skip_prefix(start, "(file)", &p)) {
> +		const char *name =3D data->base->buf;
> +		const char *prefix =3D chomp_prefix ? ls_tree_prefix : NULL;
> +		struct strbuf quoted =3D STRBUF_INIT;
> +		struct strbuf sb =3D STRBUF_INIT;
> +		strbuf_addstr(data->base, data->pathname);
> +		name =3D relative_path(data->base->buf, prefix, &sb);
> +		quote_c_style(name, &quoted, NULL, 0);
> +		strbuf_addstr(line, quoted.buf);
> +	} else {
> +		errlen =3D (unsigned long)len;
> +		die(_("bad ls-tree format: %%%.*s"), errlen, start);
>  	}
> -	if (!ls_options || (ls_options & LS_RECURSIVE)
> -	    || (ls_options & LS_SHOW_TREES)
> -	    || (ls_options & LS_TREE_ONLY))
> -		shown_bits =3D SHOW_DEFAULT;
> -	if (cmdmode =3D=3D MODE_LONG)
> -		shown_bits =3D SHOW_DEFAULT | SHOW_SIZE;
> -	return 1;
> +	return len;
>  }
>
>  static int show_recursive(const char *base, size_t baselen,
> @@ -106,6 +158,75 @@ static int show_recursive(const char *base, size_t =
baselen,
>  	return 0;
>  }
>
> +static int show_tree_init(enum object_type *type, struct strbuf *base,
> +			  const char *pathname, unsigned mode, int *retval)
> +{
> +	if (S_ISGITLINK(mode)) {
> +		*type =3D OBJ_COMMIT;
> +	} else if (S_ISDIR(mode)) {
> +		if (show_recursive(base->buf, base->len, pathname)) {
> +			*retval =3D READ_TREE_RECURSIVE;
> +			if (!(ls_options & LS_SHOW_TREES))
> +				return 1;
> +		}
> +		*type =3D OBJ_TREE;
> +	}
> +	else if (ls_options & LS_TREE_ONLY)
> +		return 1;
> +	return 0;
> +}
> +
> +static int show_tree_fmt(const struct object_id *oid, struct strbuf *ba=
se,
> +			 const char *pathname, unsigned mode, void *context)
> +{
> +	size_t baselen;
> +	int retval =3D 0;
> +	struct strbuf line =3D STRBUF_INIT;
> +	struct shown_data data =3D {
> +		.mode =3D mode,
> +		.type =3D OBJ_BLOB,
> +		.oid =3D oid,
> +		.pathname =3D pathname,
> +		.base =3D base,
> +	};
> +
> +	if (show_tree_init(&data.type, base, pathname, mode, &retval))
> +		return retval;
> +
> +	baselen =3D base->len;
> +	strbuf_expand(&line, format, expand_show_tree, &data);
> +	strbuf_addch(&line, line_termination);
> +	fwrite(line.buf, line.len, 1, stdout);
> +	strbuf_setlen(base, baselen);
> +	return retval;
> +}
> +
> +static int parse_shown_fields(void)
> +{
> +	if (cmdmode =3D=3D MODE_NAME_ONLY ||
> +	    (format && !strcmp(format, name_only_format))) {
> +		shown_bits =3D SHOW_FILE_NAME;
> +		return 1;
> +	}
> +
> +	if (cmdmode =3D=3D MODE_OBJECT_ONLY ||
> +	    (format && !strcmp(format, object_only_format))) {
> +		shown_bits =3D SHOW_OBJECT_NAME;
> +		return 1;
> +	}
> +
> +	if (!ls_options || (ls_options & LS_RECURSIVE)
> +	    || (ls_options & LS_SHOW_TREES)
> +	    || (ls_options & LS_TREE_ONLY)
> +		|| (format && !strcmp(format, default_format)))
> +		shown_bits =3D SHOW_DEFAULT;
> +
> +	if (cmdmode =3D=3D MODE_LONG ||
> +		(format && !strcmp(format, long_format)))
> +		shown_bits =3D SHOW_DEFAULT | SHOW_SIZE;
> +	return 1;
> +}
> +
>  static int show_default(struct shown_data *data)
>  {
>  	size_t baselen =3D data->base->len;
> @@ -137,24 +258,6 @@ static int show_default(struct shown_data *data)
>  	return 1;
>  }
>
> -static int show_tree_init(enum object_type *type, struct strbuf *base,
> -			  const char *pathname, unsigned mode, int *retval)
> -{
> -	if (S_ISGITLINK(mode)) {
> -		*type =3D OBJ_COMMIT;
> -	} else if (S_ISDIR(mode)) {
> -		if (show_recursive(base->buf, base->len, pathname)) {
> -			*retval =3D READ_TREE_RECURSIVE;
> -			if (!(ls_options & LS_SHOW_TREES))
> -				return 1;
> -		}
> -		*type =3D OBJ_TREE;
> -	}
> -	else if (ls_options & LS_TREE_ONLY)
> -		return 1;
> -	return 0;
> -}
> -
>  static int show_tree(const struct object_id *oid, struct strbuf *base,
>  		const char *pathname, unsigned mode, void *context)
>  {
> @@ -196,6 +299,7 @@ int cmd_ls_tree(int argc, const char **argv, const c=
har *prefix)
>  	struct object_id oid;
>  	struct tree *tree;
>  	int i, full_tree =3D 0;
> +	read_tree_fn_t fn =3D show_tree;
>  	const struct option ls_tree_options[] =3D {
>  		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
>  			LS_TREE_ONLY),
> @@ -218,6 +322,9 @@ int cmd_ls_tree(int argc, const char **argv, const c=
har *prefix)
>  		OPT_BOOL(0, "full-tree", &full_tree,
>  			 N_("list entire tree; not just current directory "
>  			    "(implies --full-name)")),
> +		OPT_STRING_F(0, "format", &format, N_("format"),
> +			     N_("format to use for the output"),
> +			     PARSE_OPT_NONEG),
>  		OPT__ABBREV(&abbrev),
>  		OPT_END()
>  	};
> @@ -238,6 +345,10 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
>  	    ((LS_TREE_ONLY|LS_RECURSIVE) & ls_options))
>  		ls_options |=3D LS_SHOW_TREES;
>
> +	if (format && cmdmode)
> +		usage_msg_opt(
> +			_("--format can't be combined with other format-altering options"),
> +			ls_tree_usage, ls_tree_options);
>  	if (argc < 1)
>  		usage_with_options(ls_tree_usage, ls_tree_options);
>  	if (get_oid(argv[0], &oid))
> @@ -261,6 +372,18 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
>  	tree =3D parse_tree_indirect(&oid);
>  	if (!tree)
>  		die("not a tree object");
> -	return !!read_tree(the_repository, tree,
> -			   &pathspec, show_tree, NULL);
> +
> +	/*
> +	 * The generic show_tree_fmt() is slower than show_tree(), so
> +	 * take the fast path if possible.
> +	 */
> +	if (format && (!strcmp(format, default_format) ||
> +				   !strcmp(format, long_format) ||
> +				   !strcmp(format, name_only_format) ||
> +				   !strcmp(format, object_only_format)))
> +		fn =3D show_tree;
> +	else if (format)
> +		fn =3D show_tree_fmt;
> +
> +	return !!read_tree(the_repository, tree, &pathspec, fn, NULL);
>  }
> diff --git a/t/t3105-ls-tree-format.sh b/t/t3105-ls-tree-format.sh
> new file mode 100755
> index 0000000000..92b4d240e8
> --- /dev/null
> +++ b/t/t3105-ls-tree-format.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +
> +test_description=3D'ls-tree --format'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success 'ls-tree --format usage' '
> +	test_expect_code 129 git ls-tree --format=3Dfmt -l &&
> +	test_expect_code 129 git ls-tree --format=3Dfmt --name-only &&
> +	test_expect_code 129 git ls-tree --format=3Dfmt --name-status &&
> +	test_expect_code 129 git ls-tree --format=3Dfmt --object-only
> +'
> +
> +test_expect_success 'setup' '
> +	mkdir dir &&
> +	test_commit dir/sub-file &&
> +	test_commit top-file
> +'
> +
> +test_ls_tree_format () {
> +	format=3D$1 &&
> +	opts=3D$2 &&
> +	shift 2 &&
> +	git ls-tree $opts -r HEAD >expect.raw &&
> +	sed "s/^/> /" >expect <expect.raw &&
> +	git ls-tree --format=3D"> $format" -r HEAD >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'ls-tree --format=3D<default-like>' '
> +	test_ls_tree_format \
> +		"%(mode) %(type) %(object)%x09%(file)" \
> +		""
> +'
> +
> +test_expect_success 'ls-tree --format=3D<long-like>' '
> +	test_ls_tree_format \
> +		"%(mode) %(type) %(object) %(size:padded)%x09%(file)" \
> +		"--long"
> +'
> +
> +test_expect_success 'ls-tree --format=3D<name-only-like>' '
> +	test_ls_tree_format \
> +		"%(file)" \
> +		"--name-only"
> +'
> +
> +test_expect_success 'ls-tree --format=3D<object-only-like>' '
> +	test_ls_tree_format \
> +		"%(object)" \
> +		"--object-only"
> +'
> +
> +test_done
> --
> 2.33.0.rc1.1802.gbb1c3936fb.dirty
>
>
>
