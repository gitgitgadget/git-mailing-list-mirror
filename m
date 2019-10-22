Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758F21F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbfJVXd4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:33:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:47535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729635AbfJVXd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571787231;
        bh=ifrFOQ+JYtFy7PuyqvsjoqZlTa8ABPWjw705qn+avps=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BRI517flFfGGRqNKKFvfxvdvD1S23aSwxOYB8KgLN/gFNUPJ4pQZAbOhhtQRCrXV8
         cnj7M0dt90wiXK2SM1Es6PegMgEQfF6dsHrPv3sDi+kg438pBL6S2NXbfs3uwEMbFq
         7iVneDiZnyzNCyjTJDnX67nVhF1SHlt4dcz1KfLw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1hclYV1S9I-00kPy7; Wed, 23
 Oct 2019 01:33:51 +0200
Date:   Wed, 23 Oct 2019 01:33:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
In-Reply-To: <20191021185352.GA69085@generichostname>
Message-ID: <nycvar.QRO.7.76.6.1910230132260.46@tvgsbejvaqbjf.bet>
References: <cover.1571246693.git.liu.denton@gmail.com> <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com> <xmqqimon6yar.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
 <20191021185352.GA69085@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9Uj0Kmf8j6CcgLOrNUEUBVe1Ftb0eOu19tjNcGq7GSRtcuAzzmR
 aMtpV8ujm7wkUxd7rDyk+dQPXhZHjmA7gyIzblrgVUktximfisV36Q1J/jxd5sGQepiKn5R
 VpkUPYB/O5ooFs4LVP42/oeaWrPfeMVUpAF01ng3kWsLZeXbjSeaSAr1Z/WBITevCIVv4mX
 BbMYZH1kBi57k+rQCx+cA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qUu/gn/PI/I=:irPBlKn7JpbVJJzvWB3aKE
 zvEJf9Do1DfD37MdizSEfxCx8H6Dh9U3/tCRxY/J+ROmnYFrOYPWBqgrghW3MAA5UWjkEldxw
 sWwwc+FIAe/zcpuhVn7bw7CONzFdrlaXrkNn/TT/hplUVp672C/1LFpaJl92vEGWc8WAVcXpH
 525y+KlirKB4aQnAPnF5ZvrtePWjpmzv6M9D+thc5RWlYYNRySGJwQ8huA3vvCx85mJ7NLXEb
 VYJhFqpsiN0WkR8tREXWpepncGqXwL+cawXcFHgic0oPw4/XqaPcmni86nFCa4tEUsuTBUGN7
 zzTgthCknlF/j4RsS59F++TNulCwocj+naI7E1poMDdhEb31YeK3YSz8ZX1O338mnsdrMnfTy
 RU/tvsh2Oj0N8/JOZyLPbGVSesQ62eb1iNl1uF8tjhjzmT2nbzCJODHINxdhMjsDUlBjn0wCq
 gbhsfJQWSJZQJbM2cxFjKPHSeSYGjiMvxDz1pAbvlazEsdzm1fJKAHUvu0WHb99gzDYFdA6LJ
 RSk5nRG2qnvVrOm+5P8qvNEHcpr6OPSXHVDic5bE9jEui3+DW0bHfhKvr3xWidKz5D9Oc9KoC
 3VIQyjLJtcGoBiw3qRUucsZPD6Y6J2o/utMMCeSQst3E2mi2dCSprrbeTaP8vQOaYXp85duYc
 IiFKIVHy3UQE6FLX5xJMQISsPImuk0cINQg9KcivDf0zMLelGNu5Rclt7nDoN07332libQK8J
 XpBpHCNYb8+XYV45kven25buGhowAo4HdS1N8xTBNmYFwFd38e/NBiiPiYFwn3sJZHdLJWihg
 kzoKbxpM+Z9jItMsSqSrAaam5YdhcSMlBht/4gvPFtTQUzOuqIdbAsBpGQQA9imK1FPPsk914
 v02wCbJW6y2bZDjCBs8+mcVIfbG16RoM4iG3IKyeFsC6HqEXkHn9rbWYq4OAMgbCqLe99wrdn
 PP2jbJ4H80zL09s2hlYCvaH5s9Yc3gcJaP7S6kEfwRBm87RbrRCmkFZH8jeWDodidqeHbQ7YC
 K0HxEdhiXHDVkRcEmd2lMnsS7SUDWmihKITffOiptykLJmDgBaEUHwAaP0/w1zVAPHpnKAdLn
 A8fjOcwgo2Y1NWr/4VCeSw15krLAkbXYadhx5tFo1rTgGD0v82UX/PdlXZAwWRz/C5NlouEkN
 N9+hWMmfdyWz+alSu4erbMNDkMc3ZKSX6tNPSfgWfVPIVe/XalNGK7W3hh6Y4UfdBB7a8tq9p
 6a0+E1Vff0RKzoqX7bIvnxKumaYvCzM8BelXcqHJyxBisEfXsN35Zz5IOhK0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 21 Oct 2019, Denton Liu wrote:

> Hi Johannes,
>
> On Mon, Oct 21, 2019 at 08:44:40PM +0200, Johannes Schindelin wrote:
> > Hi Junio,
> >
> > On Fri, 18 Oct 2019, Junio C Hamano wrote:
> >
> > > Denton Liu <liu.denton@gmail.com> writes:
> > >
> > > > There are many +=3D lists in the Makefile and, over time, they hav=
e gotten
> > > > slightly out of order, alphabetically. Alphabetically sort all +=
=3D lists
> > > > to bring them back in order.
> > > > ...
> > >
> > > Hmm.  I like the general thrust, but ...
> > >
> > > >  LIB_OBJS +=3D combine-diff.o
> > > > -LIB_OBJS +=3D commit.o
> > > >  LIB_OBJS +=3D commit-graph.o
> > > >  LIB_OBJS +=3D commit-reach.o
> > > > +LIB_OBJS +=3D commit.o
> > >
> > > ... I do not particularly see this change (there may be similar
> > > ones) desirable.  I'd find it it be much more natural to sort
> > > "commit-anything" after "commit", and that is true with or without
> > > the common extension ".o" added to these entries.
> > >
> > > In short, flipping these entries because '.' sorts later than '-' is
> > > making the result look "less sorted", at least to me.
> >
> > The problem with this argument is that it disagrees with ASCII, as `-`
> > has code 0x2d while `.` has code 0x2e, i.e. it is lexicographically
> > _larger_.
> >
> > So Denton's patch does the correct thing.
>
> I actually agree with Junio on this one. Without the prefixes, "commit"
> would go before "commit-graph" so I think it would make more sense to
> order with the prefixes removed instead of taking the naive ordering by
> just sorting each block.

That will make it harder on other contributors like me, who prefer to
mark the lines in `vim` and then call `:sort` on them, and then not care
about it any further.

Any decision that makes automating tedious tasks harder puts more burden
on human beings. I don't like that.

Ciao,
Dscho

>
> Thanks,
>
> Denton
>
> >
> > Ciao,
> > Dscho
>
