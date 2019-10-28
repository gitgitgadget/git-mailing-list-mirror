Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36CD1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfJ1NQK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 09:16:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:45857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfJ1NQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 09:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572268567;
        bh=GL2GBXTZSZz0utLqkYB3RujmS4KbnqrGMy+ksJtqAGM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dVe5smU2AL0+7sCMERC/WIim6MwrlW250B0BSF9amO1dapzEIuu+eT9WmCKTiFcZz
         cHl3PF9t2wE5tU2NADk1Lw3xMCjXBkM1IG/fTmvCsB7n4u1zmvfbN7nHmbR2RfeV7Z
         GFLK6cdQzJqm0j5Cl2Yb88A3ySlyaacFZeXjmwNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1hrvzD2mr2-00beLP; Mon, 28
 Oct 2019 14:16:07 +0100
Date:   Mon, 28 Oct 2019 14:15:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] git-gui: remove unused global declarations
In-Reply-To: <20191025013255.7367-1-me@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1910281412300.46@tvgsbejvaqbjf.bet>
References: <20191025013255.7367-1-me@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:s0WA07zWpiCV2XiSWRmaAVsdKa/V0emBh0fZ4Lpd7t6/2gACYmN
 BfLX/F6VqTwgXRu1ASCsNe80qBTzUk/sHWByXDd09Humn7LekD+5bMOdsVB2h2LWQwAKRdB
 IaqRH2u4kB0iHGSBFKcIJkLF/nz9NWB3pERnSb9p2AddOQMsRsQsEiG56rNWhLsjAqHaxW+
 9g/WGy6sOsue1C/k4q4uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FM8JBWu6XVI=:axc0rOX6EAPaGJUf31kMDO
 P0vuSdb+u530fRY9LAfobux2NwVwqkbKDGOJuUkvqy/kDtUfbQHcO17jWUKAKTe+LF55aHZaS
 t9Msqwhvq1SCoZUikHrLBtPF1NZua80UCLrckUTikJHGb1Oz+IaC7+bGxfXD8VtvfQZihOCvg
 0HazYPQIrmMbBZdJ7kikJCfwwiEnC12Et7zjErKg4dkMEgKy/38qiQqmYALc0ROKMNbHZCM6z
 2nMIQvfOXhLijbDdCjnFtwgDJ6kxbVrdN2LnixJ5bS+vjjBsM3LTTDYBdJUxcRPRcfz7o2kdt
 F98g/1E9r3DkOse399CVsyxu952n8kQJAbZvPZkIZlOYqVnzxT9siHmVgLy7K+HekUBJ+VOJX
 qYwYpm2JLIY/EijZMo4vFHMV4nV0KGIGq31CE65sSKuquqo8pd+ddQa4ZjE0vz75g0GCHdf4U
 xUoN9vEhMBvwJHXWtHmnxieEuRFm6/XDJ3/KiFvpR0GR8sKz0oa96KBBU0FCCmMGu/Jb5P8ab
 Q6azky2V0wzeDqU5kBksxfMpBL3fkruwrRiqgvTI+TvtNuzZATkOd87Fj5TusRRV9WnbvBR8s
 J9rhRpdgbp8HljbzsJilBE5r5NIGo11ZEb18ID5+ImJzXhjWTgAtTPOsV7VLusBBhpvD+DGpz
 j61Lb5F4eav728Bi1kexPw7ktig4sVbUyB1Wr4t8naDO2ijWmODTnY+09igA44jKoQMjRV2ip
 fbmE+g5Py1fVqMVo2dOh65HG6GGadOgrEoRJc6u1vZ9r+tv26TsMU+WD+WrGw4WHS3PegOajW
 thgKngwHvTX9Qy9QYHkkQp0WKUrtWIgdZ05P5iEYxZk8Hm9Yn3sS5hERM4uAG4KLi64bug7AY
 xW/ANWQgkfkaYGU6FCgbqLF5m3VprhoR3YuNKu3g2HOoJGqZIv17zegl6LpPZmSJOnXujvGD5
 Wdz/S5BntczHwQBIJLtg4PHhpLWDLjARtomHNt5xiMSP0swHxyde2rxT6ZiXmYvfEsnYtUp/P
 cN5b15gVEnyxCFFlfKmDAV0bh4ywDY86h78FPaN+OClIqefpHn1w6ITNHn/CqW7AU5rf4cwYc
 yJUw/+KD7uUWKtIfiuTYhh/xgeCAVQf3+2zN+no5NU8G6+n4USKteTocgY3IfhmvxWcKSrup6
 eqN2H9+qLinC2ya/x5L+BTxSEEtiRcv/9DVXuHSgd9iWVb0K5mqTkenyoneHwfSkbNKkgkmqi
 B8cx5QMFGt+7/d/E/ondvy8Ncvj2qjeGB+eLdtFh6lIhfgP8WyAYI7+vLQps=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Fri, 25 Oct 2019, Pratyush Yadav wrote:

> A lot of places have unused global variables declared. Remove them.
>
> It started as a couple of quick fixes and ended up in me writing an ugly
> hacky script to catch all the instances of unused global declarations.
> Lot more than I expected.
>
> The script can be found at [0].

Wouldn't it make more sense to integrate that script into a Makefile
target `check`, rather than hiding it in a gist (that might become
unavailable if GitHub goes away, as some of you seem to fear)?

> The script at [0] will only catch the unused globals in 'proc's. But
> git-gui also has 'method's and 'constructor's. Just change '^proc' to
> '^constructor' or '^method'.

Why not use `grep -E -n -e '^(proc|method)'`?

> I manually checked each instance before removing just to be sure I'm not
> doing something wrong. Still, a bit of testing would be appreciated.
> Just apply this patch and go on about your business as usual. There
> _should_ be no change in the behaviour. I tested some basic functions
> like commit, push, etc, and they work fine for me.

I would, if I used Git GUI regularly ;-)

Ciao,
Dscho

>
> [0] https://gist.github.com/prati0100/0f3ef903ad1658e76ea0b95f001b4865
>
> Pratyush Yadav (1):
>   git-gui: remove unused global declarations
>
>  git-gui.sh                | 12 ++++--------
>  lib/about.tcl             |  2 +-
>  lib/blame.tcl             |  3 +--
>  lib/branch_checkout.tcl   |  2 +-
>  lib/branch_create.tcl     |  1 -
>  lib/branch_delete.tcl     |  2 +-
>  lib/browser.tcl           |  2 +-
>  lib/checkout_op.tcl       |  4 +---
>  lib/choose_font.tcl       |  2 +-
>  lib/choose_repository.tcl |  6 +++---
>  lib/class.tcl             |  1 -
>  lib/commit.tcl            | 10 +++-------
>  lib/console.tcl           |  2 +-
>  lib/database.tcl          |  2 +-
>  lib/diff.tcl              | 21 +++++++--------------
>  lib/error.tcl             |  2 +-
>  lib/index.tcl             |  9 ++++-----
>  lib/line.tcl              |  2 +-
>  lib/merge.tcl             |  5 ++---
>  lib/mergetool.tcl         | 10 +++++-----
>  lib/remote_add.tcl        |  5 ++---
>  lib/search.tcl            |  4 ++--
>  lib/sshkey.tcl            |  2 +-
>  lib/tools_dlg.tcl         |  6 +++---
>  24 files changed, 47 insertions(+), 70 deletions(-)
>
> --
> 2.21.0
>
>
