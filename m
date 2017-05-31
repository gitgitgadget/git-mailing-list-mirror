Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44731FD09
	for <e@80x24.org>; Wed, 31 May 2017 14:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdEaOui (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 10:50:38 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34760 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdEaOuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 10:50:37 -0400
Received: by mail-qk0-f177.google.com with SMTP id d14so13596658qkb.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kLw+nospQeon3QGvev7Cp9L8+pXKefUAtog/SsDzC4s=;
        b=PDXdgOzc257gpGX3g+IW2ZPonIk6amGDfqwSAj8mkVhPLjkfKKnDx0sRe17MY52eYT
         +xD1h74uoNwBlxXxXuQHi9BT9tD5Vd8CPffsvxTnboZT7BF8xkSeWtX+aPHn6ps4mLSd
         nMgpRYCFM0W5frMqssiX3gv90EKnaodYQJBZY1WkSHMUKkedSFrnhFueOZl9PmkXOwqI
         knqvtaYf5/5w9pzYOoZmFC4HRarg+leggy+ryqyze1vQhKv2jqbCvV0IYpB4BlPpR1hl
         WxuDyakAvC5YA0V5BlgPoA76Vi2mS0T6Darw/seteBZ2jxsZaLh49YcnKkNuhcx2Mt9d
         c2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kLw+nospQeon3QGvev7Cp9L8+pXKefUAtog/SsDzC4s=;
        b=gkOjKIEr3BHwDt3mRy2jB3MV8lQzt3akhNbnLYG+WGu7rSC4Ua7WQ2YzLW7Gr61WEY
         2BShw8E2Wztfg+H2HI/u1cEVu6/RPxMs8jJA0THM22NDo3PZJqVGYIB1Cx4XCJjeFLfH
         y0/xwIWANeWxjsSak6tGTsZ2Jpu8kRK4np8BUffKoHqTMT0oAfpYsHKazbfgo18qNTDB
         swwdt1hutpJsm428OxGuubLz7f1+ZxHWJlP4qGuGKyPPLPF8WrTivqc9cfjaQUByv+sL
         LmTmpHPEPxRFaUcseI0oDoWoPrs9Dyvn4Fp35MmeZyLz4gYndW/LiTP/vhF2+PSOhMgs
         yxgA==
X-Gm-Message-State: AODbwcAFTNl+mfRVeztr27rwsgH/MrpBGe6uJFNTKc3dRA3GODfwlIuL
        C9fVc5HujkbIZZNQDxL0O1Ecuutm2g==
X-Received: by 10.55.175.199 with SMTP id y190mr27243588qke.155.1496242236204;
 Wed, 31 May 2017 07:50:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.86.48 with HTTP; Wed, 31 May 2017 07:50:15 -0700 (PDT)
In-Reply-To: <20170530181051.GA81679@aiede.mtv.corp.google.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
 <20170530181051.GA81679@aiede.mtv.corp.google.com>
From:   John Shahid <jvshahid@gmail.com>
Date:   Wed, 31 May 2017 10:50:15 -0400
Message-ID: <CAE5=+KXPzY0QX+T26oUAHcV8HUYOCTrpuYN_Tb5cXxF71twmZQ@mail.gmail.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan. Thanks a lot for the detailed and interesting response. I
included my comments/replies inline. tl;dr;

1. I love the idea of having tools treat the repo as a unit.
2. I think propagating the refspec when no refspec is passed on the
CLI is very surprising action that should be corrected
3. I propose more changes to the git tools to support the unity view of the repo

On Tue, May 30, 2017 at 2:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi John,
>
> John Shahid wrote:
>
>> It looks like the git push recurse-submodules behavior has changed.
>> Currently with 2.13 you cannot run "git push
>> --recurse-submodules=on-demand" if the parent repo is on a different
>> branch than the sub repos, e.g. parent repo is on "develop" and
>> sub-repo on "master". I created a test that can be found here [1].
>>
>> A bisect shows that the change to propagate refspec [2] to the
>> submodules is the culprit. imho this is an undesired change in
>> behavior. I looked at the code but couldn't see an easy way to fix
>> this issue without breaking the feature mentioned above. The only
>> option I can think of is to control the refspec propagation behavior
>> using a flag, e.g. "--propagate-refspecs" or add another
>> recurse-submodules option, e.g. "--recurse-submodules=propagate"
>
> Thanks for reporting. The old behavior of "git push
> --recurse-submodules" was a little loose (it would run "git push" in
> the submodule and rely on defaults to determine the behavior) and when
> propagating refspecs we considered taking the opportunity to tighten
> that by propagating the default refspec when you run "git push
> --recurse-submodules" without a refspec.
>
> We didn't make that change. If starting over, it might be a natural
> thing to do, but we didn't want to break existing users. So
>
> git push --recurse-submodules=on-demand
>
> should continue to work as before. *puzzled*
>
> [...]
>> We have a parent repo on a branch called "develop" and a submodule on
>> a branch called "master". Prior to git version 2.13 if we had an
>> unpushed commit in the submodule and ran "git push origin develop
>> --recurse-submodules=on-demand" git would happily push the develop
>> branch of the parent repo and the master branch of the submodule,
> [...]
>> pushing to ref refs/heads/develop:refs/heads/develop
>> pushging to remote origin
>> fatal: src refspec 'refs/heads/develop' must name a ref
>> fatal: process for submodule 'sub' failed
>> fatal: The remote end hung up unexpectedly
>
> Aha, you are passing a refspec!

