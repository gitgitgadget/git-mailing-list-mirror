Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E83C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DA9222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgLHW0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:26:42 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60439 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgLHW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:26:41 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlQfkHHAy0K1OmlQhkvn2f; Tue, 08 Dec 2020 22:25:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466355; bh=zHHppHki/B3moJKWgh+BZlBkk3dV4/PBMqmYy+Np0SU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l67cR+LlnRMzHOLdnn1r51/KMQJ/1Rgc9rWuedWoZ+sDMj2mmWa+VhXRgjKERYCbj
         CuoPTsdu3L32SFmzIDUkltDp57g2zFhqwWWe1u4RM6dYOFINNvBwJcAK/s/zq48R3A
         7hSoAW5MsPsH0kltNYsABIvYytCYl9oAgx0LFOWDXlopcN9fgceI/8gSliKI3ZaDjZ
         ajwzgO4EsFiEHE/L0ChXWOxRotwkmmyWrll80yPaiMvNAZXUWYR0D5jo29SEtp6Cmw
         BOHAekUS72R1sNsDXUpWDt8zIvG94px8h1ea4HiOKt/+06fajIHNcoQ1jiTGBqkmnp
         V65vLmiLvk89w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=bJ6GPNHylWCmqVZ0GUQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 1/5] Documentation/Makefile: conditionally include
 doc.dep
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <a8e1bc9d-ce6c-d065-5a20-fee15967364d@ramsayjones.plus.com>
 <xmqq360icb5x.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7269e3e4-0f1f-7db4-de5f-c26d43bde0df@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:25:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqq360icb5x.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCjOayQAnObbUXZJfcToEambk+dwuYBcTxVdBWE4dxwOo1LSw4ypyGr3sHftoaaXYbhAOpYbJtzEbn8TDQVs0sDYTZ71zgAmoNHjpmqi0JHRXTjSssD2
 ac/9OXEk96xLI6aYuW0+6lwbJL9xGYQ5T9PyBR3aTEQXLxNMCtI4SZ6Xwp2M6Thm9qez3+sKdN1I+w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/12/2020 07:44, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
[snip commit message]
> 
> Nicely explained.  It might be worth saying
> 
>     ... the clean target immediately deletes those files.  The rules
>     and definitions of doc.dep however does not affect what 'clean'
>     target removes otherwise, so we can do without all this.

Yep, I have attempted to improve the message along these lines ... Thanks!

v3 coming soon ...

ATB,
Ramsay Jones

