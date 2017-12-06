Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B87320C11
	for <e@80x24.org>; Wed,  6 Dec 2017 17:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbdLFR6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 12:58:40 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:43982 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdLFR6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 12:58:39 -0500
Received: by mail-pg0-f45.google.com with SMTP id b18so2492277pgv.10
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=huR5g+FdBmEoGHtcQlaAosmwEPquZKBxWUbgf/92PRQ=;
        b=jGiosX8+Mp3xre4X40noeSSXAXYW6lSMVRP/ThYcWwQx42dqd1QJk/EGgSgj2SQ9vf
         fMhTrMZPe7TXkl5tSfjirIxXyNcMJjz8cNtA75zqaaDrSyLPUb7g5kiQlxtgEP0fPnhv
         4/blw8FbPOfQ+jztmbRSLVRlJmLK27i9eaB3OSfUq3P+/qJ/ycBqXaA6+yLhtLC0jcJN
         MWTESBxzONS7BNXYWR4zah5G0UiibcPWFhDEDhL6Sgtd6SQKFoxO9hIsdseuYkK3XLAt
         3tRVw2079/XYnNBUfcuw8+8pZnMTW3VIY/EHhYGafxH+22N5Wyr4wDY21/9j0J30tpJZ
         bmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=huR5g+FdBmEoGHtcQlaAosmwEPquZKBxWUbgf/92PRQ=;
        b=rylZaeRF4s3fT5RjTSJV6BHjAMKAk01BYC+0fr4LJU1hLULbCefahIfFFEWEDsCi2K
         yOUzpgyAjbJaOAkkB7n7rGK2NiYiybqsF+WkUiBLqHJUvhKKhDfyqYTWfX5r6VfFjwo2
         ZIBqHAYHXpGX3+o9vZJnxWuOYOvOq5QGmoA45TMM1OO5I1Y22hxZlnlAj8zeoiB1BSbK
         PireBOvmEkNB91nd0BRiNBGW3KTo85ns9QcaT3qKJ0UlOXGP60TFggB1FGEG+VK+pztH
         uP8tOVSD69CLSx1+Tnpum5pIaXeFgSJ7OZIlB/e1EfvFBi/JWWD1zrSiEw7ocaUxpX/9
         kLWg==
X-Gm-Message-State: AKGB3mKd00fKHVUX6y6jMcfeXRJ4eWbqBADY19OeGAssG+CLp5pBC1v0
        Yfy6ch/+Mt3MXsgo277qrefe+k6a
X-Google-Smtp-Source: AGs4zMY85U5YkTOr4RZDWZpKG79VQexfcpOUDWYxXfoO68gRtw6usJdw507Pz9vh4ZNhSwQMFtDF2A==
X-Received: by 10.98.202.217 with SMTP id y86mr3720464pfk.118.1512583118922;
        Wed, 06 Dec 2017 09:58:38 -0800 (PST)
Received: from [192.168.206.100] ([117.249.232.162])
        by smtp.gmail.com with ESMTPSA id q7sm5376292pgf.26.2017.12.06.09.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 09:58:37 -0800 (PST)
Subject: Re: [PATCH v3 2/2] Doc/check-ref-format: clarify information about
 @{-N} syntax
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <xmqqd14386sw.fsf@gitster.mtv.corp.google.com>
 <20171128163406.15452-1-kaartic.sivaraam@gmail.com>
 <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <59e24608-cf7e-6654-90a2-95e6dc22dc3d@gmail.com>
Date:   Wed, 6 Dec 2017 23:28:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq609olg1p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday 03 December 2017 07:38 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>>
>> NOTE: Though a commit-hash is a "syntactically" valid branch name,
>> it is generally not considered as one for the use cases of
>> "git check-ref-format --branch". That's because a user who does
>> "git check-ref-format --branch @{-$N}" would except the output
>> to be a "existing" branch name apart from it being syntactically
>> valid.
> 
> s/except/expect/ I suspect.

Correct suspicion.


>  But I do not think this description is
> correct.  "check-ref-format --branch @{-1}", when you come from the
> detached HEAD state, happily report success so it does not hold that
> it is "generally not considered".
> 
> Unless you are saying "check-ref-format --branch" is buggy, that is.

