Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94F21F744
	for <e@80x24.org>; Mon, 27 Jun 2016 07:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbcF0HJy (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 03:09:54 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37982 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcF0HJw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 03:09:52 -0400
Received: by mail-wm0-f49.google.com with SMTP id r201so100706122wme.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 00:09:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SgoIMOYLW/HrTuWnPjBhBTJhEAMO1pdG+yL/ZsvqIbA=;
        b=MMMP/R+XRL9nrcsELmgoHG3ZKC8jERLFNXILZlK2qYowg9cufcHbXgJS5/yxnNdzrd
         6ClCnRo0TGE+uBB3HVPaV/m0YcSdSL9M/d99oXavWgDFNz1AymfhSMEg20NPYHqs4eNs
         mLR7cprFuE9MbaqjwE7BAntfE9ivXp1iqS0CC+jWdFdqCvpZL3qV7WJowxE941qd7qJn
         3foY33K4ojmbCIZfMuVn1sfCl8JUy4CSBMM5DO4YhsSvfAu9HlR/LYo8YTCvw5X4kwmO
         lGQXzr0g9++O8YyJE2Ft8ozGPIEeTh8TnRMYp2z/xaAvO7u0xkAQLTVRs6v9UQJN/G+O
         bHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SgoIMOYLW/HrTuWnPjBhBTJhEAMO1pdG+yL/ZsvqIbA=;
        b=d/uBlxvjWzUNv9pQ62UlEvsD15Ye0xxQUd5z7MqZt/+YTG5SvBADuH/t1RDmQSkEqd
         Is08js7TSnvU9evY9OmwyGzS9LImWvt1J6KZyBpfhX/kc0R79IYGrI4r3StLZLo5GDbH
         I+B6/+KLi4sRtwpuw8RTxnQoEy7IjY7iHq44ARSBCTG+9349A+7HDl13KhcdTJg3xfFE
         /8BG4arZQzTi2KshJwk/cQYCi9LIZ/yi3ZQzsgzA0rYRaK81zPDqQyUz5uA7fUGw1Wmd
         NztAk+0Z+wXuY92w3kM6iUe9h1pT02PfFUOk12m5YzUac59p7OMgR0CRwUs03vizbRIb
         RuQw==
X-Gm-Message-State: ALyK8tKUyh9oKMwLaerMdF4K2cegcOJS+hRxV0Ng/oU8I69+jLfmT/kTdvnTNO65tK49jQ==
X-Received: by 10.194.178.199 with SMTP id da7mr14145264wjc.123.1467011391209;
        Mon, 27 Jun 2016 00:09:51 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4A71.dip0.t-ipconnect.de. [93.219.74.113])
        by smtp.gmail.com with ESMTPSA id g195sm10120608wme.23.2016.06.27.00.09.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 00:09:50 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <576B9081.3020405@alum.mit.edu>
