Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14741F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeEDHSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:18:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:42585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeEDHSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:18:49 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M82zV-1eSbED1LAP-00vdru; Fri, 04
 May 2018 09:18:44 +0200
Date:   Fri, 4 May 2018 09:18:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
In-Reply-To: <xmqq6044t3x8.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1805040918250.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de> <xmqq6044t3x8.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1lOYYsZPx55Tmvd3ew5AipWneFw/MOpR+gMPEbqTc7be3+sHbiB
 EdneDe029dw11KJ8QdXSfZbcKBJE/FvBW5DXvIou9nffOLAiyZz7JB588wnULFt9B0aiCHU
 GRF7HD4LedTodlQq2aXZ10NPUxtlkj4fnlAZ++R9q8zAxTJ4qgq2bAyebD/tUkS0zumdaJN
 nqQezs9cYsaDJj1Dc0b5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YsZa3vgC1tg=:YaussDN/ApWv3McF5kADdx
 qdb1P+gEOTYdGe57frbvFtvPLnZEij7bp1hSMQi2fkTpe1IflZN1RxR1d97KpLo9ZBoSYUz14
 BV1bdux4D+U7osALA4uiy5NuhuqESRWq0RrtiKC1+3qJ0kBxzXV+CLB+Pk4W8NxqEKcfuXem1
 pXUJJUT/zyT9cHE+3lo55vEsg5g/d52xhNCluNX5Aj44kUr9dmxOJKvXSq5WJ5887Po2utsc5
 OAFfHLi0BwO5FBtzpU57KOC88T//2nFjNl0KDfXznYrVH2ptX38qNsSGvtTmwss+lstxPjfNZ
 EgxEdeSnAC6ozRe9lobltgRMOodRe2vybAk7fsdgtCUEY4thjlqQKjImaStalAOV7Ql59tJFl
 0MyymBruDPfbDN4cZsx824YA42f1yCIyX9LsX6aOcffDl0zviJ6WAqypKQmjyoL+FXf4QYwjz
 3AQs0lie8LvZ3WvzhLGTqGvhNNt6ICdhd4z9kmyE3Ngf5f5/U8bdbM3jLhsamtKl7mhv2M7xA
 LKjVCFoCkCPSe91U+3aZumqmldk/I0OfER+o6LylJ7BxuiiQuAjyNTjdevPwa+0vIxk1/vo+m
 NhkeitVGAQ5DpNU+j6ePww6pHe2Yp2PaiVSl/+o6zgBQn/6w6pZEmA1Kn+UFcTOd+gnf+WqWq
 yf5bVmrKGg/JG1etNc/rSf13UXgkrQ+JNOayNNC6FM/T1Kc+WC9tEZMpUperxHPg3V+pdeLIS
 dMhp3gFdnwLnTFDGAzJDoOlL/7zdMdcf4+ixOwz4zzoGECgHs8v9TPfhYsjWDCEo4qhXmW45q
 8fCV9UI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 May 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Note: due to differences in the diff algorithm (`tbdiff` uses the
> > Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
> 
> Pythong???

Yes, that's the French pronunciation.

Ciao,
Dscho
