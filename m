Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C878E1F461
	for <e@80x24.org>; Tue, 14 May 2019 12:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfENMZP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:25:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:42681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfENMZP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557836710;
        bh=JWxp9rFX8qY5S2MfFZpRvXkgY1toj3EVzUXWoe/mIEw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PqJBPmju60buMaSXL2JRbAfC2Zt5/o0Y/38WovJYUGGxw4o65WjLHr0TCASa4ZYe6
         S2VmHK6qq1LKRiCUzJ3xexcmuW40T9fXjdb+7AFnrSfI9KGu/FoSdZGfnR+vBpjbna
         V/BctPuyFDBlGXm6TY+wxa85Yrq8BdvCZXPAnylA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1gttd22AyU-00qVpF; Tue, 14
 May 2019 14:25:10 +0200
Date:   Tue, 14 May 2019 14:24:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.22.0-rc0
In-Reply-To: <xmqqef52baih.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905141423360.44@tvgsbejvaqbjf.bet>
References: <xmqqef52baih.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:alFd+K0QtOkRHy+Tp4CnrEdOey+ktkCqSZyNPOqXLGuaokxWxzV
 hfc7LBHkSn4mBoDV2YyigC6ad3u40ljGzCAyhEWyRs9i4kVK1ev235YK3a7jQh0CIO6UcDv
 jdjy+srwCmUZpnOxbUDP6HEF7nju4FVb0oNfDsm0E/E8/IGDVE5dQzI3m620SgV9mWeaI4s
 r+fclyQh4DQDo7nSzS6sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PwR4qIBhMbQ=:8nCZ79h+XI3GrxFF2dWyWs
 sK7yTVLLqRMokeYwCKGVClyLTEo1RxhvRa/9jk7uskCDXUJk6GauJ8F7aJGRf6zdpcltcEV3b
 g2gJ7ShT9G1DPvBx0v//Y7L0GJq4bEM6GcLNPVk7+KR8pQzp2TtVs0ro3wlBBvT/tq8y1zBLS
 Z2Oik4bh/1qxrJ/3J0vnPqI6wAsNTHvJn0I2+B1hl9SjPDQI4jNPjZJ4gXNn8SZJ+tt3bDrdJ
 6Az9WfTachUFe60QwWEZv1ywwTB6t3OrKdFPpUVK2udgIAuJ7kikUSGEpop0WaTFKmUGVPG9W
 C+pEdfqChdhMym3FsemmZqdZa2Ml0LXNqSQIi+8TnwxDhztLrj/ugA58yRfnVYEUpFASPN2hF
 PQvnuZeFE+D33VkoqBemUhZVTRqOlAj7ayWPYb93Ug6aXaOXPyLHqoHTPPdVh627ANkk1vL2Z
 fxqbsXWehIsyC4CcB8IDoJcfQxgJR5t8fSQ0I17AoV0JLMZol0LnjAw0PlcHix0KOjb4+Iwqh
 tkLegnBCp8ZbeAo0ab8ziBo/ZbVjnoeEG+2Vtw/IQwhb6m+HeFjB7tzkDo6hr4c/RRfXaLVkB
 joAN2WA8o5D+RzdRVmctzxF3+MRiVaLL4VUrukkZr9+IUmhxPtAjN5lsG6RiympUYTeBqxNJ/
 fZyn2M4zDE+OOREZ5842eGZB05veo8qLxTgMMYO3i4HLORXC6R3qtVhs8GkZhc8VG7aFAx9HC
 uwEfDMu/+afs7VFaQVEa2iy9cYI1eX7Dff4z81vJMKz9QgyMwcsQnRCaFzAIRAxGcOSCy0SAm
 /zdWYE9Vw8FfPyvT/iROpRtfo/HtKYZHK3/GNgzck/1wKllWw+JnvJYo5fT6+CF639sx2o/oe
 wZDLb/0SuWtctgm7xq/uhoVOnsU8Xxuzc+2S9cPJUQTX+LHLfy2rCo4qknKHuwo8YEu/tnZoq
 PQiCdIWRJNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 14 May 2019, Junio C Hamano wrote:

>  * "git diff --no-index" may still want to access Git goodies like
>    --ext-diff and --textconv, but so far these have been ignored,
>    which has been corrected.
>    (merge 287ab28bfa jk/diff-no-index-initialize later to maint).

How about mentioning that `git diff --no-index` now implies `--ext-diff`,
and behaves more like non-`--no-index` in general?

(I know it surprised *me*...)

Ciao,
Dscho
