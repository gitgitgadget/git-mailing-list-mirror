Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931A51F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965008AbeAXSv0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:51:26 -0500
Received: from avasout02.plus.net ([212.159.14.17]:55808 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964989AbeAXSv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:51:26 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id eQ8oe7lUWC9PeeQ8qeWM0J; Wed, 24 Jan 2018 18:51:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=P+MUeBIu c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8
 a=ZSC0Gbhyz_MsaCNxSF4A:9 a=d05D3g4JurcY_Hbo:21 a=1xh8qA805lJi_I2S:21
 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 3/3] sequencer: run 'prepare-commit-msg' hook
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180124123422.10637-1-phillip.wood@talktalk.net>
 <20180124123422.10637-4-phillip.wood@talktalk.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3587bc5f-c5f7-d037-6644-25e21a5f4942@ramsayjones.plus.com>
Date:   Wed, 24 Jan 2018 18:51:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180124123422.10637-4-phillip.wood@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJaIdGQTxq4kfunrDUYgO+adLBH+d6YbDj+JKuUQrzHQoRorZK956s9eaact0xTZbiDiCt/5PQP/7+kaBTOi4Smp+1LntscoG73/uyBVQ7HGJ9kATs5x
 HqN4hylR2tUg6y5tsUKhFl0OzYnh6UwD3ks33ipQirEiKS0Sc2LpjI4y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/18 12:34, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Commit 356ee4659b ("sequencer: try to commit without forking 'git
> commit'", 2017-11-24) forgot to run the 'prepare-commit-msg' hook when
> creating the commit. Fix this by writing the commit message to a
> different file and running the hook. Using a different file means that
> if the commit is cancelled the original message file is
> unchanged. Also move the checks for an empty commit so the order
> matches 'git commit'.
> 
> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Reviewed-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Echoing Eric's earlier email, I don't think this Reviewed-by is
warranted - I only requested the addition of a static keyword,
I didn't actually review the patch.

Thanks.

ATB,
Ramsay Jones


