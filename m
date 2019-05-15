Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8351F461
	for <e@80x24.org>; Wed, 15 May 2019 22:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEOWog (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:44:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36554 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfEOWog (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 May 2019 18:44:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:89af:9dea:d4e0:996c])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CA25360443;
        Wed, 15 May 2019 22:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557960270;
        bh=Lzz+P06Lj8QkSAXHEJG5TMEtQu52udshPtwDcTnEfH8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AVoCpInVKCwkZTLlzsODumlC5qiMWx3GdxK3a9u6J1wD+yAwsOMR0IqeMNOt+jI48
         q0MIFOtpuEQx9ZWq2/hYs2A/20LMOqlbW3FtieKLenuzS0pd7/mg6WfOSwdn4fmzoq
         M2GcQMgu3fVyb4nc9PJXmKE46Fq+mcoooO0TQw/2sK2tBxsE4HwcpN25jZcfb1eJ7i
         nk1e2uTPWVCDQTu+Xcvr12KdFv2OHrkhy3aP6GOx+ooDQrJrVDsNtiSNIWUBWYmO2X
         ozk3yRV7hhqA5kykRoK1t1XQEJT9wwE4LbsyFWsj+QdRktZYhCXEL5HD4nWzkDx7Gl
         BbzLl2mAOlO7YB50xtNfdGVHp8xK0fNLmrpXMCezYhS81Nu9Fxs29lbbs3bcHvdlcR
         dm4z13Jault5A0Kr30u5fJrkK2hLdMPXDMussSxS7pxrSbsi4oD9rsxMvGqL0xt1Rn
         4BotCo/Mv6SDBYcsTX/Dtd3d0he27a2fosbEP2UzXQdWkzTqJ6x
Date:   Wed, 15 May 2019 22:44:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple
 hooks
