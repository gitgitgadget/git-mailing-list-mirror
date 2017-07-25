Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B963E2047F
	for <e@80x24.org>; Tue, 25 Jul 2017 10:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbdGYKUy (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 06:20:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:55020 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbdGYKUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 06:20:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0xbD-1ds1RX0ibf-00v9z3; Tue, 25
 Jul 2017 12:20:48 +0200
Date:   Tue, 25 Jul 2017 12:20:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
In-Reply-To: <xmqqa83wfoxj.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707251219480.4271@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com> <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com> <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com> <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com> <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr> <xmqq7ez1j0wv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1707221320350.4271@virtualbox> <xmqqa83wfoxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-728625987-1500978048=:4271"
X-Provags-ID: V03:K0:q51tt5LD18nADmMQ1+PqyZ9jnlOAEZHbObPU1YPcBf8EWdOmWv9
 fjagIpT4XQj2HE2jWUMAocgRLfuRaWWaYUo68tFTzlpveiRKq/TDvXx/eYoujU2uVcCuNdY
 kAGZ4iBy3VUKqmqZuOaelAWZKO6Q58wvTayYh+dI6RvZbB9ITmLoNi4r99L8l9cnto05BSp
 5JKeB1UXZSBbh/kOMTpxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:92HWYBKI1rM=:qN9wMUKJa1doXjHKOkOhzg
 AXpQcMfwrTZtg8Hi6X/rBv/5Wia9ytOBwEVHfFhwSMNglX6b2x8wK8R/Q8IrPqcLKArtmsAcA
 LYkYzqy3qWyF+FDnsDTSkHnf5MasrEcQnGoroaTTgpjCqN8orJA7Hy/A/wRiVwANkz2hG2LJe
 mwoU6pJhIRIXgFaVuNPyriEAmIdsO9qK/BwUn5NYbQ5jlt1T0o7zZF+3VzS4NnsnZjiBYh/C1
 t9zHDOOj5PX/SUByf1JffK+MhPRgx4TnZ6sMurV8tRTJOmtHx81q/u51SkSob2mmHHWHxM+Lu
 3YqiiQOfbc2CxzBWoel7t5gJOzaRC9JhZrdQLUoz7ytbHb2XQi3SC0L+r5JzWm73vdB0cLuuK
 HqSDq6YHiwqIdEwe++xzcAPttEw3qgDa7bcqFSs4qbq9x1VifG0cz1pGmXhVKWI9FAK13goEM
 YZ3IkvCms9q2UlF3d4AaoYMp6cJWJf/92aL9XQr9fxglTvaq5Zbcq5oyVT50vqD8mq9DcCvVg
 i9yoceOXpxF9n/7G/1/Nmvf0Lp3ofrBgsIvMwkp0Abu1dCyOMx9akNmt4cTQRNL+vjaJagUEQ
 4NrEMjkRu06pVhebHNeEILQm756cmRPggZDO1x/LdefINIvsV+L/tVAne4fSBQ+6hWKEn3NfX
 /5hU+Th6rB+xdt077/R7VOC9wbhDQJzO20TRW7gGPOTsTh3sPTJEBMST/F1NlzuTiQiI81THM
 aYMI4KLE/nHx1mZgU7+nvl29W2jwFjp1VgVX6DCjMIgw6TlcSr8GLk5U7P2FCXtAS2GX+UNa2
 /BOU/jTwqsxZOSQ8sqL0amj7GgO/lPHX6luP7NQNJW2JrnqTqA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-728625987-1500978048=:4271
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Sat, 22 Jul 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Fri, 21 Jul 2017, Junio C Hamano wrote:
> >
> >> Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> >>=20
> >> > Le 20/07/2017 =C3=A0 20:57, Junio C Hamano a =C3=A9crit :
> >> >>
> >> >> +=09git diff --quiet HEAD && git diff --quiet --cached
> >> >> +
> >> >> +=09@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
> >> >
> >> > Does PRIuMAX make sense for perl and sh files?
> >>=20
> >> Not really; I did this primarily because I would prefer to keep
> >> things consistent, anticipating there may be some other things we
> >> need to replace before running gettext(1) for other reasons later.
> >
> > It would add unnecessary churn, too, to add those specific exclusions a=
nd
> > make things inconsistent: the use of PRItime in Perl or shell scripts
> > would already make those scripts barf. And if it is unnecessary churn..=
=2E
> > let's not do it?
>=20
> Sorry, but I cannot quite tell if you are in favor of limiting the
> set of source files that go through the sed substitution (because we
> know PRIuMAX is just as nonsensical as PRItime in perl and shell
> source), or if you are in favor of keeping the patch as-is (because
> changing the set of source files is a churn and substitutions would
> not hurt)?

I was in favor of keeping the simplest strategy: simply cover all files,
including Perl and Unix shell scripts. It would not bring any benefit to
exclude them.

Ciao,
Dscho
--8323329-728625987-1500978048=:4271--
