Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FAC1F42D
	for <e@80x24.org>; Fri, 25 May 2018 12:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEYMbS (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 08:31:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:51081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751235AbeEYMbS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 08:31:18 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MU0U9-1fmy6S05Q1-00QkEm; Fri, 25
 May 2018 14:31:13 +0200
Date:   Fri, 25 May 2018 14:31:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/empty-config-section-fix, was Re: What's cooking in git.git (May
 2018, #03; Wed, 23)
In-Reply-To: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805251430420.77@tvgsbejvaqbjf.bet>
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oC5Xi4LK8JECi2/QHTf85lkgGW7LsGfN+eGZiJj3+xNgFibij2M
 Snau1N6XtwUJII6OvZUiQxWmU10BhEVgSMewimhjM+Xpd+mIr7TUWc5XhvSjQ2LX/70jYJU
 /ch6d4AEqytNMCfobl1Vgjz/0gWok1goZYCPaH+28btn8m4TzOeBQ1padZ6f2Fv40x9sIBK
 Sd/lhD3dg6fq8eec5hNbA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:90CvkBOUdvs=:pH8GcjPVPDHHqHDcGtCeS/
 I7kUkf00zxL/v4QEsgEQrQdm16qtbAl7P+jg1XyakU1sEIAeHbY3auNOHKFej9RSDAE5xi/QV
 tmAh+Ajo17dP8vsdh2mmwtDvPzyTUF4y/myqL83Wn8rcJ5FII7XkCjuqjagDUq4RpmSUhJ/nS
 3lwObLtub1AyqHUBf5vVAHm9Qtdla3OHlcBuyb3z99adFOMISSmvMGuk4pAdb8hAbhalo4zH5
 Nklw/qo1IW90b3eJCpxTZiGhbXOGfEZPJiHOfA8y/C27ZTgS7c2GZMvQ9lXTa8CYJM8jWcPq3
 jEUwq6XbDSN5ZlYJ6FPBWkYMECvDN+saLLcwOPamrPRfEvMBg40zUcE2EtLYGK1oIj3kSqJeZ
 E11hXocZrMarem6MLsBHvNorhh0Thclec2Jy7F7nXAui9noSzhUf2T1suZMlb/huy9G1uMq39
 fG/Zx2HHjUl1yAA5ypx2/GFScsRoz7GJ3wl9ffLFFUxMk2xJhOVhDmIHiGR1s/pbWcyfA+VVW
 ZjAq3b3JuSJ7VfES8IJzhblrqrB+v2XKU7ClYAy+yw9kf3fcpDAR4mnDdtgtecsnZiYx7nn0y
 docfZfcVKXFT9kkXJfnWGFqsg6Gb65pc8Dz/6x5GHh+GYnJi9jG+ZiWPKW9GjdhVT/3+eAXn1
 KbyIbqcPDCWNzbdDj6EAq1NimDrRBrzbC2jojSMbZR1sOgg6YMTSsB6L625+c6/mrEDoDjG+f
 SHAjmE+bpPYcZQj9WtCLEtNR3WzPKc4jF+cCvaA/GwamZatPMacv8y+J03irx4k6OnOt5BHNB
 fQEB3Wj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 24 May 2018, Junio C Hamano wrote:

> * js/empty-config-section-fix (2018-05-18) 1 commit
>  - config: a user-provided invalid section is not a BUG
> 
>  Error codepath fix.
> 
>  Will merge to 'next'.

As a hotfix, maybe we can fast-track it to master?

Thanks,
Dscho
