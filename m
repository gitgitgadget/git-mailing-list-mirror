Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ECAA2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 21:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbcJYVYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 17:24:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:53712 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbcJYVYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 17:24:04 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t3R3j4LYFz5tlG;
        Tue, 25 Oct 2016 23:24:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 159855348;
        Tue, 25 Oct 2016 23:24:01 +0200 (CEST)
Subject: Re: What's cooking in git.git (Oct 2016, #06; Mon, 24)
To:     Stefan Beller <sbeller@google.com>
References: <xmqq1sz5tetv.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbtyuSXDiyi2eY6HKCAwEiKgk2KmNakSn=f+RiXCAC1bA@mail.gmail.com>
 <xmqqoa28s63l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kb2XD8+y-Y_oiwSj3DsXjmTS=bd6fj5dn9NADmvDO5xtQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <23f15627-4964-7ba9-45c3-899366d621bd@kdbg.org>
Date:   Tue, 25 Oct 2016 23:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb2XD8+y-Y_oiwSj3DsXjmTS=bd6fj5dn9NADmvDO5xtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.10.2016 um 20:13 schrieb Stefan Beller:
> On Tue, Oct 25, 2016 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  - the "off-by-one fix" part of sb/submodule-ignore-trailing-slash
>>    needs to be in the upcoming release but the "trailing /. in base
>>    should not affect the resolution of ../relative/path" part that
>>    is still under discussion can wait.  Which means we'd need a few
>>    more !MINGW prerequisites in the tests by -rc0.
>>[...]
>
> So maybe instead of adding !MINGW we rather want to apply
> https://public-inbox.org/git/2908451e-4273-8826-8989-5572263cc283@kdbg.org/
> instead for now?

I was about to submit this very patch again, and only then saw your 
message. So, yes, that's what I propose, too.

Dscho, does this patch fix the test failures that you observed, too? 
Unfortunately, it goes against our endeavor to reduce subshells.

-- Hannes