Yes, we are used to passing a refspec but we will be happy not to if
that preserves the old behavior. In fact, the test case I linked to
earlier does not pass a refspec. I wrote the test that way because I
initially misunderstood the commit message and thought that not
passing a refspec preserves the old behavior. Long story short, I'm
happy with whatever option we have to maintain our current workflow.

>
> Can you say more about how this change affects you? Would you be able
> to push without a refspec, or do you e.g. have scripting that was
> relying on the existing loose behavior?

as i said before, pushing without a refspec would work for us. I'm
also talking to the team to see if we can switch the branch names to
be consistent, i.e. use either "master" or "develop" both in the
parent repo and sub repos.

>
> To put this in more context: part of the ideal that
> --recurse-submodules options are trying to achieve is to allow
> thinking of a repository as a single unit, including submodules, most
> of the time. To this end, "git clone --recurse-submodules" clones a
> repository including its submodules, "git checkout
> --recurse-submodules" checks out submodules as part of a checkout
> operation, avoiding a separate "git submodule update --init" operation,
> "git fetch --recurse-submodules" fetches upstream changes for both the
> parent repository and submodules, and so on.
>
> Unfortunately "git checkout --recurse-submodules" was missing a piece,
> impacting this workflow. If I run
>
> git checkout --recurse-submodules -b develop
>
> then today this creates a "develop" branch in the superproject but not
> within submodules. This hurts the illusion of the project being a single
> unit and makes the meaning of operations like
>
> git push --recurse-submodules develop:master
>
> unclear.
>
> Ideas for next steps:
>
> 1. If "git checkout --recurse-submodules -b develop" does the right
> thing, then this situation is harder to get in in the first place.
> The series at [3] is meant to do that.
>
> 2. The error message shown above is very unclear. It leaks
> implementation details and doesn't give the user a clear hint
> about what to do to resolve it. Would some message like the
> following have helped?
>
> $ git push --recurse-submodules origin develop
> fatal: branch "develop" does not exist in submodule "sub"
> hint: use "git -C sub branch develop <sha1>" to create such a branch
> hint: or push without a branch name to push the current branch
>
> 3. Outside of the output from any particular command, we are missing
> an equivalent of "man gitworkflows" to describe how the
> --recurse-submodules options are meant to work. The series at [4]
> aims to start addressing that.

I would also add to that list, "git pull --rebase
-recurse-submodules", "git merge --recurse-submodules", etc. Otherwise
"git checkout --recurse-submodules develop" won't make much sense,
since you'll have to go to each submodules and make sure the local
branch is up to date.

I like the idea of treating the entire repo as a single unit. In fact
the new feature (to propagate refspec) is very useful to me. For
example, when working on feature branches across the entire repo. That
said, i think "git push --recurse-submodules=on-demand" should do the
least surprising action and push the current branch, where "current"
is defined wrt the repo being pushed (and "push.default" of course).
Taking the refspec from the parent repo and forcing it on the
submodules feels weird to me.

>
> Given all the above, this looks like a real and serious bug but I
> think to find a different way from --recurse-submodules=propagate to
> fix it. The idea, especially with [5], is for submodules to work
> intuitively without requiring special options. This can require more
> work in the short term getting the default behavior to work well with
> a variety of use cases but I think it is time well spent.

>
> Thoughts?
>
> Thanks and hope that helps,
> Jonathan

Yes, that definitely helped. This track of work makes more sense now.
Thanks again for the detailed response.

JS

>
>> [1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
>> [2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780
> [3] http://public-inbox.org/git/20170501180058.8063-1-sbeller@google.com/
> [4] http://public-inbox.org/git/20170209020855.23486-1-sbeller@google.com/
> [5] http://public-inbox.org/git/20170526191017.19155-1-sbeller@google.com/
