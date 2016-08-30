Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB9C1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758286AbcH3RxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:53:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:53674 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757222AbcH3RxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:53:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MF4eJ-1buWWN3gqJ-00GLtI; Tue, 30 Aug 2016 19:53:00
 +0200
Date:   Tue, 30 Aug 2016 19:52:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when
 reading options
In-Reply-To: <9797cb9e-115c-bbea-51d2-a5d686aca514@gmail.com>
Message-ID: <alpine.DEB.2.20.1608301948310.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de> <9797cb9e-115c-bbea-51d2-a5d686aca514@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-842957034-1472579580=:129229"
X-Provags-ID: V03:K0:Z/SJjRLmGaRkhYNuJaY4mkpit9XF4OOyZnJmwnJUqF3JpBTe3VE
 XDZpA8LbAQDujzA7GBlrYvxWhsUbQLFE5O4LAyYboM9PXTfMQ++xx0n6RhlmQTgc2e7MPzc
 41dvpMuGDhsFWprsBJAMMWU6lfYcNIEht4EpVr6JbefWosmosPTqvVTRMt3Ndoz0qXCjnX/
 1tSGiupdlCXJQgXCjFuMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4TDPnIWoiSQ=:DjZUJKaJ4mR27W06zky03N
 BVbljnGKgEo7/eRwquJyXTyX1jxI4dmDVNevB0usYiJt1RW9KzZANGqHhKfJTklZOjTxoWGn/
 Zfbz4w+kwGf7KzLwKP3swkwTNDB0Y4d/zlVhtHVWZKqOmB7W82dcsGx+s6AWzwApWk7Sze/fG
 cQsqwzpK+0lROCHOLcO3xAV7CYaqMboBiVyxr55tDwUC6tYNK7sq49Gu1sUTmlqcIGPfwobCz
 qI0bTvbUMBxvcqL/1yGyZRL7W/nI2mOrxyy/tEx4dPxOFB4QGPzo10/0JmoK5zkV284Z94wYB
 zA2v/zVMfQewR5WsNll5KIKpDQsWo3xxl8RkVwYIewYhQ0B1AH77Y5q4hkvp/rd7Qh3gVhUR+
 rys9LWxmMNhiKnTJsSVFPnhvvmoHBCkySmf/EjsNy2FKxLqpQQcPBCEkNBhfu+hUs4LzzwmTT
 0HbPLuVTQ9R8TC0UsK3jGMWHERtgPRwB3VKVacudPvANfbfrYN5t9KWchJ4/7UsccBuWFq5p4
 kjzaSc7+mCuCcYTmXtMK90NGljsOnToBxdE20lD7ja75Nj2lu3UAJya1dG/A7PlF9wn7hh5+j
 0ZJhEBtaLpRbZAvEYRTfNbiLWG+pQiJiRvxsNb1mDXQnaaQXE2lvuwEs/sVU45r5XewPyWlq8
 /t1QCvx64Aw2dS/bOTFWlTW+jTR5F2YvKlMv3w7mfiBB9ezUNtXZvegszeVN6Z09AE47J8aBk
 gOiRYsC5G1vWo5H5LcU/2EvcIJ/5vF9tYu10Rv9/bnTjEsfEKK6xPjR7PtPDxA+ON67BbhLyJ
 84hALC6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-842957034-1472579580=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Tue, 30 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:
>=20
> > The sequencer reads options from disk and stores them in its struct
> > for use during sequencer's operations.
> >=20
> > With this patch, the memory is released afterwards, plugging a
> > memory leak.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  sequencer.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index b5be0f9..8d79091 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -131,6 +131,8 @@ static void remove_sequencer_state(const struct rep=
lay_opts *opts)
> >  =09=09free(opts->owned[i]);
> >  =09free(opts->owned);
> > =20
> > +=09free(opts->xopts);
> > +
>=20
> This looks like independent change, not related to using the
> sequencer_entrust() to store options read from disk in replay_opts
> struct to be able to free memory afterwards.
>=20
> I guess you wanted to avoid one line changes...

Actually, it is not an independent change, but it free()s memory that has
been allocated while reading the options, as the commit message says ;-)

> > @@ -811,13 +813,18 @@ static int populate_opts_cb(const char *key, cons=
t char *value, void *data)
>=20
> Sidenote: this patch would be easier to read if lines were reordered
> as below, but I don't think any slider heuristics could help achieve
> that automatically.  Also, the patch might be invalid...
>=20
> >  =09=09opts->allow_ff =3D git_config_bool_or_int(key, value, &error_fla=
g);
> >  =09else if (!strcmp(key, "options.mainline"))
> >  =09=09opts->mainline =3D git_config_int(key, value);
> > -=09else if (!strcmp(key, "options.strategy"))
> > +=09else if (!strcmp(key, "options.strategy")) {
> >  =09=09git_config_string(&opts->strategy, key, value);
> > +=09=09sequencer_entrust(opts, (char *) opts->strategy);
>=20
> I wonder if the ability to free strings dup-ed by git_config_string()
> be something that is part of replay_opts, or rather remove_sequencer_stat=
e(),
> that is a list of
>=20
> =09free(opts->strategy);
> =09free(opts->gpg_sign);

That is not necessarily possible because the way sequencer works, the
options may have not actually be read from the file, but may be populated
by the caller (in which case we do not necessarily want to require
strdup()ing the strings just so that the sequencer can clean stuff up
afterwards).

> Though... free(NULL) is nop as per standard, but can we rely on it?

We can, and we do.

> The *_entrust() mechanism is more generic, but do we use this general-nes=
s?
> Well, it could be xstrdup or git_config_string doing entrust'ing...

Right, but that is exactly what I wanted to avoid, because it is rather
inelegant to strdup() strings just so that we do not have to record what
to free() and what not to free().

BTW I have no objection at all to generalize this sequencer_entrust()
mechanism further (read: to other, similar use cases), should it withstand
the test of time.

Ciao,
Johannes
--8323329-842957034-1472579580=:129229--
