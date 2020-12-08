Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8CC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA433222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbgLHWUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:20:25 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60140 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgLHWUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:20:24 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlKakHGdc0K1OmlKbkvmyS; Tue, 08 Dec 2020 22:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607465978; bh=pEhfFV4ph2Nh+tFPUBKv+Z+2V+cPHEVs1qHcnqc+EQc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=reyOTMt+H0no/bT11pSzk2i2mDc+Sxzck7mmelJ/gquwsSwH/+PyOG/c4JERCsNke
         0j3jbH67OfCDRKSkM8Y8kzvdQfruPboy9s9dd4x1rbIWMcNsuCmBPWoKOZQM0hNtWA
         +m/afDzEYkA7/KzvfP/BlXz7eFymQRxjSK+MZ1CflfXb+j+BShUJIhzE5M+RX5DrYb
         uCSP+KP4H+Vv1pKEEEQV4E/MN4bMT9qwuZlcZCoHgvXiI2I7/KJ62goW+0+B90FbUc
         r5JBNqsYg1tVPGCxy2hZmGwHfmqIYWpvkkbSThTeJbdJbIWy2b261RP0pVMvMu5ypK
         yJw98y5nWN/Gg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=st9mhnE8yJTIwaOjfSUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/5] Documentation/Makefile: conditionally include
 doc.dep
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
 <CAMP44s1eb7O+bYXFyYm7BLCP37r1k80XY4MOC8RRL4nY61CMDQ@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9bc6dc79-7c15-b0c3-e765-7fd0d1c1a81b@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:19:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMP44s1eb7O+bYXFyYm7BLCP37r1k80XY4MOC8RRL4nY61CMDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPNmWdSDrlnaDi3pluVofLnNJ2LMNILZueloKItC5zTC0648YBty9Znu3Ru9RDAFCsx+NWvt2iMJcnhcehcyFW3GhPBCYf0fi4xrWiiT+/5JWSDK2i5u
 VoerTzyQYZoGshsV1yIB+VdGmSUxo4swWOZvlfcQBPLAYNrs7AFq2zO3Qi9GRU0viss/1T1kUVDxow==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/12/2020 03:18, Felipe Contreras wrote:
> On Sun, Dec 6, 2020 at 6:35 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
[snip commit message]
> 
> All this makes sense, but I had to do "make doc.dep" and take a look
> at that file to understand why:
> 
> doc.dep contains make rules with targets and dependencies that will
> not be used in "make clean".
> 
> This is in my opinion the important information. Maybe mention
> something like that in the commit message?

Yep, Junio made a similar comment. v3 comming soon ... :-D

ATB,
Ramsay Jones


