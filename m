Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052571F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 13:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933098AbcIAN4f (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 09:56:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:59489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933023AbcIAN4e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 09:56:34 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MSuMn-1bY4SR1fS1-00Rmdo; Thu, 01 Sep 2016 15:56:06
 +0200
Date:   Thu, 1 Sep 2016 15:56:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/22] sequencer: support cleaning up commit messages
In-Reply-To: <9f2cbc74-3e4d-e7f1-d2dd-e85e0b9168b1@gmail.com>
Message-ID: <alpine.DEB.2.20.1609011543290.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <eeb3d11d235a0220a9a125a21d1b09a73d2c61dc.1472457609.git.johannes.schindelin@gmx.de> <9f2cbc74-3e4d-e7f1-d2dd-e85e0b9168b1@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-352110144-1472738166=:129229"
X-Provags-ID: V03:K0:n2P7tSSJX8RWChL6Yk5sZHrJS6Gvtz5xqgISwy9uJqkaaHPsZSk
 jz/d2bVN/JKrQQAVes7B8G524vPQ2X8md7CLzEtDMbIKczkKCkyjPMYnppeEWONIl8tN0Fa
 t7MuUS80SlH9P8HUAuALu4PZpe7XTrL8u6GxZQA9/7e+GeArfti3n6deJ8OylLjvhlNbV0M
 33zz71MpPm4NxVLmbumXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cMdjc7+uyZo=:Aj3mq2hNn3vZQ2rApFTUFP
 I9pAYO/Q+E+SvTq//HhbcIzj2pOxkb6RjHma0ggZWfZuL7LTUzSvFZkb0cJvdqppqgqN9/ElT
 Qf+3jW1I6GeWDQfnJNEIAamcsflefkOWaB9kUdofYH0CuG1vZ9x1DTtp4z0DwyqgD6rAORBJJ
 AgZ5+X4QrDCwkn0qhjReICLOkU3xEbYFLUp4PcoOhAef2/q1fc6UOVvsat9/YdZdS5Or+7BeY
 PL8fmPIzDQaF5xP9lugELD86WmeLtidqZYJhDTueN+aeMlbgAYQnOUTRctTQnNUZUKsWXPNHY
 UQAz4LKxQtHDkrWdK75dkVToYdTIKWKzcySPR4Mva74AsRD8Ux3pG2h3+FUqVY7T0B+J/4j/3
 6KgM3o3d07PvYSR7aS8LbmzQiMcRhSb7SjeArBj8IqSnp0H4QAbK6bHHnWdlXwp4mJQ7yj5Cz
 2Y8buEYvRynpER4yI29XMELEEtjbq4OwbF2I2NsvI05IOwEJWtYG+p2yIzV3v6lW3wJq8/mmE
 V71zNE9/yqvFSIrO17NVtGlj6FOZX5OLl6FQs1mQSWhX1v/2b31ZiKQ/qUd3owqcihQNGYis2
 BxRMx1pEg5BDn1QpHmOpc/ghLIeWOKeqDBNTAhPgB+PG9GDQ8Tuc/ygCTl8S/a7inH3y4K9Tk
 nprhbMgyGcKBvq7/Uta0hopRv+vczJSWpeckML1X21PKV8AgCLZepG9wXolBBih4jCzVKPhVo
 4WUfgOUKYYoJ4nGYqWK5gY4nv0P/5ajeMtMc8PpvrcwbhHRCXDzSmoC8o9oPRoN39Vh9HwedG
 CsKOAQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-352110144-1472738166=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Thu, 1 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 29.08.2016 o 10:06, Johannes Schindelin pisze:
>=20
> > @@ -781,7 +785,7 @@ static int do_pick_commit(enum todo_command command=
, struct commit *commit,
> >  =09}
> >  =09if (!opts->no_commit)
> >  =09=09res =3D sequencer_commit(opts->edit ? NULL : git_path_merge_msg(=
),
> > -=09=09=09opts, allow, opts->edit, 0);
> > +=09=09=09opts, allow, opts->edit, 0, 0);
>=20
> The calling convention begins to look unwieldy, but we have only
> a single such callsite, and there are quite a bit callsites in
> Git code that have similar API ("git grep ', 0, 0' -- '*.c'").
> So we don't need to think about alternatives.  Yet.

Right.

Please note that it will make much more sense in the end, too, as the 0s
will be replaced by appropriate variables.

> It's a pity that emulation of named parameters in C requires
> relying on designated inits from C99
>=20
>   typedef struct {
>     double pressure, moles, temp;
>   } ideal_struct;
>=20
>   #define ideal_pressure(...) ideal_pressure_base((ideal_struct){.pressur=
e=3D1,   \
>                                         .moles=3D1, .temp=3D273.15, __VA_=
ARGS__})
>=20
>   double ideal_pressure_base(ideal_struct in)
>   {
>     return 8.314 * in.moles*in.temp/in.pressure;
>   }
>=20
>   ... ideal_pressure(.moles=3D2, .temp=3D373.15) ...

Yeah, that looks unwieldy ;-)

Thanks for the review,
Dscho
--8323329-352110144-1472738166=:129229--
