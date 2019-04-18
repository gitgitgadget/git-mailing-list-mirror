Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A3C20248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfDRNIL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:08:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:52473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfDRNIL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555592883;
        bh=fB5nzjxoei5T5ZkIUDjcPyoIDeCethpYlh0NaLER4h4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eqXfdh6QrveE3MwWa1la/UhLqMU/SeHDRb+C3B3Bl5BoT3mJrytzEeM/B9dhYD78h
         iPltdzL/b/6XkgPeePtFxCVcQ9LctfByWAHUdqEREFMgfQs777R5fyvm9i50DY5Q5B
         Gb1RzQci9OwiHSpvH50GL8vGPcf+K+dsJ3dg3V6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh6lB-1hUUux43MH-00MHuW; Thu, 18
 Apr 2019 15:08:03 +0200
Date:   Thu, 18 Apr 2019 15:08:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
In-Reply-To: <CAPig+cSHJ_g=KGBL2qoJK7Ddv6QhoC2Fq=2dyRF1qexAv63RiA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904181507240.46@tvgsbejvaqbjf.bet>
References: <pull.168.git.gitgitgadget@gmail.com> <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com> <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com> <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com> <CAPig+cSHJ_g=KGBL2qoJK7Ddv6QhoC2Fq=2dyRF1qexAv63RiA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nWvgARf5CYrYp0gZkV0y1aazYVtXb/37zcvaSGWWHh+/XABaB96
 JcbY6HnzIR/70eDVAQwklEbL8yTO0gOuPkulzJ7jL7+KWwSrFhjrPumztb0dQdBirFmK0Wf
 rjSzMxBo97S0letrHwBZgYbT6XDn+K3h1zD3hqK+0XGHjILlufr17GdxY1gO4Zy909mSUOu
 yEWH8OltYQYLPpyo6AAww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjupFhhrfJU=:Qbge8p3+pzgbwIN9AfY8uI
 eWRMHpFXBIGribwaapFi72LGqz0lLzt25+fcwvl7PUZl1wjMzRULA+V0IaBnBoPnS/5r9hi21
 cexOauN68WB/TPtgisllMVu74+wsbV0vsF2EdS5aXqRcboF2bUgCgxRJ0CR8uSrhMSrzRR/+P
 PxzFFKzmTWplS+nO5bWGJt9hig0CEv91cImX4gVNeOfGqrDZ8omTSLfon5zfG43/tZiSwbMc7
 ZdAHL5Pl6kcxo9Rpd56llLrQoToxbqK9x6lSNRKP6zpVnYIq9zjeWRw0EPsEctI653E5k6+a4
 LhGZiBDJ61i8t/WGfumKGxj4BW6n57ix3QHwRLgRUllTcKsP0gKQDinmAmw/35Wyr5ZN67gZn
 TRJQEfefbH9zqvTa/RK9+pFw/zXeRcyWszGcNZnhcHKdGNq6peSDuFRctFQ7pmYIIjCT1fxR7
 8MdoRJx8k0QEVbLJPe7ULzGFxvdct6KCWckc6VTEBo76WJ931XJ9haBE6qtbk6INnuL53GP4Z
 LfKo56JGHAxlbtYv+Zpw1qSDxLQwcNdB/DIAUiNwkRwe4rmoaQ3zktYxp/EInIt6ZMKF+1PrP
 FtpIBKHjZuO4f1Zs31e/weUhGoHzaZ8UA6ptsT62Uwhg5lGWcOB85Po1kBFw0lttvVtdCI9gN
 ta6q871QM+rX7W99zp3mJ0Bbl/UWruckylbP37Lc5DAajDOst5RiI4zPAuMDf+MjAmmbXue8t
 zqoODcMAgrIrGo0VNrKEicciEnsIR3L+UEWaVAk537ZeHe/jUnK6Nh7R1o5tbcEvYriF41qM5
 gUbJcdx60gx+eWdruSzkmPryswvJCcD6pOxR8gogCvtGNlz+A4PyiEZYMt9Xj1517GM515sSb
 tBFh0sRSXDKHVsxLuExvzpmQNn+vYPfEF7DJ7wK6rqaaHS5C+hpOZYHi5YNRvkSdNuZvn7Wry
 WrViIXoIA6Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric & Junio,

On Mon, 15 Apr 2019, Eric Sunshine wrote:

> On Mon, Apr 15, 2019 at 12:16 AM Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> > When composing that email, I originally wrote $(wildcard
> > config.mak.autogen) as the suggestion but changed it to the looser
> > $(wildcard config.mak*) when I realized that the developer's own
> > config.mak probably ought to be a dependency, as well. Taking your
> > objection into consideration, we could mention both explicitly:
> >
> >     Documentation/GIT-EXCLUDED-PROGRAMS: Makefile \
> >         $(wildcard config.mak) $(wildcard config.mak.autogen)
>
> Bleh, I forgot config.mak.uname from Dscho's original patch.
>
>     Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname \
>         $(wildcard config.mak) $(wildcard config.mak.autogen)

Right.

I had that locally in the meantime, but based on Peff's suggestion went
for a GIT-CFLAGS like approach instead.

Ciao,
Dscho
