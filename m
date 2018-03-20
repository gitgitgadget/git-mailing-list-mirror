Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD381F404
	for <e@80x24.org>; Tue, 20 Mar 2018 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbeCTBeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 21:34:00 -0400
Received: from avasout04.plus.net ([212.159.14.19]:54955 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeCTBd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 21:33:57 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id y69yeYDdLsD7by69ze8Y0k; Tue, 20 Mar 2018 01:33:56 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=HRm4jhWXpj71bThlqTcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: PATCH 1/2] -Wuninitialized: remove some 'init-self' workarounds
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
References: <946e0ff9-307c-6886-6ade-7bd37cc9f97f@ramsayjones.plus.com>
Message-ID: <c9748dfd-4293-140f-e753-8736bc196ab0@ramsayjones.plus.com>
Date:   Tue, 20 Mar 2018 01:33:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <946e0ff9-307c-6886-6ade-7bd37cc9f97f@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCRJ5JwKOLe4vxPuprwY9LWtksTfhxHeMA9xsc6ofc32IE3E0w+GRgxMmFT9TLTem8/VdAMKoIDlQRW4ibPibdR0zkrDTxyiweEc1iy5cNG3dOVRzUJ9
 ecEreYFf4k4f21cBh3+6iqavAHMHS3a9QjDwrzJemK/UQbYVhcbsScuctB8tzd2cavFKVaRnkCtLPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/03/18 17:54, Ramsay Jones wrote:
> 
> The 'self-initialised' variables construct (ie <type> var = var;) has
> been used to silence gcc '-W[maybe-]uninitialized' warnings. This has,
> unfortunately, caused MSVC to issue 'uninitialized variable' warnings.
> Also, using clang static analysis causes complaints about an 'Assigned
> value is garbage or undefined'.
> 
[snip]

Hi Junio,

You may not have noticed that I messed up the Subject line of
this patch - I managed to drop the '[' character in the patch
prefix string. :(

So, the commit 7bc195d877 on the 'pu' branch is titled:

  "PATCH 1/2] -Wininitialized: remove some 'init-self' workarounds"

Ahem! Sorry about that.

ATB,
Ramsay Jones


