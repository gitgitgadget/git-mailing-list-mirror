Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E79F1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbcIAPcM (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 11:32:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:50197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933537AbcIAPcK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 11:32:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Me5Q2-1bRgB31TrS-00Pxwj; Thu, 01 Sep 2016 17:32:03
 +0200
Date:   Thu, 1 Sep 2016 17:32:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 27/34] sequencer (rebase -i): differentiate between
 comments and 'noop'
In-Reply-To: <1472718815.4680.21.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609011720160.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de> <1472718815.4680.21.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-873619320-1472743923=:129229"
X-Provags-ID: V03:K0:sLukSkf5/ripZOmX1eeTZF3UfSBPPy82FEEjIbK5LZdtSgrt0n0
 MQryQYbT0jk8CcJ/PXyAQazrAGFEPNAox5DynEum/l6DdRS4W+R/VZ/OVR2nrYt67RbJLos
 picrsTmfm2X6JbemWm1pC3d+2rKSWcbMkZ22TcWKUquvsStY2GZv8Q0L2dsvYIaMHE6BY2N
 Wq/hZqrY2VyYbP9+Llybg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/BGjQ2CeTrY=:y5nzOMI+zhsXhl4Vlm7oDB
 TqMlIGZEssv6s0ESkh+G6ApnZ/3kmmD/7AQmlf+YID2KodVw20KK4Gak9tYXe9JkcHFurZqtx
 StzMQZWVntOlqhwqs3SE8rTmEf3VpiNqXJtgVuFiS/ucwpgXOXq6YWBlplSQyfaYiRq1rQqkl
 Kplvlgig6vVRzyZDr0l6iauxr6ZGANvO/h/nrCuC1ycxEDt531qQzi64IHf8/vvVAoJfTFM7D
 eTlxUkIhTDMMOF4Nt6XvrzPG+73b1Jy7eAi+FTslSM7Q5VlFZB/62UmjTT77aNov3dnifY97r
 rnnXiC6vZAyo4W6446/LG0zX+3y4Mtut03YH6wr6Ob5AlQ4Odz6D55HpFraibRibzDz+iuCB4
 XbrP+3eeTgYEmLOCrGhcrpYsTpBLQStS6SegehY0g7YNwbbGBKuzGMzFwI9hjcFMHhM58Dblq
 3ta2e4+p7ZyRdoAmM0+rdlalEZDlp/0xcwuJ4Q2qKFMyl9Omh6iK0r4tuphp6i4A5aAiOBSD5
 Pg4HSTnBfYe9bHD1tvTwvPocFcuEesx9fyYWaiURq5vk8IjNgLFoTdlqH2gt+gEvzooJNcKSK
 dsojLl36Q0B9mW/vECoCQUvYnqneQAXkyiPOvf2TN2NcbcooaRkTCFmyBdEPsZ9zHrQzMBezr
 Eeb3bILk52aDPI98lYFco1nc4T51Bj5aUFeGUBXUU9o6Nv0VyNOPexXIb92BcZaxZTUBjNUQz
 m4e9x1uqXLN7TJTynLAsOiCbiciCyGnBjm8IIgEBoUWisXa1+lVxbznBWJND4oIOks/mRMi/J
 6j+BuGM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-873619320-1472743923=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:56 +0200, Johannes Schindelin wrote:
> > diff --git a/sequencer.c b/sequencer.c
> > index 51c2f76..4c902e5 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -763,7 +763,8 @@ enum todo_command {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TODO_SQUASH,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TODO_EXEC,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TODO_NOOP,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TODO_DROP
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TODO_DROP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TODO_COMMENT
> > =C2=A0};
>=20
> (picking a random commit that touches this enum)
>=20
> In a few places you now make comparisons like "< TODO_NOOP", so I think
> it would be good to have a comment near the definition of this enum
> that says that ordering matters and why, so people don't attempt to add
> a new TODO_FOOBAR at the end.

True.

It does not seem that we have a precedent for that. The closest is what I
had in an early iteration of the fsck message IDs, and subsequently things
were refactored so that it is not the order, but a flag, that determines
what the command does.

Not sure how to do this elegantly. Maybe like this?

=09enum todo_command {
=09=09TODO_PICK_COMMANDS =3D 0,
=09=09TODO_PICK =3D TODO_PICK_COMMANDS,
=09=09TODO_SQUASH,

=09=09TODO_NON_PICK_COMMANDS,
=09=09TODO_EXEC =3D TODO_NON_PICK_COMMANDS,

=09=09TODO_NOOP_COMMANDS,
=09=09TODO_NOOP =3D TODO_NOOP_COMMANDS,
=09=09TODO_DROP
=09=09TODO_DROP,

=09=09TODO_LAST_COMMAND,
=09=09TODO_COMMENT =3D TODO_LAST_COMMAND
=09};

But that is so god-awful to read.

Still unsure,
Dscho
--8323329-873619320-1472743923=:129229--
