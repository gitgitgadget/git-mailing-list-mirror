Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695791FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbcIAIqU (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:46:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:51050 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753891AbcIAIp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:45:59 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mbxdm-1bM43y3fFO-00JLXp; Thu, 01 Sep 2016 10:45:52
 +0200
Date:   Thu, 1 Sep 2016 10:45:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
In-Reply-To: <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011038430.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-843252816-1472719552=:129229"
X-Provags-ID: V03:K0:f/BuKMbOmhQMfiX0OuiDNNNWzf/E5UuI0lgm5lW+Ad/OGdgzWVv
 hNkZ+SUb+9/eQ8h1jaoF1W17WqbDzoIPf+5hkN17/w6X+ytY/wLe4VXPvAthRRa7BuMbOnQ
 /85IEQHhFhjYX6j/sRtbGZ3l+lEOdZElzwhtIdkVCv7GsE6X3N2d50c9BYMTXOShwy16+88
 lYgC96utVnI8msNVWSKig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5/UmAVpoilk=:8uqfAazs6L08Vonzr3GoGY
 FL9LV1oJ6mktIzs8NYHGWIUesR1d2V6s7+SgVFKBhCUOMZmotkQWOE/vZT868IUsDCXZeAw7T
 yQbUspeZbiYmhS0NUvhPFQCKpXv77tLxhu1P2ZTXkkhBLKEVR4TCePlX0+yt0pd9r9opdZwNL
 uJMNeKoH87lNnZa3JehlprWEONYpBHVjNZgb3o1aSefm4wKYPB65HsBxtRic4s9DhFXLrRDXA
 fK2bZqw6NrcWAt/sAOHdHrQJRjchWx8xjjLEAt0704OzIL4QpnkN64wcaY2Ghtf1QcHTve1hk
 +i5yBWL+eqQ01h1oiFHl6mLzJU7hsBnpQxXZG2W8W8P+OcDuy0dxmJkYdr8ko6fRJwNCxSi6Z
 fN+5ZT1YmKlJzFKWynFgmEKqVurb0u2kteeDDK7T8gJNoq5dHOxX6aFdTdppFxG1d7ndeBh5H
 BZG/ltvGkAMASD9FQ5GHmOFOgMuKLX/78+s5k2LWYxBWCq8W6U85BOO6ZCCwnyUpkMWMZ35Me
 6jgsua4yI3wPxB7CN/JaqZaiuNEHL83d2i/lJz2t2E7/qbZyJT0TlQ8upTY15cpwT/n0QGCPY
 XJlvuqXZ5NF7d2PF6TWbsv6kOpHSZCloKKjVUc+8f1VbMQeqisikdlhvPTL7C33XsuGGmycCe
 6fwLo4KqiYh6IROEs+XnCYnA3bzy6oa0WwdNCBF+cyvkE02dqNCDT164OcLDkVR4epgw4Wtd1
 b6seTEJ3Dz+rOiIxsymhfeCt/M1wewJPj+5syOq2Um3IpJgSwcUX2WJx3Aodz4cU9B6bXGaAg
 OjP5S86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-843252816-1472719552=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 31 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:05, Johannes Schindelin pisze:
>=20
> > The `git-rebase-todo` file contains a list of commands. Most of those
> > commands have the form
> >=20
> > =09<verb> <sha1> <oneline>
> >=20
> > The <oneline> is displayed primarily for the user's convenience, as
> > rebase -i really interprets only the <verb> <sha1> part. However, there
> > are *some* places in interactive rebase where the <oneline> is used to
> > display messages, e.g. for reporting at which commit we stopped.
> >=20
> > So let's just remember it when parsing the todo file; we keep a copy of
> > the entire todo file anyway (to write out the new `done` and
> > `git-rebase-todo` file just before processing each command), so all we
> > need to do is remember the begin and end offsets.
>=20
> Actually what we remember is pointer and length, or begin offset and leng=
th,
> not offset and offset.

Right. Fixed.

> > diff --git a/sequencer.c b/sequencer.c
> > index 06759d4..3398774 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_opt=
s *opts)
> >  struct todo_item {
> >  =09enum todo_command command;
> >  =09struct commit *commit;
> > +=09const char *arg;
> > +=09int arg_len;
>=20
> Why 'arg', and not 'oneline', or 'subject'?
> I'm not saying it is bad name.

Because we will use it for `exec` commands' args, too. Clarified in the
commit message.

> > @@ -760,6 +762,9 @@ static int parse_insn_line(struct todo_item *item, =
const char *bol, char *eol)
> >  =09status =3D get_sha1(bol, commit_sha1);
> >  =09*end_of_object_name =3D saved;
> > =20
> > +=09item->arg =3D end_of_object_name + strspn(end_of_object_name, " \t"=
);
> > +=09item->arg_len =3D (int)(eol - item->arg);
> > +
>=20
> Does it work correctly for line without <oneline>, that is
>=20
>   =09<verb> <sha1>
>=20
> I think it does, but I not entirely sure.

It does work correctly: in the example, *end_of_object_name would be '\n',
and strspn(end_of_object_name, " \t") would return 0.

Thanks for the review!
Dscho
--8323329-843252816-1472719552=:129229--
