Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2CD1F405
	for <e@80x24.org>; Fri, 10 Aug 2018 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeHJXeg (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:34:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:58169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeHJXeg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:34:36 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldcv0-1gF0nx1Z0U-00iobm; Fri, 10
 Aug 2018 23:02:59 +0200
Date:   Fri, 10 Aug 2018 23:03:00 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 10/21] range-diff: do not show "function names" in
 hunk headers
In-Reply-To: <20180729205202.GA9955@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1808102301500.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <0a52f887887cae039ee84b90cc05a6396242a744.1532210683.git.gitgitgadget@gmail.com> <20180729205202.GA9955@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4tVVPhkIBFAlhO83XOPd28s0OZX3sBtxN4kCWdaRokjqulLgTsY
 QYZfg8Po2DBUF/Y8YaVKtpu2NmuYclMNTxqcMOzij0kfKv2BjFm4p+2x2Q3SgTwlP7veuad
 hXRbid6QETQ5J3OvS5k6by8dHvgt2MQuKE5hFBE26J4GdWVfh4gYLMr8ZWpcT7GQm8BAD9y
 SouJ4IRB7koz7oENdFDzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DnvSC+d4KLc=:QsXEzu5KKGuGorgGR0kk64
 WYj3QLm00JDunShDXUXYL89giXzFYG7xkc3SWuPvQbdZPUbIrn+vFXXSMBp7HYE8MpZTGOUjO
 ndeT1iEWmTkTnIDCVFX0IHn2n/nVE4MDuTbJfo49F2PM7AbV89kxmoKTY/JSs+AOjcfoXgglA
 4r6SREFQF1ijghsyU3bvN1DvrwZIndgV6U1cHXWgFQejwXppFydLjY66S5nUj7MRlgneConJ/
 +/nj5vyIQbDBW2djO+Z8uQWKDXolMfcBiBxxIhcQhgQpgq4Q6wXmpkvtewA95NCxjNp0pq/bj
 lhEvsWCwf5lPVgCj1y9RUqG0twPRwFtI6ceTZarTJzvBnXUi4Lc6DRaQacEW/Sl1y8sKLhfQl
 98DA4rSp8BpVBr060Zc3lKwKjQR0fSquyZAvuNPO2xtMas4ASU2EYptwvrbVjaZtN7c/b7gmm
 VqgQQhnpMmwi2mNhFXZtyTBbE4jwUsrnfuwnl8KSXjz8rTST6HXnPF1f7BqPBji/CodUk8GVB
 yMdeAWwqBy8myhQAi1oBapPlISX0b+vYa9s+j2m69MBxYk00ayAQEhXITcY11JnDoUdPU7/dj
 crs32vibzEdL8iv3/QiEckeOuOCcjsljpWYrl08kGt6fsvfr6ZK6+gg3/p/lSCN9Ff8Ws6gn7
 4QdEFCH6WMwjKEYPeMfmyZ+iWKfxLaLyQ1PNFWA2MKxppj7Kmm9ZEx5O+hX37lVp2SLxUqelT
 a/BL4J7+VCZrahHAPJCVcNGRtvH9KyasE1b+RAs5INI84Hd9ZRpXXfJVj+IdUYdxlGyxV64x3
 6aIncdi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Sun, 29 Jul 2018, Thomas Gummerer wrote:

> On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > We are comparing complete, formatted commit messages with patches. There
> > are no function names here, so stop looking for them.
> 
> While there are no function names here, trying out range-diff without
> this patch applied, the headers were getting here do seem kind of
> useful:
> 
>     1: 92588fc6b6 ! 3: 43c9ef552c
>         @@ -8,8 +8,16 @@ diff --git a/read-cache.c b/read-cache.c
>     	[...]
> 
> The filename can be quite useful in this output.  I guess this is a
> bit brittle though, so I'm also happy to defer changing this to show
> something useful to the list of possible future enhancements
> (obviously doesn't necessarily have to be implemented by you at that
> point).

To be honest, I never thought about this, I just assumed that tbdiff had
good reasons to strip this.

I agree, though, that we (as in: you :-)) can look at this after
`range-diff` lands in `next`.

Ciao,
Dscho
