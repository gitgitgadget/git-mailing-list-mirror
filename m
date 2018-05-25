Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7AA11F51C
	for <e@80x24.org>; Fri, 25 May 2018 09:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966346AbeEYJv2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 05:51:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:53481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966379AbeEYJv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 05:51:26 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1fbkr81mAZ-00JdY6; Fri, 25
 May 2018 11:51:21 +0200
Date:   Fri, 25 May 2018 11:51:20 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>
Subject: Re: [GSoC][PATCH v3 0/4] rebase: split rebase -p from rebase -i
In-Reply-To: <20180524114958.26521-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805251150040.77@tvgsbejvaqbjf.bet>
References: <20180522211625.23893-1-alban.gruin@gmail.com> <20180524114958.26521-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UXUT+nOwT6PtQOL0h4bxF90M862XyBtOVASyMopjxVI1Z9ztGKO
 DcJbycbRH0z7usBcQsXtCiuHBzMmxBeVB6tRMRQ2bHXY9TjiR3cNlW/hRrQbjfRvcf7H6Bc
 H29E77R6cZaXLx9oFBL0QeTbNbMHVAPSnAasiwdy5QPTO047gMebUfDhn7CQx+c/fNmTVne
 V5QyUv8uFxDC1z954T1pg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FsS0ApH+gQk=:AcZUWd9lonf8zkmRUzCsl4
 CTrijw/lKXOGFNQk+AJwGvt6zoj9l9MTc0ySyqRBRH+v45PGlJu539PVkKakXcCwjskRn2VEi
 qkZbpCg3JIVX3/rtbB83XxnGKHAsu6CDZiHxqPKNsjEN9+y0mT1Q69eypkyPdQTCJIJmxZrge
 Q1hXSOlrwAZfAzScAGD8tVLnNsy8lnpUThVDbuI0LSBYsMXVP3BnuknC4QrdnwkQfq/GEtNC9
 PLMdpasxu0YMoyEK9aLiK9XDag7P/9Ko7ZJl9b1BhuYEOjBJhnbuTwAm+fPycQqgXiennguhJ
 UUwoKy7DTrFcpf0MbSaL+wGy0uKjAYvuis4YvlGIGrWNcNdrSsT29fJhnwogQDJio07c7afv7
 br+leCQuglqvd8mMgxdb8vK9yIEl3IqL2vfJbFlXCDqgripl6No3kKDt15Kkvw8AMJoFVcei3
 ABClskBBans9xcIlXVeZbbhXaM3poAm0cMGOD5vw+6CCWMVpWO+eok5iNb4spYVbugVldeKVG
 vs7MbXQ6tq5ZFtgK6ODnbTAwTOrPHPmQS0AZMFa5DtkAJWRVXo2OcCaMu80pu9Ygxfkday6xU
 41OgxWl4GTzqZrm1jQbJBTJ8YXx75V6jfvi16HgUKTaH1aj/sTSJDT6xTDyX9tHNYP7c4W/4M
 PAHG0875McOaXpsSDlro5KKuuWvtZZktknAbCeRp8n/EKmcQ3j+5sfmuhAxjecZ8bgnDaGsYU
 GNvRqjwnXsCsfL6YNYOaSGuu82L/6s7TePk0/ziFWScGCcvzjFPp4mahCMFoPWOWVFc0HR/H6
 k2WKBD7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Thu, 24 May 2018, Alban Gruin wrote:

> This splits the `rebase --preserve-merges` functionnality from
> git-rebase--interactive.sh. All the dead code left by the duplication of
> git-rebase--interactive.sh is also removed. This will make it easier to rewrite
> this script in C.
> 
> This patch series is based of js/sequencer-and-root-commits.

Since you got such copious feedback, I'll just stick to reviewing on
GitHub if you don't mind.

I added a couple of suggestions there.

Ciao,
Dscho
