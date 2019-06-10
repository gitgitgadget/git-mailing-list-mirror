Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7C41F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfFJRqw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:46:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35923 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbfFJRqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:46:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so219358wmm.1
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 10:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WDogEn2rIQXCRsgZYhwLygMcPSg0CS1lgD6ra2W8OYQ=;
        b=oOj9UF3TL8mhUtHfBUgGvg04iOHldVrWXDEMInmwei9rhUkwcsDKHvBhTEkLd5P9ZL
         lEUiYrumACYoBxwEIYHHhq3IgNQn8ktn3xHy4/kfpaC7U3RuLEqS2a3rHMWwIqCy2SNZ
         IJpYOsPApnqSzsB5HVytlYv7e2W1WATrZikqe3Z8OWd+c5nTyLUxdVapW4gCLN3k8X81
         DmWVubI+HZl72mLX+Kof3Lx6jMUdkkXpUiZ5JpVO28/z78b/7MUe4X5PDCKAPmyhPtqM
         1YNNYn05QLzYuzZ7R8BGeeMLhHVawSfCc3ikp8gjN4ulroPTUozPKkEbSJVjPF9gEd3X
         Dg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDogEn2rIQXCRsgZYhwLygMcPSg0CS1lgD6ra2W8OYQ=;
        b=elx83t6nzGqfMNWUATCtPAStRfjKj87EutuhGyXlOzPj94sxIAkjadkLnK/Kx5vmzd
         scEDstXw4Q550hv8i+kQdFAn3erfHBJR8EDqAlmAS2nvCJ3lrqX8q/9ldLVHWCfnfl6U
         IixWd94m57Gkn9y7DK90RSZxRrrvmsIOYeVLXOjz5PSDP8lXyNGyF5o1tGwHVLfEG4W0
         mWpoYvaTpb9yL6K8PVtSlV9OKgvrpt6TMfFK+eby0pNwVtqtg5fT+yjo60CxY936PfBi
         r8PgdLojP6/NAndHC/A93jKBR9q/kildV6ITTZ+W/KlmN4mSemAZnOaAJmSDSkEj1Sut
         +dfA==
X-Gm-Message-State: APjAAAW+WKNcKgTAasXT7hCrwN2jsoo0Z5R8+2GI2w2djDxjzBVVyUb/
        8KVtaq7wtbkaTU8KH5aRJECP6Lec
X-Google-Smtp-Source: APXvYqxe9oAqj1QpWZEiausZLrWmRzZNfYwc+9CMUUR3zXynbGga3CGSYpBsGQnkVXp7skw5yCRmiQ==
X-Received: by 2002:a1c:80c1:: with SMTP id b184mr13244653wmd.24.1560188809814;
        Mon, 10 Jun 2019 10:46:49 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id f2sm140996wmc.34.2019.06.10.10.46.48
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:46:49 -0700 (PDT)
Subject: Re: [GSoC][PATCH 2/3] cherry-pick/revert: add --skip option
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com
References: <2488ef91-b9e5-1836-aeea-2aaf11c3c383@gmail.com>
 <20190610134321.8203-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <00733b69-7c9d-2aba-42e3-3a2f85f29007@gmail.com>
Date:   Mon, 10 Jun 2019 18:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610134321.8203-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 10/06/2019 14:43, Rohit Ashiwal wrote:
> Hi Phillip
> 
> On 2019-06-10 10:40 UTC Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> [...]
>> It's actually a bit more complicated as if the cherry-pick failed
>> because it would have overwriten untracked files then CHERRY_PICK_HEAD
>> will not exist but we want to be able to skip that pick. So it should
>> not error out in that case either. (I think you may be able to use the
>> abort safety file (see rollback_is_safe()) to distinguish the 'failed to
>> pick case' from the 'user committed a conflict resolution' case.)
> 
> Oh! I was thinking about some other case. (spawing another cherry-pick,
> which is wrong since the topic is --skip). I'm sorry. 
> 
>>> Yes, .git/{REVERT|CHERRY_PICK}_HEAD will not exist in this case, but
>>> in case of cherry-picking/reverting:
>>>
>>> 1. multiple commits:
>>>     sequencer dir will exist which will throw out the error listed
>>>     under `create_seq_dir`
>>
>> I don't understand. Wont it will error out here? Why would we call
>> create_seq_dir() for --skip?
> 
> No, you are correct. This won't skip commit in this case. I'll change
> it to do the required.

Shout if you get stuck. I think distinguishing the "user committed a
conflict resolution and so we don't want to skip" from the "the pick
would have overwritten an untracked file so we do want to skip" cases
should be possible by calling rollback_is_safe(). It would be good to
have a test case for at least the "pick would have overwritten an
untracked file case" as that would be easy to break in the future
without noticing as it's a rare situation.

> 
>>>> If rollback_single_pick() sees that HEAD is the null oid then it gives
>>>> the error "cannot abort from a branch yet to be born". We're not
>>>> aborting and if we're picking a sequence of commits the skip ought
>>>> succeed, but it won't at the moment. If we're picking a single commit
>>>> then the skip should probably fail like abort but with an appropriate
>>>> message. Admittedly that's all a bit of a corner case.
>>>
>>> Yes, you are right here. We could actually modify the advice there
>>> to be more like _("cannot perform the specified action, the branch
>>> is yet to be born") and I think it should suffice this. What do you
>>> think?
>>
>> I think it should allow the user to skip if there are more commits to
>> pick . Just changing the error message does not fix that.
> 
> Right! I'll check what can be done here.

I think you can just pass a flag to rollback_single_pick() to tell it
whether it is rolling back for --skip or --abort so it can do the right
thing.

Best Wishes

Phillip

> 
>>> The overall test tests that only, if cherry-pick --skip "failed" then
>>> we won't get 'e' inside of `foo` and `test_cmp expect foo` will also
>>> fail and if it skipped wrongly then expect.log will not match the
>>> actual.log and `test_cmp` will fail. Am I missing something here?
>>> Please tell if so.
>>
>> You're right that the tests at the end would probably pick up a failure,
>> but I'm concerned that there could be some obscure corner case we've not
>> thought of so checking HEAD and the file contents here would be an
>> additional safety measure. It also makes it easier for someone tracking
>> down a test failure to see what happened. If they rely only on the test
>> at the end they need to spend time to understand where the mismatched
>> contents came from.
> 
> Yes, it is worth checking here if HEAD after cherry-picking is in the
> correct position, same for the file foo. I'll change this test too.
> Thanks for pointing out.
> 
> Thanks for the review
> Rohit
> 

