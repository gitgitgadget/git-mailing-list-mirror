Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C161F516
	for <e@80x24.org>; Thu, 21 Jun 2018 08:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeFUIjX (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 04:39:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:35193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeFUIi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 04:38:59 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRocn-1fc9TD1upt-00SsD0; Thu, 21
 Jun 2018 10:38:54 +0200
Date:   Thu, 21 Jun 2018 10:39:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v2 0/3] rebase -i: rewrite reflog operations in C
In-Reply-To: <20180619154421.14999-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806211031070.11870@tvgsbejvaqbjf.bet>
References: <20180618131844.13408-1-alban.gruin@gmail.com> <20180619154421.14999-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4S5+JFUB/kN30Nc2FV/hJGUSqaqcM+gDRrhNdxVWQB/8pFnUSwA
 YprNjyHVptPihnffa5TmnDy5h1m2yzUgcLMemCJx8OjtI3gzDQIC8TyPc3j2xLj1WqnMx81
 nmvrZNLuBuivLr0V0acHnxMJIOoIbVvewACYhNbtW8ExzQZvZ4Hxtxk2vl9oC5b1sk6A8je
 VE79Pd3U+AaATYrIvuwWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gdgrf5zyhjg=:+RYQYOQAfKr8pfXUwPTxaH
 +f0rSCRVeBhYDMtYyFBTg8h3cI/61yaBEnag35s5+kgcbDAWw7XZTLmyBR2/gXLvVbz16/UVN
 10y3Ku3C8e3tQNU8ev9HMUvpk3LG7O4rgM9Pbf28tIvX5h+Su8sXB14asFaTR8Hu0q9aWSuQm
 FOPb6xQDAHn62hBV5KI6jwqrSXYcyY0fgvSXRtBtHn2HDxM/Z+eHdRD4/AzAOKaJItSyagVt6
 vv/YEmAwe0Bvz/fiH9SWOrI7h4CcCMA6KstdoSuOF9AOs9MxvNnfDUIBpgzqzIIuEzEOHZ5xE
 jB2LJuuKrO80HV4wIQ2ZMyVtScYdAl1/9Wy8no/uxB1HWVK+WKFUU11uzLnHyqEXqFZbLeY9A
 /C8dqI3L5IfrS+RE/xX8/qUstEhbowNi5glBHPWcvw95buBVW02Ig6V268E1+jCjirkmTNSsX
 RkBuBs911c8lbK4KDodhyOOarIgdYC1UEgFYHDHaCsBf0XwIrSW12DWO3EOTojiuhFox/LqAH
 YYK3Zdx5gHhyO0mA467xugwdr5tOvVwt6naauxOb6KLvLt6pH8KkaOSsIa3uP3mbkOKORKP2B
 8MT0W+QFAbtbievsJTrAZJ6OzUGM/blQ0cy7I4dVxdfdnpRwy19EF6U6mM6tdWFraa47xVq6l
 J46H3wNB9dLLcYzVHw/X+UxfSFkG/e7YidIuohGrfQFe75WPt42Ydxw4tFWlFenpgaHlfaflH
 SYBG/RxtZqRSlsaY4yDgiug+e+ZsF2xX0ySiEm8IZNyF0To7MWyIWrj2KchdhIfPJJR7HrBCE
 af0cahB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 19 Jun 2018, Alban Gruin wrote:

> -- 
> 2.16.4

You might want to update ;-)

https://github.com/git-for-windows/git/wiki/FAQ#should-i-upgrade-to-a-newer-git-for-windows-version

Ciao,
Johannes
