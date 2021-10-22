Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFFC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAE260F0F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 15:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhJVPcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:32:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:48001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhJVPcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634916579;
        bh=duv+E65BUkYbhD+fIoAAnHRgQ5O7aTszuTSx9GFZESw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fJAAn9yKa+Qj5XkabWKhG/PlYONazMkDbMzi3qVNwFzTw7OyF13ztehunGRMGfhYy
         TyCmSnu+DKRojY2hgH8Ut4RTa21uD0rOAj3rvAXbsKJ9OgxlyMJbuN0v+JCzqn+ZP+
         dRy3YDjIcaguHzVTfEriQ7FdYTNU7NnuGet2ZPJs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1mR2Je17wH-00DW2U; Fri, 22
 Oct 2021 17:29:39 +0200
Date:   Fri, 22 Oct 2021 17:29:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philipp Eib <philipp.w.eib@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: Error in 'git clone' via SSH in v2.33.0 (related to commit
 ae1a7ee)
In-Reply-To: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110221723430.62@tvgsbejvaqbjf.bet>
References: <CAN2Gq0de1tpiLNcQqoZmgAu=kuOXxEmAtziWM7OJtGPGhLneYQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pk4G/noEfeTWgc6L65kj2Z+NawupiTC/qbuOHZ3hHXIVlrHZA6c
 HOvyD9ZdQrORomxOGwqPIX0DaIqHnckBJ3BD8ceLHKrWXKObc3ZfKloR2TMeN7FKSHp07dY
 6VSLtRy4ISJysarrT8e2KQ5s+7pCH5+fZKXSspG8ub0rfB21ofo9FLKTFoxL2NaEb9wEpVd
 rB4LEK+9coq+z1pfD2GwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dRvtwyh9lSo=:zJ6SQmrUsNS8yr5aQhpZMx
 7ewpJK/h9ZZx+z7IFZ4ZZWIdwMYdVB63Z6mDLieRH6bQZAvNv1Ub2WKFQ47oBKSErVgF5ufC0
 QmGZtIjJaYG75hx/qc8iBMe87SD0xtS+igWndDsRkyaE9Vi+9k+QOj42OjOrucRkVn6wsXha+
 GWCUiZdIXApKMeZx3plKI6KBZGH/beDG3FyXO9vAGV5yjEAVEwt8/IV7ZZ223t735RijfVndF
 RAcuJ8ClFukaTfFGhtH7nA3rWuDbAmcc8it9RtM9z9q5wz9FccXGNBO3DUiUjncxVhoS+u2WB
 P27wigirfxE5Ce9//VBo5kEoiKgv8edosAx0PCReqY6t3+HbC0QWrfceCtc7JglEskKdLYlBp
 hg7XkDeOtb+ltJpEwni6CNoklsY5esqZa8B64igZeK53a6wr/OXk7E1F80uNUlUQQjvnLcsnk
 dp0GauJ9e2ObD5VAW47egtyB9daM+iUivH0Sm4dKjTJeOJJipiwolghONyR0n3JfUlaONQxL2
 Tf1EKYN3LiZxX1rxS/gtvNbzv3RyXnkFqI1bu2r8xJYo7uA3diVmp6siGNSshRTuhLzSJYR4d
 ftxMG4kzjhAA8+HJgtPCAr7A8FqkI1eLN9wZxrcozM7PsLm44ZioarNdSk1wOEC4Vcr3i3Mhd
 ntZNMGVtVo+iIfOadggXiyhTefV2YB9DJ1Qenp0x1A5qG8WOYnjXTbZPCnR5e21fu0JOUsxCK
 oFMkzU/8l0r8ytBYOvjdZ3VNtljnVqLeXiITbQrFovgBiXGSqpjIZ+7k6oPjKCP5nyQjUeWHi
 FhymyrvyrYXweybRrQqaQuf9s8SOUgeRaL5mWpzFSTZXj0ZWmpqTTidfpHhZJ1sOvyLodNSmZ
 aldonoW/RMqauOvtZIp+L2THZKW0jKGBByie9qYnM6wyjRckxq6EffxdvidSQ6ZgjeHGD+yYu
 B/7nT2LiWY2OV3u/7f0PQpnXZxhTnNicO458OIOkjmBnHPCRDGzXndjCJAalD0ha1vv7oS4H5
 PRrioNp8DpvAg52loY0Fp3yfj1hLpH+ZSdF00Y4bjd+U+rCGPxEoyJzIikmx3TBN7E2TTSpSm
 99E4jQW16u0TWU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[Cc:ing Peff as the author of the commit identified as the culprit]

On Fri, 22 Oct 2021, Philipp Eib wrote:

> Hi,
>
> Using git-for-windows, I noticed that an SSH git clone of an internal
> repo broke for me in git v2.33.0
> The exact error is:
>
> fetch-pack: unexpected disconnect while reading sideband packet/s
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack

It might be important to note that this is using SSH.

>
> Cloning via HTTPS continued to work.
> It was also repository-specific as cloning other repositories from the
> same (Gitlab) instance via SSH was working fine.
>
> Together with the maintainer we traced the problem back to git commit
> ae1a7ee (https://github.com/git/git/commit/ae1a7eefffe60425e6bf6a2065e04=
2ae051cfb6c).

The `--pretty=3Dreference` format: ae1a7eefffe6 (fetch-pack: signal v2
server that we are done making requests, 2021-05-19). The idea of this
patch is apparently to "do a half-duplex shutdown to indicate that they
can hang up as soon as the pack is sent".

Peff, any ideas what could go wrong here?

Thanks,
Dscho

> Reverting this commit and rebuilding fixed the issue within git-for-wind=
ows.
> (You can read the full conversation here:
> https://github.com/git-for-windows/git/issues/3444)
>
> Unfortunately I cannot give a reproducible example as the internal
> repository cannot be shared.
> I have also not tested on linux.
>
> Regards,
> Philipp
>
