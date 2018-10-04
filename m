Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036161F453
	for <e@80x24.org>; Thu,  4 Oct 2018 19:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeJEChB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 22:37:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:45511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbeJEChB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 22:37:01 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfBX6-1fO4GF3bLc-00opkm; Thu, 04
 Oct 2018 21:42:15 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfBX6-1fO4GF3bLc-00opkm; Thu, 04
 Oct 2018 21:42:15 +0200
Date:   Thu, 4 Oct 2018 21:42:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ananya Krishna Maram <ananyakittu1997@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
In-Reply-To: <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810042136430.73@tvgsbejvaqbjf.bet>
References: <20181004113015.GA30901@manohar-ssh> <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet> <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com> <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
 <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qMLcqkdQ+0DMfUDLEk+Gd0BP5x8jlXg/XNyTG/DX8RzhuUuWp3y
 tYus8zbmkPNl/m/fm6R07QYBMVeCYfLlNW2dqR3qY0njkMGSHM5dmRZ6pgiOcSiFUXJ7d0D
 69DhLsiq0nAGDVn5JNjWjaIXDMmV3hqstWzdUocrDtKeBR1xpO/mWSo9avCrysqb4MbydP0
 JtdNSBaK+RCSGTBQyoHgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/oYsS9z9mtU=:P/zS+WT3BGPLVU4uE6OeXu
 75Zlq/5wB0Vg1vbCHj3MvmlhJVGBPQmhJpAfH6uEbLm1zrM/qGYSxug7xVWtIxXXsB4qobhoy
 a8KbxSVWlMMhoA/pIzvENjeqVGPZqZg2ARGmqcPJrxOTkKryllRylZ5BYpf/DGfa3vnVGwPs4
 h9dKrjhqHu5GDx53K9/Jh18Tzwo9ggsp3QaURp4F0vJe7MtqwBNHEbUPnc6A4iNhoRDQ2+qqi
 Wyp4lxneqc3cZZgjIi4foUhsP4tWpZHx/UB3uJN0f0Ikv5N2x4BVXmIInPTWqc7U8aNRge56Q
 4GPiD2s4akmvwdw8J/TcgcZsMHfMsXrlZbE1U/Cz3zGQqJ+j9BWMM6unD/K8Unk2afMeXbCRT
 Vse/HNcvGlgJJEMgzxllg90zynwLdajPOfqFo0Y/MItPm7MjKuhGQFDiEJqjzIVizEKlBkRj2
 /Gnksv4B1EO117jy4m/fXO553gcpETYdXxA2Sh7JkCF9SZyDDprUq6MCGpwaJVdM4jOnVjXS+
 tEPjcmnVrt7IPysS7XKW8f+Tek6HoLjXkHKwYhBgnim7iZDP9ZsfeSFS/1NhBlOs1b43dnIk3
 L4kRDVeKDsRHJM5MquzhRC3dj/d4s6RvA7IODrIy0yUyNoxryJET1nX+UNqG+LPtB8uabr/eX
 ORWmeVGovHED6RIBIKKiDPWeqePZZtztlUu/tSy5ChOCjsQ+0TkW6R1e0u7TVTh81O9+Thg7P
 S93ZUsjiUjG0ZuOHWymvGQHaCbbabjeuoAd7EV+op+J+ZgBAijMdZNnKvU0yGuIqlrrWlcufX
 fl0sd56q2wte/IZfW85Vb3EpntzhTcv0AH/GhcChG0Wmko/1A8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ananya,

On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:

> On Thu, 4 Oct 2018 at 20:56, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > [... talking about the reason why a slash does not need to be escaped
> > in a C string specifying a regular expression...]
> >
> > But it does not need to be escaped, when you specify the regular
> > expression the way we do. And the way we specified it is really the
> > standard when specifying regular expressions in C code, i.e. *without* the
> > suggested backslash.
> 
> Aha!. this makes total sense. I was thinking from a general regular expression
> point of view. But I should be thinking from C point of view and how C
> might interpret this newly submitted string.
> This explanation is very clear. Thanks for taking time to reply to my
> patch. From next time on, I will try to think from
> git project's point of view.

Of course! Thank you for taking the time to contribute this patch.

Maybe you have another idea for a micro-project? Maybe there is something
in Git that you wish was more convenient? Or maybe
https://public-inbox.org/git/?q=leftoverbits has something that you would
like to implement?

Ciao,
Johannes

> 
> Thanks,
> Ananya.
> 
> > Ciao,
> > Johannes
> >
> > >
> > > Thanks,
> > > Ananya.
> > >
> > > > Thanks,
> > > > Johannes
> > > >
> > > > > ---
> > > > >  userdiff.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/userdiff.c b/userdiff.c
> > > > > index f565f6731..f4ff9b9e5 100644
> > > > > --- a/userdiff.c
> > > > > +++ b/userdiff.c
> > > > > @@ -123,7 +123,7 @@ PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
> > > > >        /* -- */
> > > > >        "[a-zA-Z_][a-zA-Z0-9_]*"
> > > > >        "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
> > > > > -      "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
> > > > > +      "|[-+*\/<>%&^|=!]=|\/\/=?|<<=?|>>=?|\\*\\*=?"),
> > > > >        /* -- */
> > > > >  PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> > > > >        /* -- */
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > >
> > >
> 
