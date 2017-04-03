Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1E51FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 22:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdDCWsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:48:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:64001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdDCWsE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:48:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1j6-1d1lOp15w0-006h5d; Tue, 04
 Apr 2017 00:47:59 +0200
Date:   Tue, 4 Apr 2017 00:47:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] ref-filter: avoid using `unsigned long` for
 catch-all data type
In-Reply-To: <342cae56-ef58-3542-202d-6dd04d5777e8@web.de>
Message-ID: <alpine.DEB.2.20.1704040044420.4268@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de> <bf91c11bd145a2f4b049ac02c02a18e58c496834.1491159939.git.johannes.schindelin@gmx.de> <342cae56-ef58-3542-202d-6dd04d5777e8@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1317931995-1491259679=:4268"
X-Provags-ID: V03:K0:OMYxns7Ayk6tX0KtfZpeCzIIKKx4BWGNyeEYAaPwKGDA9Im/lHs
 Sj0y8SiPkKGvOdEIKkeSoMI1EZIpccGrIJeCHO9p2tZ8hww/xq6eHdBqaMUthxXOW0kZfnP
 Ve6Ei5DRlRpLvQUB0fgGJQkuTxrGMDjVlw9piXJmM+MDNCDXEfQ1vQKmbhPD5sqs0bJxohz
 FfjvyeU4uGBpdKIO8/UwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c1hMsazfuAY=:lExhr94baGARvBN2G1B8nz
 pWX+RU7xtv5IXQma3hO0+7Dc2AX4upcN66fdR32BgO2U4q72GFKlbiLiOb6n3cDLOj9a3nVkW
 tQ8p5onE2DXhUFEc4hkyq35lUyIlJWhaoRnne70Z+prjh4VkXJYFniqrplUmWkYgFMTR2ULRX
 ivvT9rOUVRWLmy2chX2qzEgcYkbNE6SvsIiChqQCTsbnMPTyNmFw71ibuvwnrhl7o/ZOW9586
 Fc+LpoO/E/4hQYHaDF6gCUCc87OPCkG4qQqJbV1jOK66oi2F+xl23ZpvgXessZnIWkRK3zosw
 MM/1Ji4iSmgscWZo3MdJ/wgLaZE4EtLu5rGZWGaDr7mJ3TX0BuXq6llXCCxhpy7eKriO1//ma
 VUgTNwoUF9jg3NT9ZMG/vg8Wy2OkEFZf8UQKlRFLXoZmoBytmTyNIrfvjRQoKXokwOWJf+NBB
 gSE/LRXNckntxscJvYerI2u1C8nLxUDdEi+RU6tZivUuPZrC4J1LDu8WY4vYxfAD9v6YwpPcb
 qBCJbUXK+vVKKXO/YYe7YxJ83nW/hUJwwc2cWEc/36mgjD3Rt1WOyNoLxNCaDv+3PyQqEj9U3
 IvfOuq0dm7BfKDDJiFOWizGBmBu8h7gYIsXE1SWiieYGjgefVip5agkkkfqbWnNFeNavx0vbi
 f8IAL6BZ0nywRO+FDaC/0lWCtvDeWtk88psIfWHelj0rM6khfrdlFWqzjkTbHZtYQEUBtpjII
 00N5dg/qSccD3am1VXIQOVe2kik9TPMHL/QhNLxW4QxmzMn+KXVsZqWR+0JUjW7ZZJCIqguZ+
 VTmrpSJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1317931995-1491259679=:4268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Mon, 3 Apr 2017, Torsten B=C3=B6gershausen wrote:

> On 02/04/17 21:06, Johannes Schindelin wrote:
> > In its `atom_value` struct, the ref-filter source code wants to store
> > different values in a field called `ul` (for `unsigned long`), e.g.
> > timestamps.
> >
> > However, as we are about to switch the data type of timestamps away fro=
m
> > `unsigned long` (because it may be 32-bit even when `time_t` is 64-bit)=
,
> > that data type is not large enough.
> >
> > Simply change that field to use `uintmax_t` instead.
> >
> > This patch is a bit larger than the mere change of the data type
> > because the field's name was tied to its data type, which has been fixe=
d
> > at the same time.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ref-filter.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 9c82b5b9d63..8538328fc7f 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -351,7 +351,7 @@ struct ref_formatting_state {
> >  struct atom_value {
> >   const char *s;
> >   void (*handler)(struct atom_value *atomv, struct ref_formatting_state
> >   *state);
> > -=09unsigned long ul; /* used for sorting when not FIELD_STR */
> > +=09uintmax_t value; /* used for sorting when not FIELD_STR */
> >  =09struct used_atom *atom;
> >  };
> >
> > @@ -723,7 +723,7 @@ static void grab_common_values(struct atom_value *v=
al,
> > int deref, struct object
> >    if (!strcmp(name, "objecttype"))
> >    =09v->s =3D typename(obj->type);
> > =09=09else if (!strcmp(name, "objectsize")) {
> > -=09=09=09v->ul =3D sz;
> > +=09=09=09v->value =3D sz;
> >    =09v->s =3D xstrfmt("%lu", sz);
> >    }
> >    else if (deref)
> > @@ -770,8 +770,8 @@ static void grab_commit_values(struct atom_value *v=
al,
> > int deref, struct object
> >    =09v->s =3D xstrdup(oid_to_hex(&commit->tree->object.oid));
> >    }
> >    else if (!strcmp(name, "numparent")) {
> > -=09=09=09v->ul =3D commit_list_count(commit->parents);
> > -=09=09=09v->s =3D xstrfmt("%lu", v->ul);
> > +=09=09=09v->value =3D commit_list_count(commit->parents);
> > +=09=09=09v->s =3D xstrfmt("%lu", (unsigned long)v->value);
>=20
> If we want to get rid of "%lu" at some day, we can do like this:
> v->s =3D xstrfmt("%" PRIuMAX, v->value);
> Or, to make clear that under all circumstances an unsigned long is big en=
ough
> to
> hold the counter, for readers in the future, use something like this:
> =09=09=09v->s =3D xstrfmt("%lu", (xulong_t)v->value);

We could do that, yes.

But part of my patch series is to clarify in a semantic way what the
purpose of the code is. Your solution would keep it syntactically correct,
of course, but it would also make it semantically unclear again.

By writing "%"PRIutime *instead of* "%"PRIuMAX, we are saying: look, we
are talking about a timestamp here. That would not at all be clear if we
wrote "%"PRIuMAX.

Ciao,
Johannes
--8323329-1317931995-1491259679=:4268--
