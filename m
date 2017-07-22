Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A851F600
	for <e@80x24.org>; Sat, 22 Jul 2017 11:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755214AbdGVLWE (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 07:22:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:50391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755152AbdGVLWD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 07:22:03 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mbfyr-1dIAPD4ATt-00J1rM; Sat, 22
 Jul 2017 13:21:43 +0200
Date:   Sat, 22 Jul 2017 13:21:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
In-Reply-To: <xmqq7ez1j0wv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707221320350.4271@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com> <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com> <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com> <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com> <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr> <xmqq7ez1j0wv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1001894787-1500722503=:4271"
X-Provags-ID: V03:K0:uaE8K/hxXYCWrZxXH5yct+7zl6jb3wfAbI56SWxS8eXrazh9rel
 fLvfk4KAlbfByGxgnq83SqAGwWX5PQn/9OqB5NW3fBDputw7Y5qRYizIXqXZnsb/5zSH1Q+
 OphtPaucs4QDdQR74+rL3Nvib6t31RMQcp3db8YRuQX09RLn+LKN6ddbH057U/Suyp6ZkLJ
 3Mer2jlVY/id5UJ6MGN/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bcroTNb881Q=:fUXP/PNUNeysb5Lb1eJenz
 SpHa2aivoKKGJGmJGVUklJ4hLPBEF+E7M/sOjGsQ1psNni2exWnVdii5eoR3xTGdaME1g40fT
 M3OOt46QLOKt3Nfo3BvG0ANkBDvIsAxHRhkCNzqtxQNaxI2goyOK8h2wMeiD6zDUI6c49DKXf
 zn94iB8CKN8Kht/AP+Hkxu1941iSpYg1uuUDf9lBvY7p+f3NlL25Nib5mvgtNwTuUBXeXAK+O
 6nDjq5y/7chm2B1kcJRESZtaCa9rRNlHVKIDzK4TJqpxQXRwYOabjPAVJDgsj3ze0sCcZbF8T
 PQTdW9qsEGH4iTojplBD+Lto9GT0n9amww9RaCXcbjGs7ekATqpAoe/3Q565gcUolTKVioh+0
 q0gLfnbV9ArWUoXsqQsCZRIDbgyr/bs9uy4lvIzpADmwjLxpW4hZWkv2rHtErBSEpynUYNClM
 VUTv7vzHtJo2gDmE00C+CLPX/Ho188toT1C0D0nAbUqjLKbiO+A0tYiHPrY8T6Y/owxOuw6EY
 UPAtgbzCdacs9lUN8xk7twAU5pgSnqbOoxIOBwFUrGOZPT6X1cmGqQhjkqsSP8ujPxvhzOLJ4
 o1lJI622xirjT4zBT9ht0yhBPR5hzzNxgwa9z5CvreH3zTjlc03nx7AhsX3F66woh9Jpwi8yy
 c7Ni9qp/tkhYlCR0YmCjftpYNA+MWZG6IbQ9II9jvJSAMtRLjPqbdwsCaB5BET4IDIzrH2YRM
 voi56630XgfVP8MZQmYNOafAFCPPwgdmlzjmWDhxBqBHI3y5dJ0bxL3SVAQzH+476efavU35n
 2e89OGDKBCAieDDItD+m43F2KEKqbefVJkDetZTpxZomyI479s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1001894787-1500722503=:4271
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 21 Jul 2017, Junio C Hamano wrote:

> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
>=20
> > Le 20/07/2017 =C3=A0 20:57, Junio C Hamano a =C3=A9crit :
> >>
> >> +=09git diff --quiet HEAD && git diff --quiet --cached
> >> +
> >> +=09@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
> >
> > Does PRIuMAX make sense for perl and sh files?
>=20
> Not really; I did this primarily because I would prefer to keep
> things consistent, anticipating there may be some other things we
> need to replace before running gettext(1) for other reasons later.

It would add unnecessary churn, too, to add those specific exclusions and
make things inconsistent: the use of PRItime in Perl or shell scripts
would already make those scripts barf. And if it is unnecessary churn...
let's not do it?

Ciao,
Dscho
--8323329-1001894787-1500722503=:4271--
