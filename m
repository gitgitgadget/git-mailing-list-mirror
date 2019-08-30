Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C691C1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfH3Tsv (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:48:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:56133 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3Tsu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567194525;
        bh=SFKWjjsuZqjlruzwmN4pGzP04lpDDXXANaMNphFB5oA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VwkBq7bP/IBiZ4Vbeq2dUSRa0DnzIIQR6u8TWs0MbVZxP4zry7W7XiTZOHDmjAm57
         99XvlH4k6V+nW4DrgHpGwfVE1WLnnXXtDlQDaxyLGZqa9ojTay1yeuw0f+nLnJvoRW
         jEllzK4maZJi4SJshVPJ4/sBz28KRMnosc62Elr0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1hwKF83Bw7-00AoLk; Fri, 30
 Aug 2019 21:48:45 +0200
Date:   Fri, 30 Aug 2019 21:48:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "van den Berg, Kasper" <Kasper_vandenBerg@reyrey.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git range-diff <range1> <range2> throws Segmentation fault
In-Reply-To: <6802cf61dcbf438cb2e01cd390c57390@EML-MBX11-DAY.ad.reyrey.com>
Message-ID: <nycvar.QRO.7.76.6.1908302147490.46@tvgsbejvaqbjf.bet>
References: <6802cf61dcbf438cb2e01cd390c57390@EML-MBX11-DAY.ad.reyrey.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EyY5S/hRCKUn++jY+yVEoTVptjwfTuZRzDoc77PYSI/EW6b0wbk
 IxhuGDKuqZdXa4hQXU0RtdK1019QOXQzId6K0ENW6SPMkKlODf67JLxa5p2mUWa7hM/DN8D
 pjAIx7/Kp8wgr0hLvdeJdUNcXx/1PV95C4KsUOLHCbqCVyRiMuetSsJiVGnhxdUQziClTGP
 HlNT46b5wf+RTw0F5Eoqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gLCyXVBTbIk=:jHrfIRSGVImLumHbonl7GK
 iWSrqTaLJT6T4t4w5S0yGOnpCYhfTQOetJj2NtLlDRsb1hcG4ToCDjzvuAzR4DHOCKidmiOpB
 GBHLjsPT4602Qq1HCcv7paFEFsf6GbM36Jxi1xFGiNTNrxUj28GQsPe84rX05fXO8719HTN/r
 6pObxGJQ3apWbnGhisJQ2Vk+ihpepR0vpJ2Zj9wl1roHoM14kFoZfPQg2RCnVZwwGW9l9oD+8
 RDfUYG6JCzGjRFkUgXvCCl10WIkz4F/hFpDMP8ML4BNScUSc31bBGSq6tldC8ys1S5RwonBY5
 oEbeq5T5HAtsK5ZNOinmloSlzkHhnJ/RL9g9J8fx74c8LfI67HGrPH5CTk86/sOeq5vLQSjlk
 34/nnWoMWWM32P8hgEa2Q742oxfBkOlqXs9bG5F3Vl8uskI5vcpWpFgWvJjiUjm2i5pTZuB6P
 MPYQ4Ay9cMME12swranRICEWbsgDmWtNZ+1ehox7eIt7KiGjhjlRnYnjnurXOeNsPFQe4kzep
 SCvKeYKQm7sFQc4sWaTWAIBAVHbTDetgnKtIkJHzRuY4kQWMLY4pgH/wmSHYElLvJQ+FNPjpp
 2krDBZJUePPC4A+xMGyqVa4ItUjVrlJlkUvHpsaJDKtWlgXl02eIVg8sWX8pp6gLbYuOXabVc
 vVxdZXdvYpCM65A5aKqa9ZNXLPsseeLnRQga/2cV1O9EQbn/ZpNf+fkj0hcg8d67vC90HxjMc
 Za4xpZBlcJbdavoHt0Xnz7/zQoayNvEOt/j74rfA7gr3Pyk0dS9GvaNuUnIl6VBJbGaOcxXk7
 Sn6PvnLg2UzQHetE6O1x41dh64Cp+Ma1SrSWpsIMihX9w5Rp6uGCpCDGozAUq4TZaCeh0BrfK
 t8FyYY0rjRs3EjODw58ueFh3c3tCoDlqJFd7L8PA2QHupw7LsABSflPmw8PnCmVCZFkQVt2oc
 MgDWJnuCjNssJ7jdDUKYgfQYx/9u0mRn0X8bJjY1cC3wk8bvbs9C4daZtMZYwarnBniCpf5Jd
 plnK6zWvKPAjF8m9v+E4f9fP3bZKgnrxjJt6m2onxFo4KwUXg4jTecQrEdiyMc4WAG6N/fXRV
 aVMClYivnJkPybNCVQZ8n5sCxY8Af+t7SymQU2oWpfE2dli+ZJFqqNM6FbLCKQWdapEfKj/RJ
 73FZabD1imRHTB5jGyQkaMzao/iduAg/Vf4VUMu6fkOYUsHXvhUpGEvU4uNMcDsh5pKNo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kasper,

On Fri, 30 Aug 2019, van den Berg, Kasper wrote:

> `git range-diff <range1> <range2>` prints "segmentation fault" to the
> console and nothing else.  It happens in git version 2.23.0.windows.1
> and only occurs for some branches in my repository.

Maybe you can come up with a Minimal, Complete and Verifiable Example
(https://stackoverflow.com/help/mcve)?

Ciao,
Johannes
