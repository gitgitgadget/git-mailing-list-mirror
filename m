Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9691F78F
	for <e@80x24.org>; Mon,  1 May 2017 14:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947688AbdEAOZi (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 10:25:38 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36758 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423640AbdEAOZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 10:25:36 -0400
Received: by mail-it0-f44.google.com with SMTP id r185so28226969itd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IK77NHNLq+f/76FPR2viLUrdIo8IIDQInp+TwmK6Ia8=;
        b=WOcwZKl6Ea0l0WrDxh6hpIn5BsArCgrIcx11EQQEtBq6Pp9R4i0jZxnLw1wyNtDbnK
         8oBMNTo4TSeQBYxTQ7+vi91KzKIRmgqd10jYaksAV7ZmbHDdDdhTTKiu2BuBWq2dPPlS
         z8cBXtEHdtAdSnRN2QDYMqrlP3uOpE6s02Eex1Wqa8iPcuULyM4d0dmBzoOdKGsCoHnV
         o7xBFj87cD8x1qxYhJqtQwKi0jUmZvlUEnmsbSL18fWIZpp7/hT9OuFZeCLIW3Fmlt/A
         IyukcCVWVuNMt7zc4M0vXqsW0LzBpwiIwhcSNsH6fRzKkNjuqYQ0DrKha0NeMEjbN3ut
         JFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IK77NHNLq+f/76FPR2viLUrdIo8IIDQInp+TwmK6Ia8=;
        b=s0SN4ZpfqgHolNiubpU5E18lMdHV8SnQbafZSO/21jP2wCjbtWPoQRV5PPTyr+sWKe
         j/ZGIw7Fpq7yDq5AJQ+SMzLRxHhx8xI7OJiQV1tFrJupoTNAivbqTzUb8sRCHHsZV66N
         1a/9bXFOegm0VegBJ1Z8mny1SzQ1+F8IDij7lmSGs3xM90QZ3O++lk+eQf3Xl0l+elf1
         wQBv9ytB1yjGg66GcKELyJaEqPe45IBKR79cFXp1acsuEVrbm18tjBInT064XMZ6tWPv
         pbF18u/GL1ppchmIrYmuhmRAVUmGdkY27EcOClUcU8FoiCbIpRmS6m9QoEiAjPH4BdXF
         D5Bg==
X-Gm-Message-State: AN3rC/6tVd1rjiy4iEqjOsWPA7c/g2cxZ1vmD/55sd1OIn+Q74yrxGn7
        KB5ARVKY+pgfSD6+3GjEx/6XO8ZcuBfUPnk=
X-Received: by 10.36.124.129 with SMTP id a123mr2244483itd.66.1493648735567;
 Mon, 01 May 2017 07:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 1 May 2017 07:25:14 -0700 (PDT)
In-Reply-To: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 1 May 2017 16:25:14 +0200
Message-ID: <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 7:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * ab/clone-no-tags (2017-05-01) 3 commits
>   (merged to 'next' on 2017-04-30 at 601649896a)
>  + tests: rename a test having to do with shallow submodules
>  + clone: add a --no-tags option to clone without tags
>  + tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
>
>  "git clone" learned the "--no-tags" option not to fetch all tags
>  initially, and also set up the tagopt not to follow any tags in
>  subsequent fetches.
>
>  Will cook in 'next'.

Thanks for trimming off the top 2 patches. I've dropped those myself,
if someone (Brandon || Stefan) more interested in working on
submodules wants to pick them up that would be neat, but I don't need
it myself & doing it differently than the existing submodule options
would take too much of my time.

> * ab/grep-pcre-v2 (2017-04-25) 20 commits
>  - SQUASH???
>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>  - grep: remove support for concurrent use of both PCRE v1 & v2
>  - grep: add support for PCRE v2
>  - grep: add support for the PCRE v1 JIT API
>  - perf: add a performance comparison test of grep -E and -P
>  - grep: change the internal PCRE code & header names to be PCRE1
>  - grep: change the internal PCRE macro names to be PCRE1
>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>  - grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>  - log: add -P as a synonym for --perl-regexp
>  - log: add exhaustive tests for pattern style options & config
>  - grep: add a test for backreferences in PCRE patterns
>  - Makefile & configure: reword outdated comment about PCRE
>  - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
>  - grep: remove redundant regflags assignment under PCRE
>  - grep: submodule-related case statements should die if new fields are added
>  - grep: add tests for grep pattern types being passed to submodules
>  - grep: amend submodule recursion test in preparation for rx engine testing
>
>  PCRE2, which has an API different from and incompatible with PCRE,
>  can now be chosen to support "grep -P -e '<pattern>'" and friends.

That squash looks good to me.

> * ab/grep-threading-cleanup (2017-04-16) 8 commits
>  - grep: given --threads with NO_PTHREADS=YesPlease, warn
>  - pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
>  - pack-object & index-pack: add test for --threads warning under NO_PTHREADS
>  - tests: add a PTHREADS prerequisite
>  - grep: skip pthreads overhead when using one thread
>  - grep: don't redundantly compile throwaway patterns under threading
>  - grep: add tests for --threads=N and grep.threads
>  - grep: assert that threading is enabled when calling grep_{lock,unlock}
>
>  Code cleanup.
>
>  Needs review.

Between these two series there's 27 patches, and I understand it's a
bit of a PITA to review/get comments on it.

Anything I should be doing differently here other than just waiting
for 2.13 to come out so they can be cooked further & merged down to
next & then master if there's no objections?
