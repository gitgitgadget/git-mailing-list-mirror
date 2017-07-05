Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6290C202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbdGEUOT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 16:14:19 -0400
Received: from avasout08.plus.net ([212.159.14.20]:55724 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdGEUOS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 16:14:18 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id h8EG1v0021keHif018EHW7; Wed, 05 Jul 2017 21:14:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=eA_sETkm6fwIheHPn50A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] hooks: add signature using "interpret-trailers"
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        gitster@pobox.com
Cc:     git@vger.kernel.org
References: <20170705170034.20899-1-kaarticsivaraam91196@gmail.com>
 <20170705173508.28711-1-kaarticsivaraam91196@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <58c71fab-d93e-d6f0-2df2-654f08a667b7@ramsayjones.plus.com>
Date:   Wed, 5 Jul 2017 21:14:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170705173508.28711-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/07/17 18:35, Kaartic Sivaraam wrote:
> The sample hook to prepare the commit message before
> a commit allows users to opt-in to add the signature
> to the commit message. The signature is added at a place
> that isn't consistent with the "-s" option of "git commit".
> Further, it could go out of view in certain cases.
> 
> Add the signature in a way similar to "-s" option of
> "git commit" using git's interpret-trailers command.
> 
> It works well in all cases except when the user invokes
> "git commit" without any arguments. In that case manually
> add a new line after the first line to ensure it's consistent
> with the output of "-s" option.
> 
> While at it, name the input parameters to improve readability
> of script.

I assume each occurrence of 'signature' in the commit message,
including the subject, should be 'sign-off' (or Signed-off-by)
instead. Yes?

(when I hear 'signature', I think GPG signature).

ATB,
Ramsay Jones

