Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56152202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdGMPhW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:37:22 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:38334 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdGMPhV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:37:21 -0400
Received: by mail-it0-f46.google.com with SMTP id k192so49275269ith.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NDzMYPjmZSkWsvUDEpsaoNA7r+ZdLyu32jo1vnqw/Tg=;
        b=mn44bYqy4AN+YdVHWsPFQpit/fHld9DW/acZkzgteXDZ0sKNLQGSWuCMnZXHAa4cra
         05NTJBAnhM7/HOry59GA333Gn380RiqT5bZ2xW4vlIQb9PMqoR6NsNpGWan7u0L+ZNUu
         PaL80TplsPQDEvEwlgvpbA044jMhdsecF3Mm4RnuhRQEraLUucErPYyuvQfpa9oSGS8g
         p3oEm9B+uwGip6uqqSsE/AD4DDO4i0FuymCTUlkqEneBiKhooD4Lfd/Cy9hOCkgHu6wY
         4Uh8xKro+ij8NkaXXtTRRVSgisPXq6ZSQHOvwB2TS2CwsfRz9AAIJtsrv858I8txZ9S7
         HkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NDzMYPjmZSkWsvUDEpsaoNA7r+ZdLyu32jo1vnqw/Tg=;
        b=cR2QcGCeaKWmTNX/wFhWRbZaZfdbVMRPenORS5S5y6xTOPcqiwBn4elbytYo/kYhQY
         pi/hCRr7NXsjqVrVOBkFLcPSqDV/4wOvUHYBkHy1hG4SNak2jADcv1vwPz/5vNc/chIR
         kf/pH+L9hnGq8ePzGZWYrnK+AUnwBdPViQt3GfjmcvH2aqqa1/64gZ8f8ss9da1wCesK
         KBX3Q1nZXDh9g7qKkI8K3JiNzeSWFvsHA/22h2iR8IDShCkzGctjsi/fxvMx0vKYrzzB
         fMEXC0draejE7ZXVKHOPivPFgXhbLZlsTj2YI7RtO6mTWy3RsotsPDfVppxLBsD7svgd
         EcnA==
X-Gm-Message-State: AIVw110H8RUt341gp4+OHy68++4JlIGZMclrx+Olxj10NxzDaFenrBSv
        YO+xWSh9D4lI3EFuDs8btOPZx4s6Aw==
X-Received: by 10.107.144.134 with SMTP id s128mr3891297iod.166.1499960240862;
 Thu, 13 Jul 2017 08:37:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Thu, 13 Jul 2017 08:37:20 -0700 (PDT)
In-Reply-To: <6e4096fd-cbab-68f0-7a23-654382cb810e@gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <B5FDF25C-ED5A-4CD1-AAD7-04BD8D705C59@gmail.com> <6e4096fd-cbab-68f0-7a23-654382cb810e@gmail.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Thu, 13 Jul 2017 11:37:20 -0400
Message-ID: <CAEcERAxRmRh5pp=nXN7X9u=HQsJdSQfsXoedM_5eCDgDWwAkKg@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the detailed explanation, it looks like merging the
commits would be helpful in my case. And I think it is a very good
analogy that Perforce changelists are like multiple pending committs,
if Git were supporting such.

What it won't be achieving by using commits in this schema is the
following thing I can do in Perforce:
In the uncommitted Perforce changelists I can revert the changed file
to the original state and move the files between the changelists.
Quite often, while working on something, in the middle I would decide
to isolate changes to a certain set of files to a separate changelsit
- but then I might change my mind. It is all flexible until I actually
commit my Perforce changelist, after which it becomes very much as
committed changes in any other source control.
This is actual flexibility I am looking for achieving in Git.


