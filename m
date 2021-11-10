Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1AC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BC0611ED
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 14:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhKJOtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:49:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:35205 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231731AbhKJOtB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 09:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636555571;
        bh=3oiSFPjgIWRfkAYziQ7SXlOmqi54w9cAQySoSFEpSJU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B9AGaejKMTd71jPBIcb3xlw0+bgPR/mqzHzI1agiPPx36TCWvhuYkbjjFE4EiOtgr
         JVMQAUEPlMVMo3e7+4eyKbV+DFoz4kWzy4bc3iWHYWH9CAI7v7I5TvtsvCreiocYsV
         qi71YZc3ptQ0FXrgxVDGg6vFDD8omkTVphZeq8cA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1n8hOk1CTx-00Sw76; Wed, 10
 Nov 2021 15:46:11 +0100
Date:   Wed, 10 Nov 2021 15:46:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     andre_pohlmann@posteo.de
cc:     git@vger.kernel.org
Subject: Re: bug or a general misunderstanding
In-Reply-To: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
Message-ID: <nycvar.QRO.7.76.6.2111101545000.21127@tvgsbejvaqbjf.bet>
References: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1697005132-1636555571=:21127"
X-Provags-ID: V03:K1:cG+Jj2L2rKFzw24xSj/4CJm4Y6ur56e6j3uxvFf/8npdeFDgr3r
 7AlGIiKFHPqRJDiLjpdwxGBIOlZDMMCxEhxFKC0aiLGPeyE23cG7b93JWzWcQWpGOmkT+Mw
 ukiehxATtxn2kJ9ESEUQiuQrbi6KlwaksnBYK75BAQ1K/xsdO62n7LwtXk6k6lrT3H46v6V
 KexuZvGeT5n7G7lXp1m9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:djikPFElGAU=:Dyn+JuPIxXh3PmFdKie4SA
 gmTLviu1F+njPPiHRr8dxBvwfgO6bhUAaOi426L5ksHqJmWVrx4mOgrIxfOoKLM4awjiXHH3v
 XdNnUzKNKQCdK/Y678nJ//CRMh9TJQfyhABHSwsIWq8xHw8xNPOkre/17RDIogPjF1zPqJQZM
 Iug5Iikl7bq+/Id/sPCG4kmKR1rp3N4WSrMWMiG6d47M8sUpeEqc1IM2aRyXEjGbLHU78kR7c
 rPQSaR8ze0vq4Szg7t0WZdfPRh25gVS71GKy1Bjk7/pRESv6+RTuYWv87IV99WAhHjJgw6l7a
 3EiC9CP9WGQnsX0ewuTtENaWVt18/TPS9nUKyK9iRtY99JSaRH7zN3dO+Ed7kHs2BW6nzkuo3
 Sng9CidcgpJWhK9ehuwxg4n9C/FPfthxpsUp1xLFCJV1A4XDpgvbLp97xLKM7WnLcyyxQioui
 GLmGtIuf10t48uHmM+hG9hCwj5zvDnAyREn+24yyEmM2jCawjQvalLypn6dOZr3FRLg68vnBN
 +P8Q+2uvbfj4HN6w7Otgj2m44A9fvJWPUnjlAdMKx+vN7h98vovRjr9nu2AlWFx6qRkvrASfR
 a72LwfiPNJ46A3CIgtifQPA9oyrNA9DCFjuSGqtxz97RJqBF3kan3sqZ2mcC7Hifdb0ukzMqi
 hDpOyCuB5nFUFbrNjGacW8sI8lXBt5h+qt+RDTx62JH9aDK2ei3mQpSCwSz8RpWCdwlyZiSav
 LXdL6x0WAYWXuxciVIKwEftSH6aiSk5dWGL7g+FEpZDWLAjOVS9PKqiPqo7RcJv6LHPS9Lwtb
 XMNqyVmOQ0iHMjqzwaEsjnYYYqg6RradWOgeNHjHP5Ye2HVXzu9hTbTvO0S4dDTxpT7gOkyKL
 pVxD/H4WEywT2IwZDE6Pl3UoB3CRQxFGkLdRD8d6FH7YnmDKloEUYGWpuOa3tIY17nw2kOpJN
 Pbvz5fgcpMIOkUmHtlQhoet6vuCFpy3ikpU1iHoFa75QqGK8YoMhjlpCLep/SGTr2bRit7kS2
 heRB4xIc2JhP/oC7bOmZVBc/5W2ejTDwvroCrWqxINATFSpTSyGXNohBbcHQDhPkbVamT5zPS
 /ju3fnvXEdyVmQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1697005132-1636555571=:21127
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 10 Nov 2021, andre_pohlmann@posteo.de wrote:

> The following situation: I wanted to create a branch from a commit. From=
 there
> on the work should be continued.

I suspect that the command you used was `git branch <name> <commit>`? That
_creates_ the branch, but does not switch to it. You need to call `git
switch <name>` to switch the worktree to it. If you want to do all in one
go, use `git switch -c <name> <commit>`.

Ciao,
Johannes

>
> The possible bug:
> The newly created branch is missing commits in the history. Not only are=
 they
> not displayed, the code changes are not present.
> It doesn't matter if the branch is created by Visual Studio or GIT for
> Windows.
> Only in a branch created by GitHub Desktop the commits are present, as I=
 would
> expect.
>
> Is this a bug or do I not understand how GIT works?
>
> Best regards and thank you for the effort
> Andr=C3=A9 Pohlmann
>
>

--8323328-1697005132-1636555571=:21127--
