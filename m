Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B9C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C283206BE
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 13:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SpJ6NBNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgF3NRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:17:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:53821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbgF3NRC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 09:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593523006;
        bh=JXqXKGSk7FTuYWwFn5odTdCsawzKntDGKZgdjK0g8Ds=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SpJ6NBNc0U5BIr6DPPtgfQiy57Ku3rKvLw2p7xHp8/f+CIv1ukHeXD0PC+umgCX3J
         p/1Z+rJcDLEvRlHX9S3Lp1TV+guX2fBGRB3J6yuWODjq/uOVKVDRZNexs9A9VuiyKf
         BwPLRyrDcAKQJmi3ofR3Btlg9yDv0uJKMEvsshqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.116.87] ([213.196.212.146]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1jIiYu179u-00XbSV; Tue, 30
 Jun 2020 15:16:46 +0200
Date:   Mon, 29 Jun 2020 15:27:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4 1/9] fmt-merge-msg: stop treating `master` specially
In-Reply-To: <20200629162003.GD20303@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2006291520220.56@tvgsbejvaqbjf.bet>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com> <pull.656.v4.git.1593009996.gitgitgadget@gmail.com> <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com> <20200629162003.GD20303@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1652750913-1593437267=:56"
X-Provags-ID: V03:K1:lLx9VL5OQqQ6/c6r2J9dBmzxw0yAltiSvGUQuO7E0ruOX/NymzI
 +e6I8Mpgkew8UodOW6ZnLwnMYAYc7aXAVzaK9lZKUALeht4qC0dOEDUu3YwJ0NjOgy3WnUR
 wIedr5PKvgk55rYzqxJrYelYoakzE24aDO9cn9GnJJsiDnqAGfIBGPeySh41/lsHtT7o8V1
 R7FaJN4IMQZ6+AA4ElrHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u2oEer+3Lys=:UG70laBkCwK7R1X6Dwk5+N
 VTSu03acwhSYYNokr0lseNaDE0Pf8jpMn2wzU2jtdvKngK90gIN3WWOLFZ1gAZhh/E/n/i88v
 +vmMLLG2hN+6Wr/EBNpK6i62GpsRY9hC2UE8GRMVxypQVP+3sFo8Comrgx7Em4LXG2nSzTMDF
 88NW/MIgiz88ECorVdRNUpl0CufN/IE3IhJ6PIJXPXz1twwqKLdtYEebb6oEUgNLCVo6RLgRm
 w7cpZWmFyO3OvC8ZeMPZ3ZvlEdWL5fK+UOfx13roUmON/g2s4Iaw1E+8Pc7Bp23Um1vAJ7eD1
 W3bPFnF0isRlD/7FKvA61CPG+dS/sdTRG5eDn+h57WfGJpVb8O2n0D0z+GUG/X8k8SIp9CsJV
 tn6ZXO4/1Im2xeHOmmQC4/JhaZ9kV0WY1+E7gK1dSyzbeSz+Gr8PtPDpS0l57BdA4OL6P4kVK
 FdMArdxJavY7A8l6Vf64D4tsee8A4Lcm+xEUPIlxRzI+850rYR1Y7s3UHN276lN95pKzP904D
 yJeGzBFWsHa8rFnX/VDDcq1wLJjKOmJj7pzcYbTOb85p8xN+jq9z6PsGHpFVJI5Z/GotGS6Hk
 R900WksUZbWf66Cmh7OSvivnymWadoqitfLoovcL99iVkAdeOuL1DEH9rOvqxIlkpjRpqgowg
 52OskBsCTJ06s5SLCdXpm0HfcB+yj6U8+Ic60SuWDf9mc4tKiJ1PBcG7BoY7doxKp69OU45BY
 bu+LPK5XPeg/5t7ZyiF7xuOhHtDzlVZH+A+XY/CTpGGq0x/nO03ZqGC33amGwYmqVNw8LRxt4
 +j5IDNc/Neuv+LRxQA1qp4ndHG9FXLvzU0sQg6j3oYVVsUPJBWkvYPEgU0uL+E2swNF9S4ctA
 fiCE6VzQmmxGZCyqhfJPQsyd/bnC6AqUF6AvzkXeHwcsLHvl3iLWlzRAZxgzEesoMfuiKzSOq
 eX1hhNbctm38FGr30ENhXEFgdvRcb+afVoQ3bAMmXrsKHcV9kmpYwJ0C3/vmAZOwYZxtKJDf6
 toAdgsIuGtdJMHfLPX6Xm2Jk400jraC9kqdiMH5xnkw6YbWCUFufxZ3bSO3gGerPFrUQ2HEh4
 ebGj1yrHFEt+mru2IwlmQguTBqAfkhO9hGbt4+5SrM98fjdAw+BjySoSbnuIp5Llz2Ls7FaMO
 I1zJtuJhkORxvT3m5qT9Uk62Fl9PecXxiiLLBdxSSI0RWNymRwmgCNKMMsVcdW88JPRtwSThA
 S4svsqdi3Ru6xRCiTQ/2D19+BsdBn6cOUAG90KQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1652750913-1593437267=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Mon, 29 Jun 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-06-24 14:46:28+0000, Johannes Schindelin via GitGitGadget <gitgi=
