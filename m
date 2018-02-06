Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8661F576
	for <e@80x24.org>; Tue,  6 Feb 2018 09:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeBFJrk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 04:47:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:58057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeBFJri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 04:47:38 -0500
Received: from minint-tb4pce7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MbOrg-1eSQw82D0W-00IkWz; Tue, 06 Feb 2018 10:47:36 +0100
Date:   Tue, 6 Feb 2018 10:47:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Bulat Musin <mbulatka@yandex.ru>
cc:     git@vger.kernel.org
Subject: Re: [bug report]: error doing_rebase
In-Reply-To: <d4246fa9-5ca2-33c9-d7b6-07adfd9b55a6@yandex.ru>
Message-ID: <nycvar.QRO.7.76.6.1802061045160.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <d4246fa9-5ca2-33c9-d7b6-07adfd9b55a6@yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yFOZgClkqdRhAuKCDFSK5uTf+S6N9mnx+RKVfeCidsdq1oqOa+O
 8PEaUTfFTKZ91nwxFJymdgj5dmE2R85U5vyEt7QYUSMIgXB+OrlK8PB2TYXA0nD7Zd2KxEZ
 HxG8v8WsE7FtRtKlI76EFJwPYiAIGmZKnThQriVAa4Bxr6pIcUt9/kHQ2Qs5a0b8yc53SpJ
 /nkC1se6V9xTgtM6tDxug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:46IWIAUQ5fw=:rfvG/bDRpog/iMpjb4LlS0
 pNK7d5IWKErfUpSGiT3M7ls+Vm0HzSvS129N0CAtVztcj1KckVl7urCohvyW+fs5ELUiOfl8H
 cd4EXEt0+l3l5a5G9GbqMbKwBYIuB90psVXMh9bZKu6F9LB+UkgNGMYX/wiXAh5wW3Q/lLy1d
 qRZH0A0hlwfkjfhf1lQy1ShMf5erOPJzMxq/1AuUmgWiKbV/wWtfu3Te9NV9kLUc+46sT1Icp
 jl1ZIqawW3Kunse/jCSdj8VLupnpui0F61XFR49rU/JQC1KW8RElV9KBoga1c37Fs45mK7LrN
 1qHnxhnGRvOeDBjEMjGRsZchy4z7kaNnGyqMGRmQ3vlRHTon0wiBzL+AdUBJB/GG7k4rcDqUZ
 laxZTHg0umKpjyGf4j/3tHqikiTXl2KLbjKrvsgmvmPYAeH5f8CnYHFmf/QXxF21HF22k+8HQ
 robygVzAk/LY6eTzNPUdSca+B9d3ALOy4QtMasYPGa+9cOAY+uQsG+cXCj8c14t/oxR8Ikkjr
 OIX9H4UnbZYmCbThu3dgLWqr3zbsI9OQs4J2Hruz/ex6HbcToj/PoOcCVSRpTqF1D1FVSDr2N
 ViVco0IO5fiMq7I6HoOJ1P2F6aqQ2dHMJsmS/j/gi11bDysjfqgSx/cBitP+WUHLs2+WrTwVZ
 JT+kMPLmY99LSX5rQtgOkZRxrj7beGAyG7DkxNSD2gmfjpTCFXJwq5mC+yL9vKyrvV9nGC3Sh
 vLb+nPRTC02mAESpOpRptT6gY+6QM/1uRZXZQJEqWvhsP1OPrZxQC/651B1RR8FPb1YfaNELC
 9bzYMP84vjHMKbcMz3d3KuoRXV/7i2YxThvTAMhuAAm4IENKPs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 5 Feb 2018, Bulat Musin wrote:

> Now there are 3 sequential commits, I want to squash them into 1:
> 
> git rebase -i HEAD~2
> 
> In editor I changed all "pick" to "squash", saved file, I got:
> 
> error: cannot 'squash' without a previous commit

You cannot start with a squash. You have to pick the first one, then
squash the second into the first.

> However, 2.14.1 from Ubuntu's repo does the job - squashes 3 commits into 1.

It may be careless enough to do that, however, it might now have modified
the *wrong* commit, i.e. squashed the two patches *into HEAD~2*.

Please verify that your HEAD~2 is still intact and part of the rebased
history, otherwise you will have a problem.

Ciao,
Johannes
