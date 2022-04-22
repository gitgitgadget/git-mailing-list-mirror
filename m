Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99399C4332F
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 05:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiDVFnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiDVFnD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 01:43:03 -0400
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF194F467
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 22:40:11 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Kl3CD3M6fz5tlH;
        Fri, 22 Apr 2022 07:40:08 +0200 (CEST)
Message-ID: <36a43fbb-92af-3718-f2fb-51645564a961@kdbg.org>
Date:   Fri, 22 Apr 2022 07:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Failures in t9001-send-email
Content-Language: en-US
To:     Alyssa Ross <hi@alyssa.is>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220421194832.lshqkl3bogy2f2hy@eve>
 <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
 <20220421223843.6z3y4bnrbu76erhk@eve>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220421223843.6z3y4bnrbu76erhk@eve>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.22 um 00:38 schrieb Alyssa Ross:
> I thought I'd have a go at a patch, but I wasn't able to get the tests
> running:
> 
>     prove ./t9001-send-email.sh
>     ./t9001-send-email.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>     Failed 15/188 subtests
> [...]
> 
> I had a look at the tests to try to guess what was wrong, but I didn't
> come up with anything.  Any ideas?

You run ./t9001-send-email.sh (without `prove`). Add -v to see some
verbiage from the tests, throw in -i to have it stop at the first
failure (so you don't have to scroll back to find it), and add -x for
additional traces of commands that the shell executes (to see the exact
command that failed).

IFAIC, I always go all in, i.e., either all or none of -v -i -x.

-- Hannes
