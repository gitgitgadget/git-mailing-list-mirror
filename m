Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B6B1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934842AbcJTQk3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:40:29 -0400
Received: from mout.web.de ([217.72.192.78]:50286 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753428AbcJTQk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:40:28 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LnS4I-1caARO0El4-00hcT3; Thu, 20 Oct 2016 18:40:20
 +0200
Subject: Re: Drastic jump in the time required for the test suite
To:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e0e320ce-14a1-b4a8-aa07-6bc4f3c4a424@web.de>
Date:   Thu, 20 Oct 2016 18:40:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ALRjnvgM6sW5ioFHtquSR6zgQHkQ6-LUnKFnqXV9eDCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:hgw1Ydj8R97/FnxH35wo52+uFjc4srA5LSIobjsHDjt+igE22yR
 kjdexPimCZFhVkHkFJSEQj0tndbsO+iVbHeKGL0jXlenKBPK1fOMlT+INLR2tPksdHyyKy4
 al6tX4Evh8IwBlvhuvhH9lXo2TvWyMS8XsJCXerwzer9sQaEuMT4vr7OBc1QAPtwUHYXQFi
 t79d9nCsuq1qB89KL58QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A/pLpZ965WA=:9lAdiMrO8kOx11Ry+pji/l
 llFXi4qBbskT+OiJIjUUc9kMcOAgpEuRLtVZi+DJodcPCbektQthyzCuEhFMqXz6zYMFPCP24
 +AzWHxd0a0HCrHlER2pXoIyEawwaVobLcLrqb1F2oEp57sFGelJUIl93h7TTo4K+N4ZcaMEe2
 xUZIK/Ye8s3YjKqw9gvbgm8iM6HSRRxCRCVpk9Yv+H6FRj606k/1CIZLm/93okNR2PWPZXp7Q
 uOfGNpFfkytI77/AE87bTOqGminC9oYxxwe95ntQSwfYWKsKhxpuk+xXmokrak9buabWOHG8Y
 H+Xuf2IwsTciLj2hzpbWNHZUytXaSCez+bsxCFnmgtctbAC5ni2QWIna0hJc/p89ucm67noD2
 euN4R4zQx6x/TuHTwPGLguWwnm48aLsyVGm6bBxHaIM+HTm7OGg5dru5OOnf9wLIb7QGYJdaL
 3w7zvVPuDFd0Y0jzOnz8oSinHZ3mE09lp0VcGVWYVir45YnIq3zzy5rTrwCvoBfberrPW8vkY
 9etcfDJEeoJNbA7HV+nzz6//Cda8cwymaHhETevki9FlfPkbCOuanfXojuN3rAudvMaJbmva9
 wbKPsTHYevC/IX6h2czqPVESCAmM2EczQHr1CWFgMcCc+zwQgcYI1gv0vAT2MxT7QQ597fd8V
 jy6XjiwHLCdNTuB4H6Hqa4cWm5WTRaNsNnPOVtx7R629Tcshe72yT5cDzHRxm+lns5eqTU42r
 yjqMu6sARDM+6H61r5DccmTRP9Jri+tl/tnk4fjcXJGb6Iq4m/2dXJEn5gyEstMQnxiRY8kvU
 E7XNxJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.10.2016 um 13:02 schrieb Duy Nguyen:
> On Wed, Oct 19, 2016 at 4:18 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Junio,
>>
>> I know you are a fan of testing things thoroughly in the test suite, but I
>> have to say that it is getting out of hand, in particular due to our
>> over-use of shell script idioms (which really only run fast on Linux, not
>> a good idea for a portable software).
>>
>> My builds of `pu` now time out, after running for 3h straight in the VM
>> dedicated to perform the daily routine of building and testing the git.git
>> branches in Git for Windows' SDK. For comparison, `next` passes build &
>> tests in 2.6h. That is quite the jump.
> 
> I'm just curious, will running git.exe from WSL [1] help speed things
> up a bit (or, hopefully, a lot)? I'm assuming that shell's speed in
> WSL is quite fast.
> 
> I'm pretty sure the test suite would need some adaptation, but if the
> speedup is significant, maybe it's worth spending time on.
> 
> [1] https://news.ycombinator.com/item?id=12748395

I get this on WSL with prove -j8:

Files=750, Tests=13657, 906 wallclock secs ( 8.51 usr 17.17 sys + 282.62 cusr 3731.85 csys = 4040.15 CPU)

And this for a run on Debian inside a Hyper-V VM on the same system:

Files=759, Tests=13895, 99 wallclock secs ( 4.81 usr  1.06 sys + 39.70 cusr 25.82 csys = 71.39 CPU)

All tests pass on master.

René

