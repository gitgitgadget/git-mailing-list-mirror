Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D52C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A40360F9D
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhIVTSu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:18:50 -0400
Received: from avasout02.plus.net ([212.159.14.17]:37571 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhIVTSt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:18:49 -0400
Received: from [10.0.2.15] ([217.32.115.204])
        by smtp with ESMTPA
        id T7k4mNIyvrasdT7k6mNXMl; Wed, 22 Sep 2021 20:17:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1632338238; bh=oDf9xVsa9foiEBjFBF2Q4/YG2OMgaUbFquQgKkX+lSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z1xStkhQBSyxb7gZ/IvTo18/Nuo2ijs4UR8Ujwl/xQgNknyHxKTFuhWw4+0rNi8N4
         Bci4m7geQnLLYytbwrynOjzlEudhSs4tIvhhLiU39fxpTnNOje7N+A6rg4Pb4qAUGG
         WuVipeoa1Hw4mFMyW3V/LbYlsSzY53DqXGucWQKh9cKPjyj7I7wEIMEMnJnxFyXNew
         22uNbpcRxmis8+q5huu6Pj4FdwoEr8yNtJ7hu/FoXudZZpGDEgQ52eH/qnbGuqt4o1
         3Cc6epE18WMBllkbr3ywNZi+CeidCz3/7wsbQpMkrfQvs3G3FLcODSwoPwzAUKrhlu
         I2ybathKeazPA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=dIE9ZNRb c=1 sm=1 tr=0
 a=SVJmvQqwCtcAfy+lhBggeQ==:117 a=SVJmvQqwCtcAfy+lhBggeQ==:17
 a=IkcTkHD0fZMA:10 a=Zd-QLtE0D9qrs9zMDdYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
 <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
 <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <82c3d9fc-32ff-c38a-cb44-873af1fb83d1@ramsayjones.plus.com>
Date:   Wed, 22 Sep 2021 20:17:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGTfuC2bSjrrwO8TDAVbj+9oX0JtSlIYouAiNt3CKjoXrk+mpyb0eBT0tMhTNIu2wJOFmA0ZzEMJAWCkHjxzQixkfbHmPHtR/iuaJc320LnM1B9qGxjs
 XCsTLvQUQ7Xw7fyO+RHnRsVuASlN5M6azGRqBMVDg40iO0biK/3bHG3U0gbEWEmoqtU6ETeL6zfmWA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/09/2021 18:53, Jeff King wrote:
> On Wed, Sep 22, 2021 at 05:58:16PM +0100, Ramsay Jones wrote:
> 
>>> All three seem pretty reasonable to me.
>>
>> Heh, interesting. My initial reaction was completely negative! ;-P
>> (and not just mildly negative either, but 'you must be kidding').
>>
>> However, I then thought 'I must be missing something, I'm being
>> stupid and about to embarrass myself in public!'. So, I have
>> been trying hard to understand what these patches are trying to
>> accomplish and just what it is I'm missing. But, I'm coming up
>> blank ...
> 
> I think the point is just avoiding repeated work. If you just manually
> run "make sparse" once in a while, then caching the result probably
> isn't of much value. But if you plan to run, say:
> 
>   git rebase -x 'make sparse'
> 
> then it would be nice for it to avoid checking the same files over and
> over.

I haven't tried, but

    git rebase -x 'make CC=cgcc'

may be a better idea (for some definition of 'better' ;) ).
(if you have been doing all recent builds with CC=cgcc, then
the first commit wouldn't force a complete re-build!).

Using CC=cgcc has a mixed past, sometimes working, sometimes
not (again for some definition of 'working'), for example:

  $ git checkout master
  ...
  $ make clean
  ...
  $ make CC=cgcc >out1 2>&1
  $ ./git version
  git version 2.33.0.514.g99c99ed825
  $ git describe
  v2.33.0-514-g99c99ed825
  $ grep warn out1
  imap-send.c:1461:9: warning: expression using sizeof on a function
  http.c:715:9: warning: expression using sizeof on a function
  http.c:1776:25: warning: expression using sizeof on a function
  http.c:1781:25: warning: expression using sizeof on a function
  http.c:2190:9: warning: expression using sizeof on a function
  http.c:2362:9: warning: expression using sizeof on a function
  http-walker.c:382:9: warning: expression using sizeof on a function
  http-push.c:194:9: warning: expression using sizeof on a function
  http-push.c:205:9: warning: expression using sizeof on a function
  http-push.c:206:9: warning: expression using sizeof on a function
  remote-curl.c:855:9: warning: expression using sizeof on a function
  remote-curl.c:945:17: warning: expression using sizeof on a function
  remote-curl.c:947:17: warning: expression using sizeof on a function
  remote-curl.c:1014:9: warning: expression using sizeof on a function
  $ grep error out1
  $ 

The warnings are due to some gnarly macro magic in the curl headers
which is normally suppressed by setting -DCURL_DISABLE_TYPECHECK in
the SP_EXTRA_FLAGS variable for each of those files. (see e.g the
Makefile:2250).

>> At the heart of my unease is dependencies (or rather the lack) for
>> the 'synthetic object files' *.hco and *.sp. (Also, the addition
>> of even more 'shrapnel' to the build directories - I wrote a patch
>> to remove the useless *.hcc files just after commit b503a2d515e was
>> included, but didn't get around to submitting it).
> 
> I don't consider them shrapnel if they're holding useful results. :)

Heh, yes I am a bit of a curmudgeon! :D

> But overall, I do agree that if we can't make the dependencies solid
> here, this is not worth doing. Sacrificing correctness of the checks for
> reduced computation is not a good idea.

Yes, I suspect that 'make the dependencies solid' will be a
challenge, with drip, drip, fixes being required. (Maybe I
am just too pessimistic - maybe we can accept good enough
rather than perfect. Also, the sparse solution may be easier
than the hdr-check solution).

ATB,
Ramsay Jones