tgadget@gmail.com> wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In the context of many projects renaming their primary branch names aw=
ay
> > from `master`, Git wants to stop treating the `master` branch speciall=
y.
> >
> > Let's start with `git fmt-merge-msg`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> Hi Dscho,
>
> This change will also affect git-subtree test.

Good point. The patch looks good. I wonder whether we should also address
these:

Documentation/git-rebase.txt:*   Merge branch 'report-a-bug'
Documentation/git-rebase.txt:* | Merge branch 'refactor-button'
Documentation/git-switch.txt:HEAD is now at 9fc9555312 Merge branch 'cc/sh=
ared-index-permbits'
Documentation/howto/using-signed-tag-in-pull-request.txt: Merge tag 'frotz=
-for-xyzzy' of example.com:/git/froboz.git/
Documentation/howto/using-signed-tag-in-pull-request.txt:     Merge tag 'f=
rotz-for-xyzzy' of example.com:/git/froboz.git/
t/t7606-merge-custom.sh:*   (HEAD, master) Merge commit 'c3'

The first three matches are in manual pages, the next two in technical
documentation, and the last one in a comment in one of the test scripts.
So none of them are super critical, but maybe there are different
opinions?

Ciao,
Dscho

> We'll need this patch for subtree:
> ----------------8<-------------------
> From: =3D?UTF-8?q?=3DC4=3D90o=3DC3=3DA0n=3D20Tr=3DE1=3DBA=3DA7n=3D20C=3D=
C3=3DB4ng=3D20Danh?=3D
>  <congdanhqx@gmail.com>
> Date: Mon, 29 Jun 2020 22:56:37 +0700
> Subject: [PATCH] contrib: subtree: adjust test to change in fmt-merge-ms=
g
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> We're starting to stop treating `master' specially in fmt-merge-msg.
> Adjust the test to reflect that change.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gm=
ail.com>
> ---
>  contrib/subtree/t/t7900-subtree.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t790=
0-subtree.sh
> index 57ff4b25c1..53d7accf94 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -196,7 +196,8 @@ test_expect_success 'merge new subproj history into =
sub dir/ with --prefix' '
>  		cd "$subtree_test_count" &&
>  		git fetch ./"sub proj" master &&
>  		git subtree merge --prefix=3D"sub dir" FETCH_HEAD &&
> -		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-pars=
e FETCH_HEAD)'\''"
> +		check_equal "$(last_commit_message)" \
> +			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
>  	)
>  '
>
> @@ -273,7 +274,8 @@ test_expect_success 'merge new subproj history into =
subdir/ with a slash appende
>  		cd "$test_count" &&
>  		git fetch ./subproj master &&
>  		git subtree merge --prefix=3Dsubdir/ FETCH_HEAD &&
> -		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-pars=
e FETCH_HEAD)'\''"
> +		check_equal "$(last_commit_message)" \
> +			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
>  	)
>  '
>
> --
> 2.27.0.111.gc72c7da667
> Danh
>

--8323328-1652750913-1593437267=:56--
