Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3554020248
	for <e@80x24.org>; Wed,  6 Mar 2019 14:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfCFOXJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 09:23:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:42171 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCFOXI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 09:23:08 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhiTL-1gecqc489b-00MvNL; Wed, 06
 Mar 2019 15:23:02 +0100
Date:   Wed, 6 Mar 2019 15:23:01 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Woody Woodman <wwoodyy1@gmail.com>
cc:     gitster@pobox.com, adam@dinwoodie.org, dturner@twitter.com,
        dturner@twopensource.com, git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional
 removals
In-Reply-To: <E996067C-E91F-4333-B996-D9AD9DD077C3@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903061522150.41@tvgsbejvaqbjf.bet>
References: <E996067C-E91F-4333-B996-D9AD9DD077C3@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wofe1SGScYd6tag/hFRcoKaSxjLTanfD3ZSPyEIDn/u5+5bDL+g
 muARptCrCOdDENE4QKh3Xg4JkqEy2nhGZl1dhsPnYJbTnyB4/6XcQ3aDdGelYvy2rPeU9xS
 1820QY/64nfuR9623Mp/H1+8rcuAsB9jB+QtVEw4swHNmlYAA/NP/0OSnvtsDwqX2XfNzgn
 ww+CQwgkqsljdkp0p8veQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mDwim+CP5pM=:dyRX8pDYYj6EnuBPCg05o3
 vMcn5UsbBV4vXp5PktSQ0/SVoXaWbd/cQgIMnETHEcjrfjh2DyVLZ6syaAkTFnnkIVgTaOjvb
 a+7u3fou7gWoc2xaVfr6M7JyXF2hjwr6SNdxgvoRuxTfjl4qyQlwae6nJv/km/omb/1tB/Zd3
 bHNdQlvRpswmIQyf3XAUVRbcYXOm0Y4LODKniAppk3daW5kXWhNQqtl8bj6dM4pKVc/pg0wpn
 Rn4S86em8Zl9vxY8NY5dcNsZ3lzgxi2Y5iQytAOl+YncsLqpTtEsCt6cVLvwWqqtpPCPpTmEu
 fX6QMGBKjLpRtjaC3zycJR32tdN6jev9JGmi8Xt9VKi+SKAYCbjKXTA6be7M/LjSOS0P09VYi
 eOiHiTylHuVCYhXFbBSDuN31uVsxZyg5nlC/LEovRUS1AgVxMQBtrLH9NsJP243LT5I5DUfSa
 li4lSO56HRn5RhbmvklB4O0m7nrkjK/SGhyUXXqAYgB2PZY+Bvl/CHDRYdpw/JUPJtS9vRuth
 THpKb6V64gPBk5FW8hZPcocVQjsEuqTgfJsUBOjg5kO+TbtnqOU3cR9j8KwqRFp/7CF/NFekR
 UZIXcIXU0EwLmpzzGX5tRe138XfFyN1Uq2qQqdO2CAdKvqFiYYZByysA0+YNyeCRuauqR0naM
 gPLz1WbXcefSJJtooO/6/iWIvN0FGZEzJQ3KVFZHIyOJzaNVaDlvXrVqyqZwQJSfVoMnfherE
 fJeIs5vEZOuXgljwVeOcn5z+gsxAuMUxC/G0H/i+a31B+7SLk+9Y0FWAe2ycjRtLRuOmJQMXs
 3zwZ9WXbsjXLnl8tqaS071487Trd+uxcT+VEYE4x6yo60Kiem215uFFXdVqHTzzuW8PzQuWgo
 aOlgOV8fFdUsaGhTJXHO2bPVF+doJ0TRCke9NakfcP3unMG2vq4sYbjnAYYSbNxKgbRKmEb8x
 XcjOSe6Q3QA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Woody,

On Mon, 4 Mar 2019, Woody Woodman wrote:

> 
> 

Details, please.

> Sent from my iPhone

Not sent from my iPhone, as it would really be cumbersome to type an
informative, useful bug report on a phone, even the best of them.

Ciao,
Johannes
