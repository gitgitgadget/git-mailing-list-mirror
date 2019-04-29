Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B891F453
	for <e@80x24.org>; Mon, 29 Apr 2019 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfD2U5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 16:57:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:51831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfD2U5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 16:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556571465;
        bh=QUxC8HnPSQ0tHAvu1yQBeXNHF/fd9FtTJkZ1lz1M2v0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eTcW+z6QwJW+g6LPCWnINOa+3YVuioLl+UIYI/P9kjyYzMasfvCokx7la3GR4Gzwi
         4RhYPP6o06mGh6Kgdf89UoGMSHNWNBmemit3znvwiCfH6/xbmsrJ2IAQag48Hikwof
         qK0a6SL/04RKh11RBmarW67C72dMJdx251sJ6U8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO6C-1h1XrE3YgS-00orsD; Mon, 29
 Apr 2019 22:57:45 +0200
Date:   Mon, 29 Apr 2019 16:57:48 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Nickolai Belakovski <nbelakovski@gmail.com>
cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH v10 0/3]
In-Reply-To: <20190429051944.77164-1-nbelakovski@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291656550.45@tvgsbejvaqbjf.bet>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com> <20190429051944.77164-1-nbelakovski@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kb+2AdWegBpDTb7OtuKfMFj0RuCykqDlUMMbN3PYxBh5TvcBrUb
 84cT0kNn4mOWR3yMRqDnJfJX8U1UelTRoYiuyqV3bTVpnq6QEzeYiSD8BufboX6dMF03ErL
 J8f49csWHCjXiJcvzbdasDGKRdXKM5ZmC5DKphRPwFaUCj3UNGGj7qgZBw+g6LcusfQ/JgZ
 ZwflkQo9iPEWphnDYntVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z+8WV3rSSHs=:mKmg0/Vsi0DS0gwKAU6NFm
 BPtqYNa7I/3u2oynp2fZ6H4aDBVOi30cul5Nm1Aeba8ZLNmu30fCeavWKn3ov9AUduwUQLJ6v
 l+Dj1ij806vnX8elsBVcTro4DKqrx67wx/vpjhRePmLqzv8/qLNSnk1GFf9UxOB6Y7inalY3k
 AfuyVEj7TF7PVAI5tVMkhqTq+iigUL8OJZQlgOA3zYndXBLuIfeoBGDEyaRs3fTJXxROIYs9/
 oLI6lTL/k7u4PVzRIHwpCULotD/SU8P+6UFtZbSlmWTptHiISXzryvMMddVlCLOXAw87k64Ev
 3NusTIzemtA5CeZzj/xrGjxvo5/5Clv5FoCB4sYY+UMMck3K2AOqS05JWV4TwIDM8Go/e9S/U
 kSLvxXtZoFbNYYpzI2VJ09/02YOYIFg8Vu6elsOimwMO2AKOzjP2JsOOSpJo+T7XuFuhXRa0K
 ES1az9gloQ3dZGFc9NG5c/SPReBIqCzoSV8AEhgcccdCfls6m/ka77EGV/T/yrz6NM6PDR15e
 0V5JAAD8Zg8LJb0VkNJEHd0Ovqt84VGTImvfvBp2SUIqoh+W5oeOHOCWTx3R97bmaqpL13Nk9
 lS/A0X1wbEFkE0J4FARqWaOt7wDOfAXYj9lo0TkOEnXQlB2sGZAQcz8AZG1xEOIr8fIysb5oX
 jD5GqPb78S3bZc5F10u2wta3tWhx3F9ImbWF8+kGNnvbs2Vx8reThEK9cBKEpOw/V1MoC20ee
 RC78ZAwwxSC6BAEsGd1OjENEBd/ppDfu9Qc0sMyS/YkwW3+eY/R9e+rse0aTCQKxCBiT2Gb06
 IrSK2GJYrEGgzvssYta8C3HtL+PEdwXO84SAVfUHh2rSJmt9mg97Q763nrMwrh8NeZRnMM7xE
 LJt0zsezNKLQnmoXiVLq6YKMIm/inOLhF4qLkxdp+nGzEeMuAITUIhsS1Iz9ux/uq0/0DcXc4
 cXr+eXoqURg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

am I the only person who is puzzled every time this patch series with a
completely empty subject and without any further explanation about the
intent in the mail body is sent?

Ciao,
Johannes


On Sun, 28 Apr 2019, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
>
> Added test_i18ncmp per instructions from Szeder
>
> Is there some other part of the infrastructure that's testing for this? =
Because it did not fail in any of my Travis CI builds.
>
> Travis CI results: https://travis-ci.org/nbelakovski/git/builds/52580121=
0
>
> Nickolai Belakovski (3):
>   ref-filter: add worktreepath atom
>   branch: update output to include worktree info
>   branch: add worktree info on verbose output
>
>  Documentation/git-branch.txt       | 12 ++++--
>  Documentation/git-for-each-ref.txt |  5 +++
>  builtin/branch.c                   | 16 ++++++--
>  ref-filter.c                       | 78 +++++++++++++++++++++++++++++++=
+++++++
>  t/t3200-branch.sh                  | 16 +++++---
>  t/t3203-branch-output.sh           | 43 ++++++++++++++++++++-
>  t/t6302-for-each-ref-filter.sh     | 13 +++++++
>  7 files changed, 168 insertions(+), 15 deletions(-)
>
> --
> 2.14.2
>
>
