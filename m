Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC1CC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA02610E5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhKBO2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:28:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:40973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229981AbhKBO2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635863167;
        bh=EIrshZgzfozj5GdvV5maUJCU6vJKp7uFeK7+Me1TpNs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WYZkcsmqP98eZkGkNG1KY3sdT6xrQuoRZBDJ2DlLWj6KiHAPjGlJQxXF+z2XXDeIh
         fwMcZJcRP/r5LcpSUWnEvvCAr/P2CMs43zqb1ZyPFloB02dg57i1D5Qd5CH7s9+f7t
         E4bbRiedzRzPLbZTS/JeDXi2QhkGxnc1F18/0FNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAwXh-1msfIc0Syn-00BNcW; Tue, 02
 Nov 2021 15:26:07 +0100
Date:   Tue, 2 Nov 2021 15:26:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Federico Kircheis <federico.kircheis@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: git aliases and GIT_PREFIX
In-Reply-To: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111021520370.56@tvgsbejvaqbjf.bet>
References: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iAoVSScKWb1nsaKHEgKF7cak9Py86Z8Z9RTSIgeHA2cj5TikCBQ
 NpzbHO2Gly+ZbYaDvhDKztBG2qKe03Q/QClkfp7ed+bepaW8oqrHaOfF2/TBc305x9mS1Sk
 YWC1Ml/xWmIzC45VYnAH2RnfUaRElzf/PdpV52M2WEoM5oUpFraNx4fose6KypYAEKUkKoe
 up9/IFawQHLOgVoOprAbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hngMNpEz7NA=:7E/tQzuN67XQ4upsCeUIRB
 riHxcRkv4vTvo5+rGgnGR1+2buGjBZR6cc/prszimTe9Uc1/DeZq3cAbdMBVpDGK/iIAKmmk6
 6eNMjpgwSZgf8osbiPviz7fzucBtfYGRhvjPk/RcY+k6JMg65dvUdeSCD/m8UXhW7JWTcg692
 VpZm9EJysbExfyawJpa97P5eDfgbKwsVprUPa1CwcbGM+9ZdFjjPI/FKem1gJpGb6c6dDrJDO
 FiIf2sV20cnkYiWBxavtnNqwjrFYHcvry2h1H5mIASfwTRpPAiF6tzYuoh708S3SNvy9B8Wed
 2HbN4NTIuazuOklbRY2Y1Hw51g3EjFDZxaLIqMRZmu67xgUmxnMvMHTuc97QphXd9fHnxFf8h
 mO1BwUD9zBelLORwhko1kHFDGdigBC5cbIlcp1e9wiuPdskHDeLdM8KBLnDv2/VFO3mHCW9sF
 QA4fOuRe5lVRmwfgQCDEGcgW68EzL93uMMHxo1JX9lyEzI1BAhbopn5L7h3VEB+qDLym+A83K
 aGh6YoBkJcQWBGgnPQ6y7Kk2IDUlcKRw6IiwIPWA6h275mXsXWo1WlEd4Z8M4Gy9sNUjaRnUe
 H6vFT5Pp5UGN3ZMSXwuJfdCeY2SXhf4NNM6ZvdG/SMy6MzDs045rBZLt0flo+YWNJQlgyJbup
 VpxlUtXUyNCh8jRYIsPond6+BnT2AKVS1rF7VbdZ8mdSYA0oCoVeus3V9VJGZvKcgylNIVPyJ
 5+YzI9aDqx82B1asi99AWLPGajhNt537IX8OdP7SphSaDK/jh2nbNV9f9GizCBm91ycT5ktf0
 VnpeBsu7y0Nm8xyg43DoXhtGhLOMtbedzZnGVkD7nuATayZ2doxTlL9UMo/lCLguHWhbOOyAk
 FPA+uR5jUIsqZbU3LiS4clW7MS7ZIbnq67tK/gZ4fm1aja30MIfl3naK9TtcLZTCa2x5Y4os/
 rTij+3SG+xL3o3uHt0ovc8D1o/E/SJhBBxh7WERdT6PSOSr3vAKHy0GJrsUfWGy+Y9FKACClV
 T17x5Z/3sSqqv48dUlTIaF0PLYzHFY/ORBf1kTa1pRBQ2AhuhoP5VcWWRI59pEYCpZ8+mF8RQ
 T4ObKO8llh7M2w=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Federico,

On Thu, 28 Oct 2021, Federico Kircheis wrote:

> today I reported what I believed to be a bug on
>
>  https://github.com/git-for-windows/git/issues/3496
>
> and learned about GIT_DIR when working with aliases and git worktree.
>
> It's annoying that GIT_DIR it is defined only if (as far as I've underst=
ood)
> working from a worktrees or submodule, as it does not seem to be related=
 to
> those type of repositories.

To clarify: `GIT_DIR` is set when executing an alias in a worktree other
than the primary one (and probably also in submodules), but not when
executing in a primary worktree.

> This is also irritating because apparently working aliases breaks when b=
eing
> executed from those repositories.

To clarify: an alias that wants to switch to a different repository and
execute Git commands there works well in a primary worktree. But when you
switch to a different repository while executing an alias from a secondary
worktree, it will fail because of `GIT_DIR` having been set.

> I believe it would be better if GIT_DIR it's either always set or never
> (could someone enlighten me why the variable is needed in first place?).

The fact that `GIT_DIR` is not set when calling an alias in a primary
worktree suggests that the behavior in secondary worktrees is not by
design. We should therefore be able to stop setting it there.

The question is: what code is responsible for setting it only in some
circumstances but not others?

Federico, do you have any experience in debugging C code? If so, it would
be good if you could take a crack at investigating this.

Ciao,
Johannes
