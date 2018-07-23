Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931931F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbeGWRcK (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:32:10 -0400
Received: from mout.web.de ([217.72.192.78]:56851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388147AbeGWRcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:32:10 -0400
Received: from [192.168.178.36] ([91.20.55.190]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ma2Pz-1fQwkM3Rb5-00Llr0; Mon, 23
 Jul 2018 18:30:05 +0200
Subject: Re: [PATCH 0/5] Misc Coccinelle-related improvements
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b405bbd5-9af5-6884-6582-9aa7f7db0878@web.de>
Date:   Mon, 23 Jul 2018 18:30:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723135100.24288-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l7LEnIPQ77n0lig2gAtySftDyp2rLqwK+sjVP4Qyj7NclYaHswy
 CybO8RdgsFyddmIRrZKwR8ZA+GCYz7WoiUTHj6Se2RSu3/KRwgRtDlNG3YCA11ZSM/zcLEb
 CTEQpAz/r8GJGtMbiGm2Wdji+oJws6Z0ej1dZ+d7IXjpw3FXRzSuMjPC05Nnwxsg6nd9CgN
 KBq3GjgOJdZuSL2hwWHlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:odgpMokJaxM=:TtCdZKOIsjuyCKwkrTLKjg
 RXl/SwFi04z2KgvhwTVmcTE/lrxQ1MeH6nSQDdRTpuojO7eE8mYjIL+B7g2PpJhqYYS/dH0xz
 bptaq7gJTacrqF6VhVU2QgKMaxMmZ7TTP/UYfsSo0Y0dKiG02D40LJj71gzS2CBYnWTPbcY3C
 d+rKf72RQza+qF2nEi23FqbquoCZhfIo88/YsGQCspILgMMV/v96ls/KdGFobWL2yHUaiZZTj
 0rbUQKpQO8yRlnNIG1NGtebwnnj73bxGZkvGplQLsdlKjy0j1GbYf8wB7Y6tBtyhxu8ZriuY7
 gV4Mo9UmTNGE4OBUApU7zP8BXwreB4VRp7yF5/CXUGcHXSV1if3nvKiVB+KhHUpVC7r7pfnHp
 aw2+ix5aF3ccmcbqoiFsI/9BnFWyPX6XgxGG/oDzFaviB0DB1joKSSR7mJpl0f+CLKAvyMMqt
 4K5PIT+/0cN4EIAxeFfMudqgQctDvYGtiIkwZSG7iuTxg6DKHBEoC9YLmO1TQ4uyaWhXxYDgW
 9B4Xg3JcyKnzuX5Zik1dI+fk+TI+Uook2werDFYX7mTxEV+1P588CAt88HCgKdVmto9TlDnSV
 hmw1X52ImRCe3rdL8t6JnrmejMNj3RohATDcgeD52fXcct+RwkwhtRQGM3qzufDlqqIx8V9/j
 0fpQy6Gx80P8FsLXP4iCUYk0g/WLfV9e7Km2p7Tu/R+n29BBwSyq1LHbFEO9n5MduLD3EksyU
 tKf2TTlTHDzIXBkIktqmJowi6MNNY5hM3cJlBB+bYQ1vM9J+KSt1aGA5E8xGdDlAKFhV9O1ij
 hFi16FK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.07.2018 um 15:50 schrieb SZEDER Gábor:
> Just a couple of minor Coccinelle-related improvements:
> 
>    - The first two patches are small cleanups.
> 
>    - The last three could make life perhaps just a tad bit easier for
>      devs running 'make coccicheck'.
> 
> 
> SZEDER Gábor (5):
>    coccinelle: mark the 'coccicheck' make target as .PHONY
>    coccinelle: use $(addsuffix) in 'coccicheck' make target
>    coccinelle: exclude sha1dc source files from static analysis
>    coccinelle: put sane filenames into output patches
>    coccinelle: extract dedicated make target to clean Coccinelle's
>      results

These patches look good to me.  Thanks a lot!

René