I was thinking it was "buggy" from v1 of this patch. The `--branch` 
option is expected to be used by porcelains but they are also wanted to 
be aware that the output might NOT be a branch name when the @{-N} 
syntax is used[1]. This sounds unintuitive given the name of the 
option(`--branch`). No user would expect anything but a branch name from 
such an option, I guess. At least, I don't. So, I thought clarifying the 
Doc was a good "first step" (the Doc guaranteed more than it should).


> If so, we shouldn't be casting that buggy behaviour in stone by
> documenting, but should be fixing it.
> 

Yes. I wasn't sure how to go about fixing it and thus took the easier 
way of updating the Doc. I also think it would be a good way to trigger 
discussion. Now that the attention has come, any ideas about how it 
could be FIXED? Should we drop support for @{-N} option in 
check-branch-ref (highly backward incompatible)? Should we check if 
@{-$N} is a branch name and fail if it's not(not such a bad thing, I guess)?


> And the paragraph that leads to this NOTE and this NOTE itself are
> both misleading from that point of view.  The result *is* always a
> valid branch name,
I wasn't referring to "syntactic validity" when I mentioned "valid" in 
the commit message. Though, I understand how I wasn't clear by not 
disambiguating.


> 
> Taking the above together, perhaps.
> 
>      When the N-th previous thing checked out syntax (@{-N}) is used
>      with '--branch' option of check-ref-format the result may not be
>      the name of a branch that currently exists or ever existed.
>      This is because @{-N} is used to refer to the N-th last checked
>      out "thing", which might be any commit (sometimes a branch) in
>      the detached HEAD state.

I don't get the "... any in the detached HEAD state ..." part. I seem to 
interpret it as "@{-N}" always returns commits from the detached HEAD 
state. How about,

     When the N-th previous thing checked out syntax (@{-N}) is used
     with '--branch' option of check-ref-format the result may not be
     the name of a branch that currently exists or ever existed. This
     is because @{-N} is used to refer to the N-th last checked out
     "thing", which might be a commit object name if the previous check
     out was a detached HEAD state; or a branch name, otherwise. The
     documentation thus does a wrong thing by promoting it as the
     "previous branch syntax".


> 
>      State that @{-N} is the syntax for specifying "N-th last thing
>      checked out" and also state that the result of using @{-N} might
>      also result in an commit object name.
> 

This one's nice.


>> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
>> index cf0a0b7df..5ddb562d0 100644
>> --- a/Documentation/git-check-ref-format.txt
>> +++ b/Documentation/git-check-ref-format.txt
>> @@ -78,17 +78,20 @@ reference name expressions (see linkgit:gitrevisions[7]):
>>   . at-open-brace `@{` is used as a notation to access a reflog entry.
>>   
>>   With the `--branch` option, the command takes a name and checks if
>> -it can be used as a valid branch name (e.g. when creating a new
>> -branch).  The rule `git check-ref-format --branch $name` implements
>> +it can be used as a valid branch name e.g. when creating a new branch
>> +(except for one exception related to the previous checkout syntax
>> +noted below). The rule `git check-ref-format --branch $name` implements
> 
> And "except for" is also wrong here.  40-hex still *IS* a valid
> branch name; it is just it may not be what we expect.  So perhaps
> rephrase it to something like "(but be cautious when using the
> previous checkout syntax that may refer to a detached HEAD state)".
> 

Nice suggestion.


>> +`@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
>> +was checkout using "git checkout" operation. This option should be
> 
> s/was checkout/was checked out/;
>

Good catch.


>> +used by porcelains to accept this syntax anywhere a branch name is
>> +expected, so they can act as if you typed the branch name. As an
>> +exception note that, the ``previous checkout operation'' might result
>> +in a commit hash when the N-th last thing checked out was not a branch.
> 
> s/a commit hash/a commit object name/;
> 

Ok.


[1]: Though the users are not currently warned about the weird behaviour 
when they use the @{-N} syntax, they would be expected to check for 
commit object name at least after this patch get in. We warn them.
