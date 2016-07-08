Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235472070D
	for <e@80x24.org>; Fri,  8 Jul 2016 19:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706AbcGHT2H (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 15:28:07 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:32784 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbcGHT2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 15:28:05 -0400
Received: by mail-vk0-f53.google.com with SMTP id b192so67117301vke.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 12:28:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8lQ6hdvJpw/YqWxnxusN98NNb7B9aRw7yPkB2DJlGm0=;
        b=im4UQPQYbOMc7nxv/C++akMCR+20lbT+k5apxKd1sWeXhXFdMMznQKIZaGSNBgTFcw
         RMl15XA89FWibKyBn0Men82V/T5P8zOuhnvXkQEFZRdsVBo6zbztCqu0LPnjwjJmUxza
         fGsiPc2eAWG0rHNv8GWXOfwsqmUEhqWs/eYEorKwwtFXyl7Dnfdbrag5fsQ4C2rb8cuS
         txUe192yYKHbVGX5C8PZ7LPxhF4VpGadExgLCDli5qe3c5lXOiO2CKzye8VqsBHHZJOa
         xYq8l+cQeWU0c+AVz0r9+N+nqyjbo/olOZKMqP8rmNlgrW5LuhoRVCwy02Fc1fxDhCiF
         W7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8lQ6hdvJpw/YqWxnxusN98NNb7B9aRw7yPkB2DJlGm0=;
        b=cCE1grU57WJHdjvvPItnnp5Yh4uY5saDJD7tZlUi271OSFmneDOy7X6ZznY3YCGezL
         V0/c9ZnFk6A3KJbVt+Mohrz9FIALeW+0njp7v0u0+2F+tfebKDum6eCIWSrDneTD286n
         V+9Rd9rPA66z0ZfmUqmCOLvxNeQbgpXtqkujZmO120ELniylDEkkJe6tdqfrJTJoyHc1
         ZiL77CsW6vX+FP1tDtGN3eNICBgFHnCcUrFJygeHXHOLTBExCUTrGN6z0lSdgqJj2t66
         ccj+mQkiUasL+zQk6a0QVkEU1RuEoNxcThHqQplQOpE4LRywYGVmRrAeX2gO0UmPvn0h
         CnVw==
X-Gm-Message-State: ALyK8tL77gS1wNJKibOTTuTzjmqtNnqPy3dMJ5FnxnFq0L032N3bgUbP3AZOHcVIGh2FGz93FmSLHxKkGJyEcg==
X-Received: by 10.176.5.3 with SMTP id 3mr3476269uax.52.1468006083385; Fri, 08
 Jul 2016 12:28:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.2.70 with HTTP; Fri, 8 Jul 2016 12:28:02 -0700 (PDT)
In-Reply-To: <xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
References: <CAP4gbxqjHzqHhPuNK8UOwPMa46g2=vcNSk1AvGjxN8s+ou-0Dw@mail.gmail.com>
 <xmqqh9cnrvp2.fsf@gitster.mtv.corp.google.com> <xmqqr3bokeib.fsf@gitster.mtv.corp.google.com>
From:	David Lightle <dlightle@gmail.com>
Date:	Fri, 8 Jul 2016 14:28:02 -0500
Message-ID: <CAP4gbxp6qKntysrkyTSWxkQNpqPzf2gHLiKpJzA-TmqO71sHyg@mail.gmail.com>
Subject: Re: Fast-forward able commit, otherwise fail
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I've been trying to think of just what to say in response, so it has
taken me some time as well as I've been experimenting with our
workflow to try some alternate approaches while we still can.

In your above scenario with Alice & Bob, wouldn't that same issue come
up in _any_ rebase workflow (--ff-only)?  From what I've read this is
a typical consequence of requiring fast-forward merges; to be
effective, the rebase step must  be more likely to succeed in a time
window than for someone to have pushed additional changes (otherwise
you end up in a loop like above).  But I don't believe that's
inherently any worse with the change I'm asking about which  would
only take that existing flag (--ff-only) and additionally create an
actual merge commit when those conditions are present.

We were previously using the fast-forward-only approach and it worked
moderately well, but there is a learning curve to it more (rebase vs
merge).  However, because we want to follow a gitflow workflow, where
topic branches are created from develop and merged back into develop,
we want to ensure that is an actual merge commit to identify the
changes that occurred on that topic branch (with --ff-only it becomes
hard to distinguish changes from one topic branch to the next).

We will still be using develop as an integration branch which will
receive testing as well, so the rebased version will still be tested
before it gets released in our scenario.  But again that is a
rebase-workflow issue more than a rebase+merge commit issue, right?

Also GitLab already has introduced a "rebase before merging" automated
tool in their product, and BitBucket has a similar request oustanding,
and both (plus GitHub) allow squashing commits as part of the merge.
In fact, I just noticed that GitLab has built in the functionality I'm
looking for even, which is what they call "Merge commit with
semi-linear history" but I'm asking whether direct support for this
approach would be reasonable.  These approaches can all produce the
"untested merged product", but they support the way the users want to
use the system as well.  I'm not saying any approach is right or wrong
as I'm not qualified enough to say.

On Wed, Jun 22, 2016 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> However, Git as a tool is not opinionated strongly enough to make it
>> hard to do these two things (independently).  I do not think it is
>> unreasonable to add a new mode of "merge" that rejects a resulting
>> history that is not shaped the way you like.  So far the command
>> rejected --ff-only and --no-ff given together, so if an updated Git
>> starts taking them together and creating a needless real merge and
>> failing only when the first parent does not fast-forward to the
>> second parent, nobody's existing workflow would be broken.
>>
>> Having said that, you need to think things through.  Sample
>> questions you would want to be asking yourself are (not exhaustive):
>>
>>  - What is your plan to _enforce_ your project participants to use
>>    this new mode of operation?
>>
>>  - Do you _require_ your project participants to always pass a new
>>    option to "git merge" or "git pull"?
>>
>>  - Do you force them to set some new configuration variables?
>>
>>  - Do you trust them once you tell them what to do?
>>
>>  - How will your project's trunk get their changes?
>>
>>  - How you prevent some participants who misunderstood your
>>    instructions from pushing an incorrectly shaped history to your
>>    project?
>
> Another thing to consider is that the proposed workflow would not
> scale if your team becomes larger.  Requiring each and every commit
> on the trunk to be a merge commit, whose second parent (i.e. the tip
> of the feature branch) fast-forwards to the first parent of the
> merge (i.e. you require the feature to be up-to-date), would mean
> that Alice and Bob collaborating on this project would end up
> working like this:
>
>  A:    git pull --ff-only origin ;# starts working
>  A:    git checkout -b topic-a
>  A:    git commit; git commit; git commit
>  B:    git pull --ff-only origin ;# starts working
>  B:    git checkout -b topic-b
>  B:    git commit; git commit
>
>  A:    git checkout master && git merge --ff-only --no-ff topic-a
>  A:    git push origin ;# happy
>
>  B:    git checkout master && git merge --ff-only --no-ff topic-b
>  B:    git push origin ;# fails!
>
>  B:    git fetch origin ;# starts recovering
>  B:    git reset --hard origin/master
>  B:    git merge --ff-only --no-ff topic-b ;# fails!
>  B:    git rebase origin/master topic-b
>  B:    git checkout master && git merge --ff-only --no-ff topic-b
>  B:    git push origin ;# hopefully nobody pushed in the meantime
>
> The first push by Bob fails because his 'master', even though it is
> a merge between the once-at-the-tip-of-public-master and topic-b
> which was forked from that once-at-the-tip, it no longer fast-forwards
> because Alice pushed her changes to the upstream.
>
> And it is not sufficient to redo the previous merge after fetching
> the updated upstream, because your additional "feature branch must
> be up-to-date" requirement is now broken for topic-b.  Bob needs to
> rebuild it on top of the latest, which includes what Alice pushed,
> using rebase, do that merge again, and hope that nobody else pushed
> to update the upstream in the meantime.  As you have more people
> working simultanously on more features, Bob will have to spend more
> time doing steps between "starts recovering" and "hopefully nobody
> pushed in the meantime", because the probability is higher that
> somebody other than Alice has pushed while Bob is trying to recover.
>
> The time spend on recovery is not particularly productive, and this
> workflow gives him a (wrong) incentive to do that recovery procedure
> quickly to beat the other participants to become the first to push.
>
> The workflow should instead be designed to incentivise participant
> to spend more time to carefully inspect the result of his rebasing
> to make sure that his changes still make sense in the context of the
> updated codebase that contains changes from others since he forked
> topic-b from the upstream, in order to ensure quality.
>
> This "push quickly immediately after rebasing without carefully
> checking the result of rebase" pressure is shared by a workflow that
> requires a completely linear history, and not unique to your
> proposed workflow, but because you also require a --no-ff merge to
> the updated upstream, robbing even more time from the project
> participants, it aggravates the problem.
