Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E941F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDHXR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:23:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:57757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeEDHXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:23:17 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjvV7-1edVY91O4v-00bqes; Fri, 04
 May 2018 09:23:12 +0200
Date:   Fri, 4 May 2018 09:23:10 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805040919400.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com> <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet> <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TrIaB65vqbx9Jr4D+uVbCwIRcjnyl5pcw6mS4hUHQvar+BnKMQb
 6ZxBAzRG+5l8n81FFkudBU6MWHcGtM4I8+NkXe//QdJekwG6dxJIBOmztDwkbiMvLFhY+Zf
 179wmlu8BiAYJjnbJRZ/Rw2xL1b1zJnwB2+PLbnG/kUE6PCtDojTD4gRNF59td8ia7/QKar
 TSFkpB7jJBT9Pxoh3n+kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cwfx1c1GgC8=:EwvKamKL2ajN6SWkUThjuR
 7ykiD4YEyYbDrV2OZ+pBU38ee4PNyU3+4Kxyr8FnQbdjM4V9/DYFOSaP7kM5hxzprWfYqirMp
 0OiOLOPJp2LGOY994Uz/vJfNshyrH8qZ55vhqnoJYP/SMSR0x613JIE1CkW28QpgfqRj8huR5
 dkg/J25XsS9qqLvblhAiUH53FSrkIHc1pC20BWMFDoxBUqVDQ4Q2VytaqF852w1UVPJmaxhwd
 XOtr5O7WV2Ryifmtd/LfCoj/slxCXUHh+B6QoiHPDvmX5GlbarVbdTp8YrrTdtR6BUX2Nto0+
 Fq8I7RdbntmEp4UspFIKWoEBLzLKH64PndCiShxhB0fv7Cdf2QqY+4YEDiPrxs99BhkxOwj4F
 Qf+xv1q7JN1rbvRlGoKIX0IlMuob8rvT+9H3/k1CWO//lI0YRAEwOOMEjHKBq8BTX5BoaLxUW
 +2w+T2I1ZQ4E1sFs88A9dI7PkLXk//eSQlOj8db13IdnUxjG4w3cLdJEssqsjRT/qIk71uSg7
 111VIARuKjQQ6cApXPIl3ZJlhvt3RwkujJ5nY33VAcQUaGxjNOS3i56T9hY5vQ0Cof7uyi1bp
 zqAaEaTxYkIKfkkOrFL8JpmDsAgoGV6LzexphWPnlSkpJuI7v6mshPraxe3/+E6McKPV+8fdS
 d4FXFohCPWM9Ge5QjGPs6Uth9tq/pWf6nI5L+4gxq+ua8ZwND7M7elEyq4MK2ZGpsDcUuv+hh
 IDlqUdPbbPMMBTAITn3R3JC5wV0pGrBcUgv/DkNG2C+COrymSDiPfOTkcbjRNcrBLz2hm5CbH
 iIGs6E2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 4 May 2018, Duy Nguyen wrote:

> On Thu, May 3, 2018 at 10:32 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 3 May 2018, Johannes Schindelin wrote:
> >
> >> On Thu, 3 May 2018, Duy Nguyen wrote:
> >>
> >> > On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
> >> > <johannes.schindelin@gmx.de> wrote:
> >> > > diff --git a/command-list.txt b/command-list.txt
> >> > > index a1fad28fd82..c89ac8f417f 100644
> >> > > --- a/command-list.txt
> >> > > +++ b/command-list.txt
> >> > > @@ -19,6 +19,7 @@ git-archive                             mainporcelain
> >> > >  git-bisect                              mainporcelain           info
> >> > >  git-blame                               ancillaryinterrogators
> >> > >  git-branch                              mainporcelain           history
> >> > > +git-branch-diff                         mainporcelain           info
> >> >
> >> > Making it part of "git help" with the info keywords at this stage may
> >> > be premature. "git help" is about _common_ commands and we don't know
> >> > (yet) how popular this will be.
> >>
> >> Makes sense. I removed the `mainporcelain` keyword locally.
> >
> > On second thought, I *think* you meant to imply that I should remove that
> > line altogether. Will do that now.
> 
> Actually I only suggested to remove the last word "info". That was
> what made this command "common". Classifying all commands in this file
> is definitely a good thing, and I think mainporcelain is the right
> choice.

Oh, okay. It was not at all clear to me what the exact format and role of
these lines are... So that's what `info` does: it influences whether/where
the command is listed in `git help`'s output... Interesting. I thought the
lines here were trying to automate parts of the tab completion or
something.

I re-added the line, this time without `info` and verified that
`branch-diff` does not show up in `git help`'s output.

Ciao,
Dscho