On Tue, Jul 11, 2017 at 6:46 PM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> For starters, let me say that I consider myself a mere advanced
> beginner Git user, and I haven`t used Perforce ever before (did some
> reading now), but still, for what it`s worth, here are my thoughts,
> please bare with me :)
>
> Do feel free to correct me if I miss something.
>
> On 11/07/2017 19:39, Lars Schneider wrote:
>>
>>> On 11 Jul 2017, at 17:45, Nikolay Shustov <nikolay.shustov@gmail.com> wrote:
>>>
>>> Hi,
>>> I have been recently struggling with migrating my development workflow
>>> from Perforce to Git, all because of the following thing:
>>>
>>> I have to work on several features in the same code tree parallel, in
>>> the same Perforce workspace. The major reason why I cannot work on one
>>> feature then on another is just because I have to make sure that the
>>> changes in the related areas of the product play together well.
>>>
>>> With Perforce, I can have multiple changelists opened, that group the
>>> changed files as needed.
>>>
>>> With Git I cannot seem to finding the possibility to figure out how to
>>> achieve the same result. And the problem is that putting change sets
>>> on different Git branches (or workdirs, or whatever Git offers that
>>> makes the changes to be NOT in the same source tree) is not a viable
>>> option from me as I would have to re-build code as I re-integrate the
>>> changes between the branches (or whatever changes separation Git
>>> feature is used).
>>> Build takes time and resources and considering that I have to do it on
>>> multiple platforms (I do cross-platform development) it really
>>> denominates the option of not having multiple changes in the same code
>>> tree.
>>>
>>> Am I ignorant about some Git feature/way of using Git that would help?
>>> Is it worth considering adding to Git a feature like "group of files"
>>> that would offer some virtutal grouping of the locally changed files
>>> in the checked-out branch?
>>
>> Interesting question that came up at my workplace, too.
>>
>> Here is what I suggested:
>> 1. Keep working on a single branch and make commits for all features
>> 2. If you make a commit, prefix the commit message with the feature name
>> 3. After you are done with a feature create a new feature branch based on
>>    your combined feature branch. Use `git rebase -i` [1] to remove all
>>    commits that are not relevant for the feature. Alternatively you could
>>    cherry pick the relevant commits [2] if this is faster.
>>
>> I wonder what others think about this solution. Maybe there is a better
>> solution that I overlooked?
>>
>> - Lars
>>
>> [1] https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history
>> [2] http://think-like-a-git.net/sections/rebase-from-the-ground-up/cherry-picking-explained.html
>
> This "single branch, related commits" approach is exactly what came
> to my mind as well.
>
> But, isn`t Perforce "changelist" an "atomic" group of changes - like
> "commit" in Git, "changeset" in Team Foundation Version Control,
> etc...?
>
> If so, it would mean that this "multiple pending changelists" flow
> would/should be translated to "multiple pending commits" in Git,
> where in the end _a single_ Perforce "changelist" is _a single_ Git
> "commit".
>
> Might be this is where the confusion is coming from, trying to fit
> natural Git "multiple commits per feature" (but "single feature per
> branch") concept into a "single changelist per feature" Perforce
> concept, described/required here?
>
> I don`t think there is a firm concept of such "multiple pending
> commits" in Git, but the point is the author is having multiple
> changelists/commits, and it actively updates them (the _same ones_),
> until they`re ready to be merged (submitted, in Perforce)... which
> you can do in Git, and might be quite easily :)
>
> So... In Git, you can create a separate commit for each changelist
> you have in Perforce (all these commits being on the same branch, as
> desired). Then, when you would have wanted to "update" the pending
> Perforce changelist (not sure what the corresponding command is in
> Perforce), you would just `git commit` your current state with
> additional "--squash" or "--fixup" parameters (depending on if you
> would like to add more description to existing/original commit
> message, or not), and the original commit SHA1.
>
> In the end, when everything is tested together and you would like to
> commit features separately (like submitting changelists in Perforce),
> you would just need to `git rebase -i --autosquash` your branch,
> where Git would squash all your "update" commits (fixup/squash ones,
> that is) to the original/initial ones you made as per your
> changelists/features. No need for manual rearranging, cherry-picking,
> or whatever.
>
> An example flow, with two "changelists" for two features (I`ll be
> using capital letters A, B, C... instead of commit SHA1, for
> simplicity):
>
>         ... do some "Feature 1" work...
>         $ git commit -m "Feature 1"
>         ... do some "Feature 2" work...
>         $ git commit -m "Feature 2"
>         ... do some "Feature 1" work...
>         $ git commit --fixup A
>         ... do some "Feature 1" work...
>         $ git commit --fixup A
>         ... do some "Feature 2" work...
>         $ git commit --squash B
>         ... do some "Feature 1" work...
>         $ git commit --fixup A
>         ... do some "Feature 1" work...
>         $ git commit --squash A
>         ... do some "Feature 2" work...
>         $ git commit --fixup B
>
>
> Branch history would look something like this (H is latest commit):
>
>         H fixup! Feature 2
>         G squash! Feature 1
>         F fixup! Feature 1
>         E squash! Feature 2
>         D fixup! Feature 1
>         C fixup! Feature 1
>         B Feature 2
>         A Feature 1
>
>
> When you finally do `git rebase -i --autosquash A^`, you should get a
> list like this[1]:
>
>         pick A Feature 1
>         fixup C fixup! Feature 1
>         fixup D fixup! Feature 1
>         fixup F fixup! Feature 1
>         squash G squash! Feature 1
>         pick B Feature 2
>         squash E squash! Feature 2
>         fixup H fixup! Feature 2
>
>
> Once rebase is finished, you`ll end up with branch history looking
> like this:
>
>         B' Feature 2
>         A' Feature 1
>
> ... where commits A, C, D, F and G have been squashed into a single
> commit A', and commits B, E and H have been squashed into a single
> commit B'. These two single commits should correspond to your two
> Perforce changelists.
>
> Now you can merge your commits separately, as desired ("submit" the
> "changelists").
>
> You can even first rearrange/split/squash them further, or make
> separate branches out of them, whatever you find appropriate - you
> can do whatever you like to them while they`re your local commits
> ("pending changelists"), before making them live/visible for other
> users as well (merge them to a public branch, "submit changelist").
>
> p.s. Doesn`t the flow required here look similar to Mercurial patch
> "queues" approach (again, resembling "quilt" functionality)? If so,
> "Guilt"[2] may be an option here as well... if the described flow
> can`t be altered a bit to align better with Git itself, might be
> profiting on the side of overall workflow simplicity ;)
>
> [1] Having commits automatically grouped/ordered, you can even
>     replace some "fixup" and "squash" with "reword", for example, so
>     those commits are kept as separate ones, providing you a chance
>     to edit their messages.
> [2] http://repo.or.cz/w/guilt.git
>
> Regards,
> Buga
