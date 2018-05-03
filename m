Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2694A200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeECUag (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:30:36 -0400
Received: from mout.gmx.net ([212.227.17.21]:52545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbeECUaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:30:35 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgYGJ-1f1KZ036gh-00NxBJ; Thu, 03
 May 2018 22:30:29 +0200
Date:   Thu, 3 May 2018 22:30:23 +0200 (DST)
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
In-Reply-To: <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fRNEDWBSEiek7ujKmQRNmccDZmtclziOSsibsjfSONp9aOLBehw
 PpiEzL//7f4oOPJcAE4bDheBqWt51PFk17tWOr040lUi3ruYbVBGoErVollohmahzOE19R9
 Yywb4CWUSLXTYjk8G/bPPfEwq4ivYcI1nf4Wl4VOW4Luh3eG2hBLH585hmUajhbGZDM449P
 Mcc2uzj5UoHfWqmwAHpUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GNntnWeglUs=:J9rDOf92DEPz7nB8vgmMPp
 jNbEYoCURi+OtzpYKyNv9a2FQumpJkHwVi+LT2u/kPisyxFHueSs5C0q/xEKOAgLx2E/+lh6h
 HX6sICRMfukX3LExku1/znFM1pwJ0PCznMaPWyzSzXMRcIIJcGyUmfjvkC3ACIDD211FB4c88
 umNwgMVHTtR8zRtRstj367rgzytCBMiL/3BcRg/xt3b2dfwPSADl08Aj2a6ZPqFibhIcEdu9W
 Af0o3DGOpfslC2Y7YNZsBv3EFit2OYbw73Fs11NGPVwFVKKEAS4I983rNL4ZTEZsaUp6S00rl
 CXeOzSSJPLZklGvNovIjrLu+9R8st28N5vYeUKy29owohhMcChEH1KtG0ixCYocJCPxbLm2Bp
 7gdQQKf+raCmKVfkQOqZhgu4lLh2SUoSzN2QFTS4AUgP+xZ3GbaPm5ypeyj0U65X0cFHPSxaR
 aw+Ab5MjYxv/x0xow8ISzhxtCp8OIomaXThcuqs4GjqMMLmzcyStXhgUIC9FQjHJ4oyj/O7Ei
 1rYETiuzLSA4PtlLdPBjkByjVIghxEb1lXHGray29oykrV4wK28GdPS5l5GY9eLjy4i0YM0h+
 10ZYY2+M3FmTWnHIKdnlm+6msNPV57tVfLvEhvGYsobLIAVwcw8DCk+PxL9O7e3xkLy8tHI/+
 dUXJs8nP8nq8e5NCEoPKMHseQmwBrUlcekqT4lIJpT7g3wkz/Y0/U749JlNu0Xh98xGlwy+gL
 Egv9vFiWNz7nC4O15TA8puCVBCOe3TOpCcR63/o3RpkIs4Zbr+Z78Krs4lMqBOC+UfFEKfxYj
 hiVRy5C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Thu, 3 May 2018, Duy Nguyen wrote:

> On Thu, May 3, 2018 at 5:30 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > diff --git a/command-list.txt b/command-list.txt
> > index a1fad28fd82..c89ac8f417f 100644
> > --- a/command-list.txt
> > +++ b/command-list.txt
> > @@ -19,6 +19,7 @@ git-archive                             mainporcelain
> >  git-bisect                              mainporcelain           info
> >  git-blame                               ancillaryinterrogators
> >  git-branch                              mainporcelain           history
> > +git-branch-diff                         mainporcelain           info
> 
> Making it part of "git help" with the info keywords at this stage may
> be premature. "git help" is about _common_ commands and we don't know
> (yet) how popular this will be.

Makes sense. I removed the `mainporcelain` keyword locally.

> (I'm not complaining though, I almost wrote "what witchcraft is this
> and where can I get it" when I see branch-diff output mentioned in
> AEvar's mail)

Yeah, it is pretty neat.

Ciao,
Dscho