Date:	Mon, 27 Jun 2016 09:09:49 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, novalis@novalis.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7DB6E8A8-964F-46B2-B22C-4C70943A7C94@gmail.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com> <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com> <576650E7.70107@alum.mit.edu> <xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com> <xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com> <8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com> <576B9081.3020405@alum.mit.edu>
To:	Michael Haggerty <mhagger@alum.mit.edu>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 23 Jun 2016, at 09:32, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
> On 06/20/2016 09:57 AM, Lars Schneider wrote:
>> 
>>> On 20 Jun 2016, at 01:51, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> Junio C Hamano <gitster@pobox.com> writes:
>>> 
>>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>> 
>>>>> According to [1], something in that test seems to have been trying to run
>>>>> 
>>>>>   git update-ref -d git-p4-tmp/6
>>>>> 
>>>>> Similarly in the other failed test.
>>>> 
>>>> Ah, OK, that would try mucking with .git/git-p4-tmp/6 but that is
>>>> not a place to have a ref.  It will not participate in reachability
>>>> analysis and will end up losing the referents.
>>>> 
>>>> Perhaps placing it under refs/git-p4-tmp would fix it (both in
>>>> git-p4 and in tests)?
> 
> I have to say, I'm still confused about how the old code could have
> worked at all. For quite some time, Git hasn't allowed references with
> weird names like `git-p4-tmp/6` to be created, so how could there be any
> references there that need to be deleted? It seems to me that one of the
> following must be true:
> 
> * This feature (i.e., whatever needs to create the temporary
>  references) has been broken for a long time, which would imply that
>  there are no tests for it.
> 
> * The references are created in some bogus way, like writing files
>  directly to the filesystem, rather than using `git update-ref`.
>  This is broken and will be even more broken soon when we add
>  support for different reference storage backends.
> 
> * Such references are never actually created and never actually
>  needed. This would imply that the cleanup code is unnecessary.
> 
> * The temporary references are created using `git branch`, and are
>  thus actually named like `refs/heads/git-p4-tmp/6`. In this case
>  the deletion code wasn't cleaning them up right, but the feature
>  might have otherwise worked correctly.
> 
> * I'm wrong about Git not allowing references like `git-p4-tmp/6` to
>  be created, in which case I'd like to know what code path allows it
>  so that I can fix it.
> 
> Any of these possibilities would mean that your proposed fix is wrong or
> incomplete.

Although I know git-p4 quite well, I am certainly no expert for the git-p4
branch import. I also pointed out in my previous reply ($gmane/297703)
that the git-p4 branch import never worked successfully for me. I always
thought the reason is that my P4 branch history is a bit messy. The clean 
git-p4 branch test cases work fine, though.


>>> Oh, another thing.  If these refs are meant to be transient, they
>>> are likely to be per worktree, if "git worktree" managed multiple
>>> worktrees that share the same set of branches and tags are in use.
>>> 
>>> I recall we carved out one hierarchy under refs/ as "not shared
>>> across worktrees" (was that refs/worktree/ hierarchy?  I didn't
>>> check but please do so when the patch actually is written), and
>>> that hierarchy is the appropriate thing to use for this, I think.
>> 
>> Thanks for the hint. It looks like as if the "per worktree" decision
>> is made in "ref.c:466" "is_per_worktree_ref":
>> https://github.com/git/git/blob/3dc84b0c19932ec9947ca4936b6bfd6421ccb1b4/refs.c#L466-L470
>> 
>> In ce414b3 "refs/bisect" was added to a list of prefixes that are
>> per worktree. I could easily add "refs/git-p4-tmp" to this list but
>> I don't think that would be a good solution. I would prefer to go with 
>> your suggestion and add "refs/worktree" to the prefix list and then use
>> "refs/worktree/git-p4-tmp".
>> 
>> Later on we could move "refs/bisect" to "refs/worktree/bisect" and
>> simplify the "is_per_worktree_ref" code, too.
> 
> The other part of making `refs/bisect` per-worktree is this horrible
> hack here [1].
Thanks for the pointer!


> I'd like to request that the change for the p4 temprefs be made in two
> steps:
> 
> 1. Write references to `refs/git-p4-tmp` or whatever, without
>   worrying about making them per-worktree.
> 
> 2. Carve out a per-worktree namespace, bikeshed about its name and
>   semantics, make sure it works correctly, then finally move the
>   p4 temporary references and eventually the bisect references there.
> 
> The reason is that step 1 is low-risk, could be made quickly, and is
> enough to unblock mh/split-under-lock and the other patch series that
> depend on it. Step 2, on the other hand, could take quite a while, and
> its implementation might benefit from changes to reference handling that
> are in the pipeline (e.g., perhaps the horrible hack can be dispensed
> with). Meanwhile, as far as I understand these references are transient,
> so there are no backwards-compatibility considerations that make
> renaming them twice more cumbersome than renaming them once.
Agreed! I will post the patch in a few seconds.

Cheers,
Lars


> 
> Thanks,
> Michael
> 
> [1]
> https://github.com/git/git/blob/ab7797dbe95fff38d9265869ea367020046db118/refs/files-backend.c#L176-L192

