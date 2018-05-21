Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DAD01F51C
	for <e@80x24.org>; Mon, 21 May 2018 13:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeEUNmp (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 09:42:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:33015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeEUNml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 09:42:41 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdnN3-1fkGgc1tdN-00PgpA; Mon, 21
 May 2018 15:42:39 +0200
Date:   Mon, 21 May 2018 15:42:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] merge-recursive: fix numerous argument alignment
 issues
In-Reply-To: <20180519020700.2241-3-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211542160.77@tvgsbejvaqbjf.bet>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-3-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zVQxiDbxYMKQjyJPHvShZzgS4ganUl1LfYlgxQqeyj1ghizxzhw
 xDmgxw/O6FO6W9nvmX5phz3PYOoxbid1epFUaYHd605/dVrl3VuDQqEDnbQWp0XZf9jpfaH
 pY2wv9++tP1nLYRGTXG+pRltfmKFa65+zBvGbXbeJMJutYPEqezA730nilD6IfbbCF9yA/g
 jVV1Bjhga/6jnsWaNrOiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JZ71oQ09S1U=:PvOTdYmxM9Tf37KGKUpDX3
 UZJjWsFwylZX2YGwVBMCikf+oqsDNhuMB2kVjWkDAHFqWChWEGqJoRVjyd36ox04n4fsmVimM
 3a7sCTjDM4F/MZXeGSS9f0Y5KI23BGDipKsq67/OVZXwgtaJNoPLX+0k2TikGBdDDB6NJn/kr
 CRtFD1uAyHjFRhC9SpyvEV+UkJphgTz+JjFbNMB58xe40+cEwrFpwBJRkKFB4hDKPM+zHx2Iy
 43BhGReAV0QAIzCks9vD69vqLifIg+lcPZuICAQ0mnfF7cc9VkZC9Ec7jOquBGPzQB7Pbv3cL
 j2jHzmmFrhtkz28ILJBun6VhLehsinDYKsGowg2D2DQaPPmEvZasakKWF9ng7bGUjeWjLYajZ
 mrndx7I2de8RKML/6rksWeERRXJpGaKCRyTWZhV0+CD3E1G41gHtbVp7wClr9DOMqPJZbiCRX
 eyWEcOwhAcvl82PODOHc9fKSp6hBwlfFXrsaNr37Qt5ZIVDxiSm/WybSiShUhVn0V0mFDU7Kd
 1Vsfsc7YvK/6Fwx9xpWU7a/fxB1ilVXeBjxC2/XPIZqwoMptfn3NjqIRtWvJ3za4woNa3Ryb5
 qKBoyegPc5iU57gY7u8ChwfAQcdaZoF7rCaYlaCz99CLkulXLSiy76NQmUf63OhNluskfAEeB
 zQUs4VIwQ5c8LnIR4W8ZeSn/R8Q8rOvfl/KCUtuadeQZy0YebSMPOpzkKDGNQao+wvXu0yN0/
 Xehzu0egsRm5e1swTL9fhu3O4k0h9Xh5AZX3GKZ/xgMHhwOaQg7Y53KW+CRwZe4MxubzcSxCC
 JPSP4K4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 18 May 2018, Elijah Newren wrote:

> Various refactorings throughout the code have left lots of alignment
> issues that were driving me crazy; fix them.

I hope you did not do that manually. What is your code formatting tool of
choice?

The patch looks obviously good to me.

Ciao,
Dscho
