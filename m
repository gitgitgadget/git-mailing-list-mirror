Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001C31F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390867AbfAPNsK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:48:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:60705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390981AbfAPNsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:48:10 -0500
Received: from [10.49.55.26] ([95.208.58.177]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lxxrw-1hMPlx31bI-015Jj0; Wed, 16
 Jan 2019 14:48:05 +0100
Date:   Wed, 16 Jan 2019 14:47:49 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Be careful about left-over files from git add --edit
 runs
In-Reply-To: <xmqqef9dsqkh.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901161447150.41@tvgsbejvaqbjf.bet>
References: <pull.107.git.gitgitgadget@gmail.com> <xmqqef9dsqkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xqgRK+n2Q+h1EJF9yDsYGaU1BM+rTH35kYxvjTMrNXpxxTG+J8o
 2c/Cdy3ppPOG1fFKOO6SbIbVh3+F6SxSE5j4kFh9eX+RVzajfGVdsfig1CFWgeUiaUkrb4L
 ewpkerNLpzHBNyF+my/pRkJMk2DsOOImBvZEpS/3wnK430PQ5JeZUwGr0o5+lisgO2nIVSZ
 vRm7qVN168aNIufMxXXEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x8ZEfQV4BLQ=:T1IMMzm4LRUtqIhq7zroVS
 +esVHuaU9HRz95KrqYAz3NNvZ0knLbBUv4x8X2QxK78Ao9MsKic92YZsyCGMlz8Zw0Tx/y2VP
 xzboJaDWlDU9Bu7HGCqFWZ+XVDbb7giNZ/La0JzFF9ToPy2zBtWrDRrR5u3kCrwzqAcAo7FY6
 rlRT9ZfHU4H/hlveos6lUxoo2Y62tI7Y1qr3VdsT6Hr907PMiOsg1WBxCC2G7ok385RsTd4bb
 erp5loIaUfHqD+0gUzXtehXAIdr3E1JEB0Is0Kt9/AX97YBZDi7UHsMiUlLujMKs+xYYxdPqX
 F1mdc/2U9HODx3pHWzOfh4HB6Isdg9loHombH+YP4yiOamcyeJI9YK+N6w7EcjNasaRJKXZma
 5QTi9S3cwke16WXAVPlMA4OOSwPc5QbhcVoQ+ZqrIjLrE9IpsyWz0stTiLbS/7T1m0SB+dQKD
 7ESFXTVg9XcIbk+b9CqdqH5b8/AW0uWXkdcNi93BbZiCKnMLZj5CIIOKcBerHp9wxsUL68Ghj
 JOZPay06kOFHLI/SWHHrCTNRaAzYN79Ivrh+gLABY46X26dfO/BhsDl95DHpN9n8awO088O0l
 X1wmQ27q1YydVjNa4b8v2gb3gn96iVdGEJ0xjOgPw5z21LWFs04U8TjbtbtIJewlF7pK1//6x
 jxyitmNXXEXmtWuPqofX/plW1vmLvBkI6SGcpKgHEDnubaYksKBhq+tjfulRCS5V0aQvwxROZ
 mXgvDtiV8L5DlB3chIk5ahNIp11MjE/GGsE1nq6OTJmwz3MSxyBsvZxjGgaT93KoUfhg5xS1+
 Yc6uueZH0qcVwogdlRLS21Bmewl9yxNDhaH6q/TGuflG9jNmdDgFNNwLHf7nnFkEzive66QN8
 wXp31d2YReSMTu/MXhmhpuoaxkHeS/GRpN0Uk31EGP5wSIRLE0NRMlAxTXo855PQ4Bx1/cBjV
 ytY0Fe+QvqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 15 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> I didn't realize that "add -e" codepath was so old until today to
> check with "git blame" to see how old this bug was (it predates the
> transition from builtin-foo.c to builtin/foo.c); it seems that it
> was from day one of the feature.

Yes, I introduced that bug right from the start. On the good side: this is
*not* an off-by-one bug!

Ciao,
Dscho

> 
> >
> > Johannes Schindelin (1):
> >   add --edit: truncate the patch file
> >
> >  builtin/add.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > base-commit: ecbdaf0899161c067986e9d9d564586d4b045d62
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-107%2Fdscho%2Fadd-e-truncate-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-107/dscho/add-e-truncate-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/107
> 