Message-ID: <20190515224425.GK7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1905141653130.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr6OvWOSyJed8q4v"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905141653130.44@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yr6OvWOSyJed8q4v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 05:12:39PM +0200, Johannes Schindelin wrote:
> Hi brian,
>=20
> On Tue, 14 May 2019, brian m. carlson wrote:
>=20
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 833ecb316a..29bf80e0d1 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -943,7 +943,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
> >  		return 0;
> >  	}
> >
> > -	if (!no_verify && find_hook("pre-commit")) {
> > +	if (!no_verify && find_hooks("pre-commit", NULL)) {
>=20
> Hmm. This makes me concerned, as `find_hook()` essentially boiled down to
> a semi-fast `stat()` check, but `find_hooks()` needs to really look,
> right?
>=20
> It might make sense to somehow keep the list of discovered and executed
> hooks, as we already have a call to `run_commit_hook()` to execute the
> `pre-commit` hook at the beginning of this function.

With NULL as an argument, we return 1 as soon as we know there's a
single hook, so this is fairly optimized. I've tried to make it as cheap
as possible to check.

> Speaking of which... Shouldn't that `run_commit_hook()` call be adjusted
> at the same time, or else we have an inconsistent situation?

Nope, it calls run_hook_ve, which is updated.

> > diff --git a/run-command.c b/run-command.c
> > index 3449db319b..eb075ac86b 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -1308,53 +1308,143 @@ int async_with_fork(void)
> >  #endif
> >  }
> >
> > +/*
> > + * Return 1 if a hook exists at path (which may be modified) using acc=
ess(2)
> > + * with check (which should be F_OK or X_OK), 0 otherwise. If strip is=
 true,
> > + * additionally consider the same filename but with STRIP_EXTENSION ad=
ded.
> > + * If check is X_OK, warn if the hook exists but is not executable.
> > + */
> > +static int has_hook(struct strbuf *path, int strip, int check)
> > +{
> > +	if (access(path->buf, check) < 0) {
> > +		int err =3D errno;
> > +
> > +		if (strip) {
> > +#ifdef STRIP_EXTENSION
> > +			strbuf_addstr(path, STRIP_EXTENSION);
> > +			if (access(path->buf, check) >=3D 0)
> > +				return 1;
> > +			if (errno =3D=3D EACCES)
> > +				err =3D errno;
> > +#endif
> > +		}
>=20
> How about simply guarding the entire `if()`? It is a bit unusual to guard
> *only* the inside block ;-)

I can make that change.

> > +
> > +		if (err =3D=3D EACCES && advice_ignored_hook) {
>=20
> Didn't you want to test for `X_OK` here, too? The code comment above the
> function seems to suggest that.

Yeah, that makes sense. I'll do that.

> > +			static struct string_list advise_given =3D STRING_LIST_INIT_DUP;
> > +
> > +			if (!string_list_lookup(&advise_given, path->buf)) {
> > +				string_list_insert(&advise_given, path->buf);
> > +				advise(_("The '%s' hook was ignored because "
> > +					 "it's not set as executable.\n"
> > +					 "You can disable this warning with "
> > +					 "`git config advice.ignoredHook false`."),
> > +				       path->buf);
> > +			}
> > +		}
> > +		return 0;
> > +	}
> > +	return 1;
>=20
> Wouldn't it make sense to do this very early? Something like
>=20
> 	if (!access(path->buf, check))
> 		return 1;
>=20
> first thing in the function, that that part is already out of the way and
> we don't have to indent so much.

Sure. That's a nice improvement.

> >  const char *find_hook(const char *name)
> >  {
> >  	static struct strbuf path =3D STRBUF_INIT;
> >
> >  	strbuf_reset(&path);
> >  	strbuf_git_path(&path, "hooks/%s", name);
> > -	if (access(path.buf, X_OK) < 0) {
> > -		int err =3D errno;
> > -
> > -#ifdef STRIP_EXTENSION
> > -		strbuf_addstr(&path, STRIP_EXTENSION);
> > -		if (access(path.buf, X_OK) >=3D 0)
> > -			return path.buf;
> > -		if (errno =3D=3D EACCES)
> > -			err =3D errno;
> > -#endif
> > -
> > -		if (err =3D=3D EACCES && advice_ignored_hook) {
> > -			static struct string_list advise_given =3D STRING_LIST_INIT_DUP;
> > -
> > -			if (!string_list_lookup(&advise_given, name)) {
> > -				string_list_insert(&advise_given, name);
> > -				advise(_("The '%s' hook was ignored because "
> > -					 "it's not set as executable.\n"
> > -					 "You can disable this warning with "
> > -					 "`git config advice.ignoredHook false`."),
> > -				       path.buf);
> > -			}
> > -		}
> > -		return NULL;
>=20
> So that's where this comes from ;-)

Exactly. I didn't make a lot of changes.

> > +/*
> > + * Returns the paths to all hook files, or NULL if all hooks are missi=
ng or
> > + * disabled.
>=20
> Left-over comment?

Yup, thanks for pointing it out.

> > + * Returns 1 if there are hooks; 0 otherwise. If hooks is not NULL, st=
ores the
> > + * names of the hooks into them in the order they should be executed.
> > + */
> > +int find_hooks(const char *name, struct string_list *hooks);
> > +/*
> > + * Invokes the handler function once for each hook. Returns 0 if all h=
ooks were
> > + * successful, or the exit status of the first failing hook.
> > + */
> > +int for_each_hook(const char *name,
> > +		  int (*handler)(const char *name, const char *path, void *),
> > +		  void *data);
>=20
> My gut says that it would make sense for `struct repository *` to sprout a
> hashmap for hook lookup that would be populated by demand, and allowed
> things like
>=20
> 	hash_hook(r, "pre-commit")

Knowing that we have an optimized check, do you still think we should do
this, or are you okay leaving it as it is?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--yr6OvWOSyJed8q4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzclkkACgkQv1NdgR9S
9ovzTw/+J1irwI0IKeRcQ1ZutWFYVBtG3dpjwARQ34Q2mGl4f5bryEWqWR5VuU6C
fRc0MfZLySi/EfjLKDq76hAAaM/+Yd/JvPJR/3cQdQilMX16l/obzsFTzV1isAP/
ThDKUXCK+Z6KbqnrguyeAmkNpV2rE9ZyCH/I/G3LGdIBFUjZC8kczBwARTZqd/GD
JnQzUk7lQK7MLEgXFJZIPECSn5wf5yuZUYhL3AKxNdrrAGMxeybE6N1k1Lm0dNZt
bnrn42h0WnWmRBL4EyYHn0cmrvoVG9fIZ9EIhvbvbBGI/L21ciiSlU4z+IqHkdlc
4VQ8NljYalKIXWzEKwoiJsOu4aV9/R5NcmLjI0kPAVudxMbfUj6/hj/9wVIBaB9M
OhdDqcBsHDCzMTNJuW2ItG5hsKA4gK5/pf19yIs5LTmocxpxSIgE0ol99s71v9ZM
Ui+zfGqal642sHXAIJl0q6fyRtrf9+EXZjLtOYDNqOok+56pZT4Lco31DepT2obx
Jynv0nPZ42qUGDQXVof4VBmE1JodGCVVJ843XUPczDnbnmxit+F/lk39P0RuwL+J
JWa4BW+QpDm7bCVX5JqPEI35bU2CaGUPGOrhOAx//Cssg3WwMJloJqe8hteV/i49
z6wsjQCgI/fBGT4s1wyvHomT8rRUfUdV++IMU4R4yI3AGhWLyp4=
=ofmC
-----END PGP SIGNATURE-----

--yr6OvWOSyJed8q4v--
