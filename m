Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93071F859
	for <e@80x24.org>; Tue, 30 Aug 2016 07:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbcH3H3p (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 03:29:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:51604 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751501AbcH3H3o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 03:29:44 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Ltr89-1avQgO3O6f-011Eal; Tue, 30 Aug 2016 09:29:37
 +0200
Date:   Tue, 30 Aug 2016 09:29:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
In-Reply-To: <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
Message-ID: <alpine.DEB.2.20.1608300915470.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de> <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1654037498-1472542177=:129229"
X-Provags-ID: V03:K0:JAAzx8F0V2jfo/ZyeQa7OLrQozgCuA/lnIN9byKqZOSrSc56+xL
 h3FsKB+hhee7F5is6V0kklcg8qUdo5AZ4CZITRQkotnE5xxd045iuNFCHdOagfRuOEMqeuv
 lSVmYYE4iozEm7w1IQJRr8ptryMs+Xwa7DrZSasqfAdQxyHmq0FJqpWIOGl1nDNMY+M9qqH
 ROnnuYcqWa51F6LnvI7iw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NuvcbwQ+Y5A=:x/cQoofGF6uhZ9h+5tq2r0
 3WrGq97PHbPXXf1LdMfmdmAeIzZCSI5tnvIrHfxL8Fgr/0B8iETMR/TeguRDs4K1WmC2T+4oY
 hk4kynxqWlS8ZjYRzkss4nmp7OhiFp53zO5NahD83aHDdbl+N6FTDg3kWJo2lSxtr91K0KE8E
 +a8kDTSEjrFo4JUrj7Bexu1Dw97AR+NWMnt0KaW9V9QIaRfBXPBrbxenFfUDuKLihviV+mxkG
 1494bGLT8rFS7STz0AdFKmyJU3tPGMrCt1/HBmiHuXTyPfHpXEdnu089N1bZg9I1dnYtsu8T9
 rGoNb4PYFnaGNFRhEq9x9mkbwuwN8L8DgKtsc7sVMtBp+ZmpKvIw45gGtgDg+6F6IwhI5gvXc
 nr0YrKp+6HFk8hvI7U3Gh+smPw5X6lWKHH0TNdMC8bedmSaOJxZcdiXq+EqcMzAWIq8SCXAtF
 891Sfo97WsbOzJk4u3RezIJsptJ71BrC7obFI7kv/HwpPS5q5Px+a9cdwu6OzRxbwClbsEeYf
 IIACVSRm+dHFolXiQ3AEFVAtLN2heJlW5fvYpRbqAlV2chlYo+A9Gh2/nBAvbGgjnN5CLrDte
 FhXeBbp5rWgPBAymXbkUJLL5d9vRjwaE1r0MpfV5YMaP2PoSgoI68KVZHC69NpM/CAT5zgksQ
 wKAmAMF0i9XJjlImBVc1wvWn/cmCxBmk0VpmEZYZk2Jh5bx2gOHoJ1Zhrc5E/Nf2GOuQJccm8
 RPLlyLK7UfZwxKccv3BGZTDKJgeN4ns865w7nK6vewBao06CTVpI1DTNqipeMb4ddNtKUMzrM
 mq3HfBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1654037498-1472542177=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 29 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>=20
> > The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
> > like a one-shot command when it reads its configuration: memory is
> > allocated and released only when the command exits.
> >=20
> > This is kind of okay for git-cherry-pick, which *is* a one-shot
> > command. All the work to make the sequencer its work horse was done to
> > allow using the functionality as a library function, though, including
> > proper clean-up after use.
> >=20
> > This patch introduces an API to pass the responsibility of releasing
> > certain memory to the sequencer.
>=20
> So how this API would be / is meant to be used?

I added an example to the commit message.

> Would sequencer as a library function be called multiple times,
> or only once?

The point of a library function is that it should not care.

> I'm trying to find out how this is solved in other places of Git
> code, and I have stumbled upon free_util in string_list...

I wanted this to be flexible enough to take care of any type of data, not
just strings.

And while the string_list has a void *util field, it would be rather silly
to add strings to a string list for the sole purpose of free()ing their
util fields in the end.

(That was the conclusion I came to after a search of my own.)

> > +void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_af=
ter_use)
> > +{
> > +=09ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
> > +=09opts->owned[opts->owned_nr++] =3D set_me_free_after_use;
> > +
> > +=09return set_me_free_after_use;
>=20
> I was wondering what this 'set_me_free_after_use' parameter is about;
> wouldn't it be more readable if this parameter was called 'owned_data'
> or 'owned_ptr'?

If I read "owned_ptr" as a function's parameter, I would assume that the
associated memory is owned by the caller. So I would be puzzled reading
that name.

> >  static void remove_sequencer_state(const struct replay_opts *opts)
> >  {
> >  =09struct strbuf dir =3D STRBUF_INIT;
> > +=09int i;
> > +
> > +=09for (i =3D 0; i < opts->owned_nr; i++)
> > +=09=09free(opts->owned[i]);
>=20
> I guess you can remove owned data in any order, regardless if you
> store struct or its members first...

Indeed, this is not like a C++ destructor. It's free().

> > diff --git a/sequencer.h b/sequencer.h
> > index c955594..20b708a 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -43,8 +43,14 @@ struct replay_opts {
> > =20
> >  =09/* Only used by REPLAY_NONE */
> >  =09struct rev_info *revs;
> > +
> > +=09/* malloc()ed data entrusted to the sequencer */
> > +=09void **owned;
> > +=09int owned_nr, owned_alloc;
>=20
> I'm not sure about naming conventions for those types of data, but
> wouldn't 'owned_data' be a better name?  I could be wrong here...

The convention seemed to be "void *X; int X_nr, X_alloc;", so I stuck with
it.

Thanks for your review!
Johannes
--8323329-1654037498-1472542177=:129229--
