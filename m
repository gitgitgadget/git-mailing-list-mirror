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
	by dcvr.yhbt.net (Postfix) with ESMTP id 542BD1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 10:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfGLK3Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 06:29:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:53817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfGLK3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 06:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562927348;
        bh=u1317UM+YzNIygKeQxKILcMcc4S/qwDyrCasIAjdaXY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=A/JZgBgPkdPUsiIbsEqJhBIcjgWHvhDahWXQf+1BqUqXA/B7gAF4ehYdZiRDhcEuG
         tfyhz4+JaI3cqmzTBvnzxfh17Od53yIh7Sn5YjfOEPGq//xy+niaKns6gD/C+mPeLP
         +ok+osJ/Y6vlvxOQEo103Zik0qhIIMGJvJ9me/nA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1iiXp30tCH-00wq5e; Fri, 12
 Jul 2019 12:29:08 +0200
Date:   Fri, 12 Jul 2019 12:29:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Mark Florian <mflorian@gitlab.com>, git@vger.kernel.org
Subject: Re: `@` alias for `HEAD` not working in `git push -u origin @`
In-Reply-To: <20190711144828.GH9224@genre.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1907121228110.47@tvgsbejvaqbjf.bet>
References: <CANC=f2c8eynWJ1r=zwZq1qwrDE85LVFMU2mjLU26HYMDGaD4iA@mail.gmail.com> <20190710233937.GG9224@genre.crustytoothpaste.net> <nycvar.QRO.7.76.6.1907111141380.46@tvgsbejvaqbjf.bet> <20190711144828.GH9224@genre.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cfkEMlZz73MUokqA3lCRTE2WiX0AcasP2PHFZRlL6tc0LyGHw2q
 72oKpvQJipzZMiXM6LRWUi6dFO/QJF+r61frpIrUrIv72FRPWPoUhrwKL3xtSyLGxK96Wlj
 NalSbkGXxmlOt9D7sShAGjYxwmENSaB3K8E0IfVqjbY4UTidcbToJ8pvUmaOYTgDj2uXZ0j
 Fce9ZLdf+/+unqrbMYZJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HgiOwnGOupU=:leoU+AbPQSRGAV5s3BYWsB
 Zbk5XaqZ9ggqV91NpE/mbdZYAbmqpHMFCKe9Gbg2eNfyhLEedVsng64Pyof0hLDdp4UOjh15N
 V2kpijO1ETKWGS+2z63NgLky+U1KMqsU4YCs5e3sT7kdSRnbXmwuHIZ3BK85n1SVyOnqXWW0z
 CsAKKF6u/2xv4QR+K1LIJUfCGqfnKxvdtunjoQ4TPPYy5O4+Tw4PYfMuR8Bl4yqWQxMBs9k8S
 I76b3Ii2+i2gRU7UzeTTO3tCLPZClfSrSjuHoollnHZYh8MYHDyFaLB+YIz+0X1Fmk17d+tcj
 HZOonpkcRAnd3w8uLIWns82Ae1dlGMncdtVWYLAj5AvV4nhunRP0yrlicGAsYHInqKlkKMtdD
 SqoW8qZnx6XTo+t0t4eAY9Pvlva6NFu9nE74or7FkoPN8QQbGL4jpUD2In0caHJ/sTRuiPu+F
 TpZaTZOGNtzcmb1iMJz7xVmofAUsfM+XLoZPfARtNFMniNvOedIefhO83E0mtE2/45PwYGbLe
 zcYWGg0wejB3INK5lvDxzPqllZ+CgIOlbARKg2ICzrIo+zMFtM1w0xYinIs1uIz0vVblmvjjm
 4wErSSwFM3PDID27BznrSRsKSVQg0gByIBWOj49gj5Urd/cj+aB/hhgY4yWrckeu44IpbVlJu
 C+xY2I459dJl8Gycf8Am41lrelrRoDmcqxnymIEaJzuMNJn3x+WfTsM19l5j1QG829/5mbQSX
 m8qgHciBcSYTr8SRoriLCNjfn7Xuhrhgwldm5ZTLxFc8gxlwAmFsE8DHRR/rtOpZIfe8K4aDz
 L9HSe8Q8ZtEYjovKbAyE+G1cnGoEVEo9bV57qvyuimETuthphF/o/4ntGOdeF86wAMvIC5Ik/
 gGvgVj/Lhz1GjvFJAfmKtLkzyNsG+Vm6e9jO3ZCaCDF6lYxXkoL7Fuh0PdkQFrmDD7TwMbhaW
 bu2KQcNO3Q5phF5zRbMO/K5L77Z2rwJUQScWHXOr5lAjlStk49GJ24Jg8Ftdf2Yd5Mn5KfjN7
 H29XXfjWXI4DcCi3CKuuuj4Q9E3IQunb8SXOB293+V5bbAcvB2Dok1m5CRmnybMy83wsKMI4l
 Tng+EGG1Lh32dRhZyewmbo3et/vjOoPwwMw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Thu, 11 Jul 2019, brian m. carlson wrote:

> On 2019-07-11 at 09:46:26, Johannes Schindelin wrote:
>
> > Since I have your attention and since I am interested in a related iss=
ue
> > (when I wanted to propose a GSoC mini project to let `git fetch <remot=
e>
> > @` expand the `@` to the current (local) branch name, Matthieu Moy
> > pointed out that `git fetch --current <remote>` might be a better UI):
> > what does your patch do with `git fetch`'s refspec arguments?
>
> I haven't checked. I believe it would resolve "git fetch origin @" to
> "git fetch origin HEAD" and "git fetch origin @:refs/heads/master" to
> "git fetch origin HEAD:refs/heads/master".

That sounds like a sane behavior, as `@` on the "src" side of a refspec
that tries to fetch from a remote repository should probably not expand
to a _local_ branch.

> I can add some additional tests for this case, although I'm not
> especially sure that it provides useful behavior people will want.

Nah, from my side this is not necessary.

Ciao,
Dscho
