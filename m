Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58B620195
	for <e@80x24.org>; Sun, 17 Jul 2016 08:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbcGQIoj (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 04:44:39 -0400
Received: from mout.gmx.net ([212.227.15.19]:50802 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbcGQIof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 04:44:35 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Me8RK-1bj0Uc46Yg-00PsSo; Sun, 17 Jul 2016 10:44:29
 +0200
Date:	Sun, 17 Jul 2016 10:44:27 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/3] fsck_walk(): optionally name objects on the go
In-Reply-To: <xmqqeg6wrw2m.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607171026420.28832@virtualbox>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <f5ef009d2be6bf0137b33ac9ce85ff0ce03a48e8.1468510191.git.johannes.schindelin@gmx.de> <xmqqeg6wrw2m.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-732134256-1468745069=:28832"
X-Provags-ID: V03:K0:4BUsvALHEy3zZKVcDLJ/1zJESe1oNaD18CrCPY0YVdI9V2G6LbG
 m076ByY5ptRiAF+JH+jrI0H5+Z2RtEB7J0p5tUY7mX4NBAL341HIc8oAZExGSUfDWeSWHFC
 ok8C5IIyDaQIZalj1D0bGa+D/5s0Xem6K/U6mvmaIRaaEdnJLRVm9sEgjqd08HysG4q7aHK
 Jk9QpT5j4/AxfIyORr1qA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:SnevD0joLUg=:GtlMSL8UqNo9pD5IgTwnOX
 LT/wSRJVwVcdZYD2/t6dIh3FxCrszjt/HpWkX6gkDMMusY0coQKvl4WHVsnwrYXZ2VnfubpeK
 cQBl606pIZzsQs6dCEz57NyTscwvtfdBPCl0e/SKuBhIrHT/Q/bugKGfAqzO0vNlPMwh/Pzpg
 H7bj38ywV0d9hTi2ap/Gb8jWeborKgRjej0tUx/Tv6vwUXcR3o+uqOgSzY8pbMhsLO+68QY2v
 UEgG4nZNpzqHOVMFZAnqAU9SB97I9FCo/Y1p+oY6AqFdjo8Kg/jIn47277h0NHUBEZcde1DBq
 +5SMXwqVtM3B5dzWBuX0rUiCYenM+zSrVkTOZyr5Z4HB5XDIdzac7XC/Acij5TMYhg5V+5ijJ
 EccFpmgmASzuvBA2rrMoq249Nhcx7/fn2dO/DTju6v7ZIJiMdgZ0Hk9+SGokjqkUWakTf4q35
 fdMipDt2iHMmfnM2fJfurkyj+LCqf6XxAy1VsiKVsOyZpPQJwHfpomDCqsYNce0YRIxXQjm4r
 ZFbQDu/PXP7WVbp2m81dV/mmLTbvQzKdV/P6/TgrOJ+OvKeAtZw0/GXrZw7Nb1uGlq17/LSEb
 VbkY795OWHpDuUbirqhaFsaI3Qw2IiX6MnQhHNh/HC1h+k4iWblrEDSpHnZCFB8K6BxskNKdN
 Qbl47u7zBrqc32l7p+OKPmPV6KjngXihkjGjHeOQ2NLS9gVB/jW5KLgo4s1wvrGhx+swBhekc
 9ZxboSSqbxS53TSzDotH2Zj5/x5k0TEVRlWhnC5auu6guO28tNlTqLSZaO+EXa2tacHLUnS4w
 jQph7K2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-732134256-1468745069=:28832
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 14 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>=20
> > Note that this patch opts for decorating the objects with plain strings
> > instead of full-blown structs (=C3=A0 la `struct rev_name` in the code =
of
> > the `git name-rev` command), for several reasons:
> >
> > - the code is much simpler than if it had to work with structs that
> >   describe arbitrarily long names such as "master~14^2~5:builtin/am.c",
> >
> > - the string processing is actually quite light-weight compared to the
> >   rest of fsck's operation,
> >
> > - the caller of fsck_walk() is expected to provide names for the
> >   starting points, and using plain and simple strings is just the
> >   easiest way to do that.
>=20
> Simpler is good; we can always optimize something well-isolated like
> this later if it proves necessary.

I am glad we agree!

> > +static char *get_object_name(struct fsck_options *options, struct obje=
ct *obj)
> > +{
> > +=09return options->object_names ?
> > +=09=09lookup_decoration(options->object_names, obj) : NULL;
> > +}
> > +
> > +static void put_object_name(struct fsck_options *options, struct objec=
t *obj,
> > +=09const char *fmt, ...)
> > +{
> > +=09va_list ap;
> > +=09char *existing =3D lookup_decoration(options->object_names, obj);
> > +=09struct strbuf buf =3D STRBUF_INIT;
>=20
> When reading a few early calling sites, it wasn't quite obvious how
> the code avoids the "naming" when .object_names decoration is not
> initialized (which is tied to the --name-objects option to decide if
> the feature needs to be triggered).  The current "if get_object_name
> for the containing object gives us NULL, then we refrain from
> calling put_object_name()" may be good enough, but having an early
> return similar to get_object_name() would make it easier to grok,

My knee-jerk reaction was: in order to name objects in this part of the
code, we need the name of the parent/tree/whatever, so yeah, we have
object_names.

But you're right, it is much easier to read with the early returns.

And who knows, maybe the fsck.c code will learn to name the starting
points itself in the future?

> >  =09while (tree_entry(&desc, &entry)) {
> >  =09=09int result;
> > =20
> > +=09=09if (name) {
> > +=09=09=09struct object *obj =3D parse_object(entry.oid->hash);
>=20
> This worries me somewhat.  IIRC, "git fsck" uses object->parsed to
> tell between objects that are unreachable or not and act differently
> so I would fear that parsing the object here would screw up that
> logic, when the call comes from fsck_dir() -> fsck_sha1_list() ->
> fsck_sha1() -> fsck_obj() -> fsck_walk() -> fsck_walk_tree()
> codepath.  Is it no longer the case, I wonder?
>=20
> I see in the same loop there is a call to lookup_tree()->object, which
> probably is how the existing code avoids that issue?

Most likely. I factored that out so that the object is looked up first,
and reused via object_as_type() for the tree/blob cases.

Both concerns will be addressed in the next iteration.

Thanks,
Dscho
--8323329-732134256-1468745069=:28832--
