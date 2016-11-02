Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BE820193
	for <e@80x24.org>; Wed,  2 Nov 2016 17:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756351AbcKBRn3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 13:43:29 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:55531 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756057AbcKBRn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 13:43:29 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t8FnV3BDyz5tlB;
        Wed,  2 Nov 2016 18:43:26 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 320C0148;
        Wed,  2 Nov 2016 18:43:25 +0100 (CET)
Subject: Re: What's cooking in git.git (Oct 2016, #09; Mon, 31)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <xmqqwpgoqjct.fsf@gitster.mtv.corp.google.com>
 <20161102170415.GA6420@tb-raspi>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <73aed2a3-f2ad-ecc2-d43c-86b4a110a970@kdbg.org>
Date:   Wed, 2 Nov 2016 18:43:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161102170415.GA6420@tb-raspi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.11.2016 um 18:04 schrieb Torsten Bögershausen:
>> * ls/filter-process (2016-10-17) 14 commits
>>   (merged to 'next' on 2016-10-19 at ffd0de042c)
> 
> Some (late, as I recently got a new battery for the Mac OS 10.6 test system) 
> comments:
> t0021 failes here:
> 
> 
> Can't locate object method "flush" via package "IO::Handle" at /Users/tb/projects/git/git.next/t/t0021/rot13-filter.pl line 90.
> fatal: The remote end hung up unexpectedly
> 
> 
> perl itself is 5.10 and we use the one shipped with Mac OS.
> Why that ?
> t0021 uses the hard-coded path:
> t0021/rot13-filter.pl (around line 345) and the nice macro
> PERL_PATH from the Makefile is fully ignored.
> 
> Commenting out the different "flush" makes the test hang, and I haven't digged further.
> 

https://public-inbox.org/git/e8deda5f-11a6-1463-4fc5-25454084ccb1@kdbg.org/

-- Hannes

