Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1B8A20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 12:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeLMMvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 07:51:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:34657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbeLMMvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 07:51:17 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBin-1hGxo318VB-00jXcZ; Thu, 13
 Dec 2018 13:51:10 +0100
Date:   Thu, 13 Dec 2018 13:50:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: Preparing for 2.20.1 brown-paper-bag maintenance release
In-Reply-To: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1812131337270.43@tvgsbejvaqbjf.bet>
References: <xmqq4lbiey7s.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6Fne9wI9l/COpbrEbPuQy9bnqs1S9jw8fTb0bJMvNLPK0NraghT
 M//7dTZOdnU/WDeiXXvVCRSAGceeD4fLC1+STOhJb4/R/Em9Wxk1CHxdsa4Y7tPTjrLTY2F
 T2eafJJClPtdXWpWTu0yQNpJEU4egMxTr7Q+GMwzyj2kignk4m+HrdQPHdFAGfITtUkjWs3
 8bZS1PrEnWOSWq8i1aiwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pnyj6fxmv+E=:1WPAQUxLrjq39rZBGU251Y
 R6PcOGEtDoJH76IxGzgPB1FTps6aTZr7aObRMysqCeGIziHU9nyzpfZxosDFDfNX9gygCGZKT
 7sArNeud156HDw/lktq9hC2e6b9VGfHylieyLi5klO8Q2hP4VwBogRO9+XI4PEtdNIjDenEm8
 gqVrbfeq/C+/8jJxJrY/QmsBGIDBc8MBedTpoW8OXUGxaKgDVfDstMQ4ak2SEL/vVe8Wj4bW9
 p8DONHa12hsaFawOb0FDI1u8aOg2dAH1OPAtu5wKZQFta9tP49WXTQiVslKMZSg8oYGb02yAw
 t8Ur6qjhfM/xkKzpM21a+YF2t50ZNUWMMMDyoC/31tH8Sa+ru4Q+7+09X8nfiJNx2A+l/gVle
 Mw3k+jDMAmJ7TGorYepsnCrapjhocztaYhAvQXqA8uIOvGbPh7/pI43jrLQ0yflOqL7tsyArD
 ZSswrekn8jbhg87APNyN9QSeGZ8/hAPEvN+dKqyvlc/mUV6aRO33u/IpOkvjYLtGZogQw/rX2
 RXhAYdm24Rad58lv8vt+snNqi/DX9OSL1LBFMJu4+xyaHhGfgrDPfEV7uBU1PO6MKZmgy331O
 WuOscOsIMQ6DQ3X0ox2vfsrIT1Y0l5r/v5difSQuKUXESpyTsK8pWR1OeSNgJgDndZJVZhF6g
 jJc249XP7w+PMkEHDVZcCOkcTo9S9DYLK14bYFA+Xoj3mkcYt+Fg3dYigw/KOSLhyrzeA4+Ss
 KPIOZRHv98pJa1qOrrCdVosB78l5jUpwqc1dHJ+2L67NGmo1GWiwIw9Z9lBDtfhikIS/xn/F+
 R8PVa4i7XoDRLtzvy9xhKaq0N7TEly8R/bZe9xgSRpCCZuhHAuv/cLbhLLUcMY72h8JDbkpCV
 oiDkwHaDkUeSKUXyEL9ydviVpE1buS5snw1C3zB6/l3YXAkJVXJK6MYVtamxxOma/uQSCH8uT
 BtkRM2SFEfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Dec 2018, Junio C Hamano wrote:

> * ds/hash-independent-tests-fix (2018-12-12) 1 commit
>  - .gitattributes: ensure t/oid-info/* has eol=lf
> 
>  Test portability fix.
>
> [...]
>
> * js/mailinfo-format-flowed-fix (2018-12-13) 1 commit
>  - t4256: mark support files as LF-only
> 
>  Test portability fix.

We found one more issue that I'd like to get fixed while we're at it: 
one test case in t9902 now needs the PERL prerequisite.

Let me coordinate with Stolee who will send this.

Ciao,
Dscho
