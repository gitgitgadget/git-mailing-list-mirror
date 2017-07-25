Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C752047F
	for <e@80x24.org>; Tue, 25 Jul 2017 10:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbdGYK0A (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 06:26:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:51012 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbdGYK0A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 06:26:00 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTm8-1eANBf2S8y-00ceY7; Tue, 25
 Jul 2017 12:25:55 +0200
Date:   Tue, 25 Jul 2017 12:25:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
In-Reply-To: <CANYiYbHMMJ1tubajHNZVsQ=ihmogtF4=FqrRWvPJg4+wuBapbg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1707251222550.4271@virtualbox>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com> <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com> <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com> <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com> <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com> <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com> <alpine.DEB.2.21.1.1707221323420.4271@virtualbox> <CANYiYbHMMJ1tubajHNZVsQ=ihmogtF4=FqrRWvPJg4+wuBapbg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mZ+tCb1PNNjKv2K/E6kKpkWafo3TESvOcYakQEuqhy5FAiIFH2y
 CnpOqlPCKydmCbOcp6n0J7G46MODogJ1lDMwWWzGXVd8keDrfYB5Mbh1u7eloJJfl1bsMdn
 H8RdjTQqOQYgDVPbcUN0+LnEqGfA5AwB4HLUg+npAzAn/+YzCzzlwj+RN+joBnh2pOTbxCr
 m/IzM3uwUM5uCKlSBfYRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2CE7Y52doH0=:065o8h2733/1/ebE40fpuz
 PzRNjsCld6ZRa9iJGuYPvHSa8U++eXtuM4DO8M+FV+cbTM4fZLrVY29a030ABeBzVB63fUlG4
 lkwIAq69vfz9hqLLRAtPcWuJApbuUR6ykDHzZXxC1aLwhgpFQuy7t+olcNoyhmFO5qNS7cOgB
 AD7d38bUmm0XsXekT40QRDDqaK25uwbjm4HgnsN07QuoBxAuJ+QxjBxnralvsBuVRVVgjtoAv
 ClW8mXKLexaN9caMASDAKYcO2/+o2r2qacKfxLSF4AaQolbLiR5S64g5m4t/lbC3/ZXNQCCtY
 myxH1MGvD5CWxEDsq6Msy5zq56t4C++/y37QGWqIrNzm+02J8/uvKwy2MhnSbFIXGttVJ1j1j
 PvkNWsJ9JigzRtQuBWgJFOgV0dizEyXs/eoqPR6mKpuOvWLa36xNhy+NINCx84IMZ8mdWxAFt
 hNe5fUFa7abv3PGKPCYU6LRayrfR+alY9Q7LldI5Qz95+j1hhFtRdCpskpAwjez7k4yf0ihRV
 ahIxvfDiqsPbpgyh2r62lRsBzfL6oMB2d2yaU6UvcGFl2hyUhhm1t8RJiQe9IHWznpcUdOXe5
 dvWohpO9UDsTHx1YzRHrRIS98Glwe5Z5gUro5QGtNO5uEHbgBLMf+j104p0DRaFVFW0IMm2Qq
 +kL522P/9etjP6S6+hArj+Ia+/7l534xYp5g6RvLcfmTeC9s5Cnq3WtrimXcWY2h6QKTR6xLL
 kQIZ+OUC5/4hW3HhoG7ZFrXnfX+BzlqJxVqbj/OH0iKpE2uAvnHmESwE7r9PhVKZS1tTGy2Xw
 pt+XqhrXajQmiIATcgzFXaiGUHJ0NmFlyyfVdVTQzT1F0aIx+E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 24 Jul 2017, Jiang Xin wrote:

> 2017-07-22 19:28 GMT+08:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >
> > On Sat, 22 Jul 2017, Jiang Xin wrote:
> >
> >> 2017-07-22 7:34 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> >> > Jiang Xin <worldhello.net@gmail.com> writes:
> >> >
> >> >> A very small hack on gettext.
> >
> > I am 100% opposed to this hack.
> 
> It's really very small, see:
> 
> *  https://github.com/jiangxin/gettext/commit/b0a72643

I don't care about size. Insecure, pampered white men may be concerned
about size; not I.

I am concerned about an *unnecessary* deviation from a well-established
and well-maintained piece of software that would all of a sudden be
version-coupled with Git.

> > If at all, we need to make things easier instead of harder.
> 
> If it is only the l10n coordinate's duty to generate po/git.pot, the
> tweak is OK.

No. You want to keep the bus number high.

> I agree.  We just go with the sed-then-cleanup version until we meet
> ambiguities (I mean some words other than PRItime need to be
> replaced).

Even then. Even then you should want to avoid version-coupling Git
versions with gettext versions. Because that's precisely what you would
do, as gettext would now have to know about *this* Git version's
interpretation of certain data type names.

Ciao,
Dscho
