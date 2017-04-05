Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895CA2096C
	for <e@80x24.org>; Wed,  5 Apr 2017 08:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbdDEI6x (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 04:58:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:51272 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932766AbdDEI6v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 04:58:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCcvy-1cnPJq2LzO-009N6s; Wed, 05
 Apr 2017 10:58:48 +0200
Date:   Wed, 5 Apr 2017 10:58:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?R=C3=A9mi_Galan_Alfonso?= <remi.galanalfonso@almacam.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault on git for Windows
In-Reply-To: <ca311f4c1abc4460b6bc2d444916b6bf@almacam.com>
Message-ID: <alpine.DEB.2.20.1704051057150.4268@virtualbox>
References: <ca311f4c1abc4460b6bc2d444916b6bf@almacam.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1970656368-1491382728=:4268"
X-Provags-ID: V03:K0:nf2hfBJlXoWJPxj+95YmibxIbFi+Qc5KFtZcMoQp5x30J1mAPI6
 GO+dVs3hs9Z20XH2WHFmC3fRxV+KnIvnhiBgq+otnkcxzD0EsJ6aJZMUZn8sdCR6dJFOCfB
 17DKITSIgUiL+3e5ynbfm2Tg37ok8LaVeO1nctKV8DGsSuLKffCGGTAGm6M/hhbH0zRgJeM
 BKHKHF7chDbTHat4giQFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nSfRRQACrN8=:k+yc3+y5oW5vZzukkYh0jC
 VgFyt51komB0Soc+JJCAdGTl2pdVlQ/0csWoRmRgE8Xm9c56MNDPbay1XJkB6NX40lGGINw0U
 IRDd0FDROaMqCq4DydCVHlpWSMARS2Ryg5rrp2XxYozS/qSE/4a46ugQscuJp5iQaSqV8lppp
 Te6dHAkG3b7tlEFdEUy9rt8WhLTEu3kxndVQaaV/9snwOAqnULoT87Y36We4liqoFgbQNmGk1
 cgizqT/9Er4EYr9nEDhwWq7zQR+BHYYFRLX2j3fG6CUcMjm5I4q5zLJFEqDbVSkHdgAGceSQc
 VoEOuGrXzKPiQL2zDeibx18IswzYdpENgcSJDQOplNfYyF6mQlG5OA5hEF5RsPJ2s2KOw49nk
 C8g30PRNRSgY0U/sJ9gjZuXbWkDtepQraNbkFX45vnqi8UD9/kYYah4tsNeyy7h8kIgIosXcQ
 1bOjknozks9Re0oFOBn56yxi3gPtEGD3+sN/fvLFU6x3iFPNhuEHwu4ceTapGYWxLmDHtRIGT
 ZCJubxcgHB0UunmZfw0MHibsO2z1Asb6yqwzPhIYANSb14UXnx7LnyOhH6z5eyOINIOyUvIw5
 t4gIrAeJ4jcrH1OFcd+Umx8D+1zHS5x1a5EUzT0n9/vdng+J4SoV/8QkJzVEsNQRIp4RDHsoA
 gePzuETM+elN49ayJarRtLVuO3kt2qyfAQXhexomy3yRDm2wFevm2/QAG4CRdbXXMXGd9n9Kd
 U7CLLQNYcueRCM74m4KA+yyYFrCbmNWVjzaV7HGYIO1/ZLPTjcQYt+byfdrYCHu0Z3hvaRvMt
 /ebiIb5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1970656368-1491382728=:4268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi R=C3=A9mi,

On Wed, 5 Apr 2017, R=C3=A9mi Galan Alfonso wrote:

> At $DAYWORK, the code is versionned under SVN. Since I haven't used SVN
> before and try to have a clean and bisectable history, I installed git
> with the intent to manage my code locally before pushing to SVN when I'm
> satisfied (I haven't tries git-svn because I have never used it and
> would like to avoid screwing up the SVN repo by some mistake).
>=20
> So first to setup the local repo, I wanted to add all of the code files.
> So I first ran at the root of the repo:
>   $ git add ./**.cpp
> Which is quite a big amount of files (partly because of external
> dependencies which would have been smart to exclude, but it's done).
>   $ find -type f -name "**.cpp" | wc -l
>   8676
> This command worked (return status is 0 and no error message).
>=20
> However following `git add **.hpp` and `git status` segfault with no
> additional message:
>   $ git status
>   Segmentation fault

I think this is the problem identified in
https://github.com/git-for-windows/git/issues/1111.

To verify, you could try the snapshot (with the proposed fix) hosted here:
http://wingit.blob.core.windows.net/files/index.html

Ciao,
Johannes
--8323329-1970656368-1491382728=:4268--
