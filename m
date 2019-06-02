Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407B01F462
	for <e@80x24.org>; Sun,  2 Jun 2019 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfFBLTJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 07:19:09 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:53019 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBLTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 07:19:09 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id XOW2hoQGwdraxXOW2hJwkV; Sun, 02 Jun 2019 12:19:07 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=eVKDs-1nHTYKp73fY14A:9 a=QEXdDO2ut3YA:10
Subject: Re: Why is there still git-rebase--am.sh?
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <3322453.bNc8J3RWDa@andromeda>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <ab655637-bb6d-436d-a822-31fa1a9495ed@iee.org>
Date:   Sun, 2 Jun 2019 12:19:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3322453.bNc8J3RWDa@andromeda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJYgyc+eZS4mvh8mnVibltBkDfBpgoXOXL645o/OyDd6Lgn6ZcTLoOhxRqKAgELpIx3tySpwLCCaTyZB37oSgdlntT9AI9WgCdvO5180Mtp1IJNK91wn
 h5azqklDnMo2z5uOCbd5hE4heiM3/nQLin/aZr8T2ZCUFAg36S1H4w8CP/Q3JxDwH2HcFV9vO/PWYlWQzgqieQonC/6Vo9EBKuiB70d5Zosj0BzH3ZRD5jsv
 EEVXRAxDHNTkYKgDiEdfQ/Om+T27hjtzMbj0sXoE968=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On 02/06/2019 12:04, Alban Gruin wrote:
> Hi,
>
> I was wandering in rebase’s source code, and found out that even though
> run_specific_rebase() no longer calls git-rebase--am.sh since 21853626ea
> ("built-in rebase: call `git am` directly", 2019-01-18), this commit did not
> remove the code to call it.  I guess it was an oversight.
>
> Now that git-legacy-rebase.sh is gone (since d03ebd411c, "rebase: remove the
> rebase.useBuiltin setting", 2019-03-18), I would expect this file to be
> completely removed, too.
>
> May I send a patch to remove git-rebase--am.sh, or is there a reason to keep
> it?
>
>
What's cooking (May 2019, #05; Thu, 30) has it in js/rebase-cleanup 
(2019-05-15) 5 commits, and will be cooked in next.
Philip
