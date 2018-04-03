Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24461F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeDCQax (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:30:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:42183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbeDCQav (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:30:51 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MN1j6-1fA0XC16Km-006fX7; Tue, 03 Apr 2018 18:30:42 +0200
Date:   Tue, 3 Apr 2018 18:30:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 00/15] Assorted fixes for `git config` (including the
 "empty sections" bug)
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <nycvar.QRO.7.76.6.1804031829400.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kFSvnI57rjh8xcPNjzzWnA51yj7NbpGKpCRlID7BG78Z2w61U43
 YAHhO5bF85saXfSfdVFzkwMxwzy9mVVOnH94HWPt3MuisJnHEwoBH2AtiOV2n7P0sB3vZdl
 d0MNS01U9EWMb7tRk+xg/5Eke0cRvQnpaLkNRmXsej6k38D4sPYFC7DEtz9QpfBEWj61ETa
 WxtCF8j2p50/hDzo7lP6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sVSpY5nvB3s=:pXS+By8LmLDqBSEoHP8sSC
 xlR4aK2/hFolhhwwuAaLiPQOaFy3NCWqJNayHpiUPw01rZiUzCSTu8DL4tnY+pnR4YEd7MPUV
 kcxYu1YxBXnyVXLnC77j7tzMn4MN9WScVbcAsS2kQ3/Vnq9q4baY+SZp3pD0G3bsBx1SBc5V7
 6gI/nbZfwhvXSoRsyJPYiMzYTDNsJeccSovZnXksGtJUf54EvmWS7QFHQWuScpq3u38ZVwSsz
 cu0vnQss9Ffobz03NzEOhnC5i5KPIeZayR9MbwY3p+jroOEGsJRlyuz4stN5UsWshiufnEiTr
 qhIIWkpU6NV62PMjao/iO6TCOErwDx8yo6eDnQ1cWrMsjAwoC7s4EO28Zi5UZyHBMzB2nFcti
 XEPKV5lXBT49wWGgJJWjQraRaTpEWCC3weDxPmHylSgsj7z5JOw7HO1SXk24qFNlDIPSfZJTn
 bwkG++T7iBiCLj43Kna2oMUu0c6xA185869+xAz3qZjPDyoAYBeL0/uMbLgm2Pl48W9s9QpPq
 +Al0uoJZKjHWN1HKSnfuUdjuCH404mFcbCcUagm4x4rOVppVOLUz4rrzqux+jsjQnkDvXCDvE
 YyO4MSUpjzskmZhA4mcnkzCs+iEl01Y9aPdeeZHP1eguAHCF8tNfHQ4Y/2mahEAnvHZi/oatI
 iv7Xl7OfFDcs10N+/gNmmfsZLKogvUzs/A3HSeLHWL/EurDCiGvbWX17DxF3NKbfiiJJ7XNQE
 nM3QBtxijkvvKhHGH66vK02/6nv1yRKhs0BjU4P4FOsnxlGOPMlXcxIUp1VpMqWroKHbWT0c2
 zd7+alwkxR/p6V4hOul2zZN+XjT4IbPT+N8gq8+gf04vqfORAcgHPmgitwGZRa7/FetZBEt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

On Tue, 3 Apr 2018, Johannes Schindelin wrote:

> Johannes Schindelin (15):
>   git_config_set: fix off-by-two
>   t1300: rename it to reflect that `repo-config` was deprecated
>   t1300: demonstrate that --replace-all can "invent" newlines
>   config --replace-all: avoid extra line breaks
>   t1300: avoid relying on a bug
>   t1300: remove unreasonable expectation from TODO
>   t1300: `--unset-all` can leave an empty section behind (bug)
>   config: introduce an optional event stream while parsing
>   config: avoid using the global variable `store`
>   config_set_store: rename some fields for consistency
>   git_config_set: do not use a state machine
>   git_config_set: make use of the config parser's event stream
>   git config --unset: remove empty sections (in the common case)
>   git_config_set: reuse empty sections
>   TODOs

Please note that the `TODOs` commit is a left-over of my internal
book-keeping, and its diff is actually empty. Hence `format-patch` does
not even generate a mail for it, so there is no [PATCH v2 15/15].

Thanks,
Dscho
