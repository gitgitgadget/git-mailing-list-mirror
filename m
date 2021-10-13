Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C51C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E9760F3A
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhJMWED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:04:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:44431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhJMWEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634162515;
        bh=Jj0qX1ZIGozNTJiuCy8GaDV9c7cxA2wpVxmvxNmXwSc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QEIynj/rbJUygExhkIJzAa9nuWu3AcWGHLehNPaQhREoI7ZTOtBf7ACOCU2NmwxqV
         kP2QT6FlLlvLWeqY26oLO+LwFEY4uqwZqBDKKM5yZ8rQveBu/shO6l7lDeFYV3FA2L
         FttK0TpyGePEODWbQBqPx9aKMA4i1Cwcq4/pewXo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.23.42] ([213.196.212.140]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf4c-1n0nTs42qY-00ilbd; Thu, 14
 Oct 2021 00:01:55 +0200
Date:   Thu, 14 Oct 2021 00:01:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci(windows): ensure that we do not pick up random
 executables
In-Reply-To: <xmqqpms8hlop.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2110132353160.395@tvgsbejvaqbjf.bet>
References: <pull.1057.git.1634129748874.gitgitgadget@gmail.com> <xmqqpms8hlop.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4Lbqi159JqOSlqThyx0opcvvmiTXobvsuJ9OxzzZuxxd8FUsYmi
 jiF/BnlUed1o/zlPpKRy+LGS8+BArtSeORuI8meZafdVFsFk01KZXCgo4nOlMvCQPg4YBRE
 GHTYvG+o4LTZStZTddo5N89s+ZXEWjB+ad6yqWal3XAk9T9xpZHclrZZ6lUZYVsqYp+SAP7
 CmyM3jQUvlQIDt7ZgEdoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oeZjUdDjDSM=:ZJB5N8SycDzgG6pDiDqGii
 +Aj1onG5gJM15RZKoZFCRfVDa40cKWQS8ngaSDxyBHkLcS+M8Deb9zJgDYDM1Jb2eVSOL8FDE
 +u4nw9+FcLw/1fqaKAUQAJuUl5D9/OuvSf/gGymB6gajvNZy1cBGH9nBUAhm2/NGeaAq2sHyX
 IUnTqxhOGouDtPX5G6mxXz71JQMXgCmMaiga6eZzliTx+r8tTJzPkH5tUUa6MU29or7HjADe8
 9UM5DmL2H44IUAuZsRHU8iItnFKXhZ8IZ64joazhe/oGPn0xOGNpAgPyl+sYHAjgadjrPnGVg
 g+7Pr9M1wzwybtug8tFBBLqYLB4mczmPCaKf1UbMjzo31rvooQVnQWApnWa3ys+rlFy2qBXXo
 oCG7GH6Gi207hHGotdugAYVdEiwnHQDKP1qQobE19Q0liOfSL8LgSS8HvOZpOxv1KAyLQQtZM
 4TEBwccI4UPs+EZIQ5JdByBKBjrO6ToQd1WCDRClB8HSNNxf5Xh/FKcsKyoUUTwRo1BmolMjW
 nrpVy+OdJxq6mIcLp2Ap4M2FppnAqCP+RDJFOh1DoJTAobEJJ+VsHqd1dAUgeaHH/mXeFUEP+
 BTeqxrlJTTjRHmSX6c10majBSohvWw/FPSDczKkgWPGepzGgiAtCHAPeswIRSK2OWOro19kyQ
 mLcdb7Zirv1FZZWNRVzf2JUGfPmMVtIvUBhefaY3uG+qN0d+MKFduTAjy+yp3veB3uJCDrdz8
 143wAYcbJRv3WF7aZrrVe6TqmD2dhcbC+mEYlZulgYl9IuRfb28le43S4e6NDE8oEMRMGfcOe
 UwoKj3IOSKj/TAgrK0yKtRSxIt060vNtwfPdVmn0ipHBG0rD9+mgabGPa0xsg3B6QmmylpHo8
 fA7jTO6KdDO1ito7crrwEHyykfvfkDlA6mbqsHm0hR1ZOuPbfX72z+SlFoHMTFayrbsqvFTa/
 ml2/nhhoqNsMbwfYJGVg1Y3EGCniNIDqSZ5it3EUiwnXVW5nlohxEVde4t3XIZnF1TdMC7WdX
 TrRbTrQsqiIKsBEh1DIg3MkTUmgr5gEDge0vyIxpAB7JCxSTwTr/J8C9IViHtORn4txOXDxVH
 aYmcZCPyXegCpk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 13 Oct 2021, Junio C Hamano wrote:

> >     Note: I based this on the earliest topic where it would apply with=
out
> >     merge conflicts, js/ci-windows-update (which is unfortunately quit=
e
> >     recent, it is not reachable from any version older than v2.33.0).
>
> So do you want this forked from v2.33.0 (and merged to 'maint' so
> that v2.33.2, if we need to issue it, would have it)?

Well, I followed your custom and based it on the oldest applicable topic,
js/ci-windows-update. My preference would be for this to be merged into
`maint` rather sooner than later, so that GitGitGadget PRs could target
`maint` and get a meaningful test coverage.

> https://github.com/git/git/actions/runs/1334961399 is the CI/PR run
> on v2.33.1 from yesterday.  Our PATH wasn't contaminated and we
> didn't see the problem you fixed here by mere luck, and you were
> unlucky when you ran the same for generating your release material?

At the time this ran, the `msys2-runtime` package was already upgraded to
a slightly newer version, and even deployed to Git for Windows' Pacman
repository. However, that change was not yet reflected in the `git-sdk-64`
repository (which is a Git mirror, tracking all the Pacman packages that
make up Git for Windows' SDK), as this repository is updated by a nightly
automated build.

As a consequence, the `git-sdk-64-minimal` build had not run, therefore
your build picked up the previous one, with the earlier `msys2-runtime`
version.

That means that the `msys-2.0.dll` file contained in `git-sdk-64-minimal`
was identical to the one in Git for Windows as installed on GitHub's build
agents.

So yes, the PATH was "contaminated". Meaning: the test suite run did pick
up the `gpg.exe` from Git for Windows. And since there was no
`msys-2.0.dll` mismatch, it did its job as intended.

The problem arose when I scrambled to get all the things I wanted to wrap
up before the next Git for Windows release, this past morning, at which
stage the `git-sdk-64-minimal` had already picked up that new
`msys2-runtime` version. As a consequence, the MSYS2 Bash we use to run
Git's test suite in the CI builds had a `msys-2.0.dll` that was different
from the one in `C:\Program Files\Git\usr\bin` (which lives next to the
`gpg.exe` and is therefore used when running that program). That, in turn,
prevented certain functionality from working. Which made the GPG-related
tests fail (maybe not even all of them).

Ciao,
Dscho
