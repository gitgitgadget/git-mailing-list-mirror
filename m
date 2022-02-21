Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A497C4332F
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 09:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbiBUJic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:38:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351655AbiBUJhd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 04:37:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5427B3A706
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645434975;
        bh=4GnzN26Y2KGWSNeppXGKN1SLW9+sCOvvfRDX9rahJr0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lH5zKJ8zdGOKXI09elIZqGkqA++F0vgmD0597cfxsApL1jeFNXb7RDnzmkE1t1aaZ
         bBZQ7/hbkcIUfTcfJuc1tKiRgNVANHdvQrp7cEILb9EIHlIpUA9SthMhdJt0D4uG6I
         rXamheK2/LtFQNu6RZ2m+R3yfmde3TQ4I0wMzo0Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1o0Ny52T1K-00oE3c; Mon, 21
 Feb 2022 10:16:15 +0100
Date:   Mon, 21 Feb 2022 10:16:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 00/12] In-core git merge-tree ("Server side merges")
In-Reply-To: <220220.86k0dpd8c8.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202211015360.26495@tvgsbejvaqbjf.bet>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com> <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com> <220220.86k0dpd8c8.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1355067625-1645434975=:26495"
X-Provags-ID: V03:K1:P3Oi6Ua9KhmsBatnZP+FoMy5Haa4eJfH63LrmPeBSAahcYeR38K
 yJK8OgvLrDo/uOKwe5nL7EYbTgnQP1ibK050xvU+0W1p+wr5XVBHcXM+ird7mJJFFx2QTHw
 7CCXZbIlCoJELwHTDRCEMcI8RzoNBG0pMH2a2KKTsjQGoogSoEZIhYXGtumRoZWFxLFGsX6
 xH2ret3GMDkPC+agNC/Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V0Ywx9GuJBg=:h9GRC3Q3be9acBuQosqamk
 gz3rL9BwOiMQxCE7wxJgMOZxv8jnaKjfG68yMG5koT9w4S7UNsBfbeP27d4I4PnvxVJBYv/gO
 pWnuxY6+gg2JRbEwa2Pu+Xbs/sukIIk/wUr6tg2Ide62qPlUDFTlv/pqwWe/dRU7sH9YpWCn4
 Lh5/Ik0tZmGtZzvAt9HOqHM0HKCQSJejDs4zeg2HK83EbT1nO6Tlu8ZuI8XSBvHkQvHIerxUN
 FNIr22QUy/EMhuOz5Yfxy8lAGo4s6mxH81mYRZHHIYnXQDlycVqSw8MygO5oLMHvuXzPdVz/E
 1Dz6yOTxfHlcPrhUDny1Au+vNbtjc5B6fRiUQagcQSJYGQXZwvoEpfHB3J33cUancCfmlHugP
 85cM7cyCm8hkeLm7+sHW5dkSSvIyFAKhPo0PAMkKC4aRBU9plVHfNlyxG6Oy3YFyRxwbv68jp
 zPVbwiM/n3SUnKDSnz157G6AOZrXwsm0o9KozDz7P/m6kmXO/qxuVtCYKxae/4EapRCjpe257
 ENGqDOnRyWygkztkMUmFymYPL2yToLOPRwTbSffeagum0GKwb2B9EcDNrY3Tn9Y6QwZ5b77td
 lPYlSFSMRhPV9xHE/pdhmiSWRTFLH6mCwXQojafK+bz0i9L5IRZtyu2SGtTXyMD2ChXBt7yeW
 CzzOqm72XzKt7IawgI8YorcKx9ycDa5ckLY1muqj/qJqJpp2RJjWhvJIpc/XC/8crJFQD0rYb
 eOUX7L8ElXq8tmojMY6N6XQ8GiqV93zuOku8MOBs5TCOYQSKCN3W78ZVkqmxir0rGXZGVvHAh
 PMERTXyCTMaufUWXbjxRaWCpAFl0BbZJZOcZq8ekwCcyUbcyRTmMDyw6KBhIZGkZMJlScSPPh
 apDOnMxY6DSsVz0Fj91EzF8L/c91gVtNwTm2828qEV4ZQpI2t3+ukppKiOzjEBSsuZN7IVSow
 4h1mQOHNjaV/3kqnYqeyR2h2vcucNm3ODI0Kr3QgZb42Wsxzq2wnKEv/MT9qwzzsOSZ9fYAcT
 WO8PA4g4ycChh+JFlvGRpdW6ZW09Tr+TbV+FV4Cm2n3ODn0IOe1xO8Mx1ZrYKLyi4iHZ35nZk
 95GhQUWEYM9KMw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1355067625-1645434975=:26495
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 20 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-=
tree.txt
> index 306149fa0e2..723b1995426 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -9,17 +9,24 @@ git-merge-tree - Perform merge without touching index =
or working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge-tree' [--write-tree] [<options>] <branch1> <branch2>
> -'git merge-tree' [--trivial-merge] <base-tree> <branch1> <branch2> (dep=
recated)
> +'git merge-tree' --write-tree [<options>] <branch1> <branch2>
> +'git merge-tree' --trivial-merge <base-tree> <branch1> <branch2>

Given that we want to get away from `--trivial-merge` (and probably even
deprecating and then dropping it), this direction makes no sense.

Ciao,
Johannes

--8323328-1355067625-1645434975=:26495--
