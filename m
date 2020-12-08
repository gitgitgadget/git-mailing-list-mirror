Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66410C19437
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DB5239FD
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgLHWYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:24:05 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60317 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgLHWYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:24:04 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlO8kHGxB0K1OmlO9kvn11; Tue, 08 Dec 2020 22:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466197; bh=6nZzZ2dFU0/PIjVf8xKXABWDNrB/SlSoJnDCjfBtPoE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NupM33wAJickpQpvxOr6PblT8ivUrZsYQGEfBiEiFIlVAehzPT71Ko4q3kDQHvPpQ
         mPcpANZbh2/I5VShM9YbjeBYCuLzYV6i7QJomdD88lZVpzEt9KP99zekPOO6B5u47h
         AWZqlIslOaXGNxY2LXx/NH08yK6QWzuHkVeXSP24PP0EU09XaOjiY2jlRQdzXyxmwC
         f8JQXj0PN/JxDL8Os01FIzCnVNnnjjRljjJFHDYpCHWnYtZE67lqgwB3jxVfvZ6Qpw
         eHyPq0Hw6rfOwFI65wc10vWPcbatn59y36kEtn5881nOCSeAtAGEQ+r+6tLdvXf2WN
         b+mhG2vTFuG2w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=KD-cRk25n5JaUTl5KJYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/5] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <3e085045-99d5-29ee-ed3f-076b1b8bb6b6@ramsayjones.plus.com>
 <CAMP44s3hCm_2=jRv-4knNWe+V5vR_+XWjHVFkVm_LNzJ+n1sDg@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9cde91bf-8808-6110-b9ea-a3385225f0a2@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:23:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMP44s3hCm_2=jRv-4knNWe+V5vR_+XWjHVFkVm_LNzJ+n1sDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP8nkRZRrDLtyv2oTCVWrpRBsBbGD0OxSctLmw3K6HQz1P9s6XTGLD38aJzZ8Y+xJweHHGSczPZQKQswQLjostCqA1eoe9uhsWOKuK/6ShX6l2X+qaYL
 Glnl7GISeD1GE7CsYUy0aX3X0kjVkBJCvpigkdfVHABD0RNaFfzunV5Dvm0lVTKBpXnxiAC75IcWgw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/12/2020 03:21, Felipe Contreras wrote:
> On Sun, Dec 6, 2020 at 6:35 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
[snip]
>> Notice that the 'clean' target is making a nested call to the parent
>> Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
>> the previous patch, there would have been _two_ such invocations).
>> This is to ensure that the $(GIT_VERSION) make variable is set, once
>> that file had been included.  However, the 'clean' target does not use
>> the $(GIT_VERSION) variable, so this is wasted effort.
> 
> Yes, this is the important information: "the 'clean' target does not use
> the $(GIT_VERSION) variable". I would feature it at the start of the
> commit message.

Heh, I didn't intend to 'bury the lead' here. I spent about 30 minutes
re-writing this message to come up with an improvement; I'm not sure
that I succeeded. ;-)

v3 comming soon ...

Thanks!

ATB,
Ramsay Jones

