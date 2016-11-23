Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7DF1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 19:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934354AbcKWTZX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 14:25:23 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:31716 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933124AbcKWTZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 14:25:05 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tPC1k1YTVz5tlT;
        Wed, 23 Nov 2016 20:23:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8D5F31D04;
        Wed, 23 Nov 2016 20:23:53 +0100 (CET)
Subject: Re: [PATCH] git-gui: pass the branch name to git merge
To:     Junio C Hamano <gitster@pobox.com>
References: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org>
 <xmqqvavfpbph.fsf@gitster.mtv.corp.google.com>
 <1dc28731-9000-c3bf-fbed-0cb17c230d8b@kdbg.org>
Cc:     Pat Thoyts <patthoyts@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5baaf25b-6f15-8002-97ea-97c5c6a4b4e4@kdbg.org>
Date:   Wed, 23 Nov 2016 20:23:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1dc28731-9000-c3bf-fbed-0cb17c230d8b@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.11.2016 um 21:40 schrieb Johannes Sixt:
> Am 22.11.2016 um 20:16 schrieb Junio C Hamano:
>> Can't this be handled on the "git merge FETCH_HEAD" codepath
>> instead?
>
> Absolutely. Any takers? ;)

I attempted to fix git merge FETCH_HEAD, but I do not see a trivial 
solution.

But on second thought, we have an excuse to pick my proposed git-gui 
change anyway: Without that change and a fix in git-merge only, there is 
still a regression for all users who use the latest git-gui but some git 
version between 2.5.0 and the fixed git-merge...

-- Hannes

