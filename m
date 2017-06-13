Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE22720D0C
	for <e@80x24.org>; Tue, 13 Jun 2017 21:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbdFMVGs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:06:48 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36406 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753862AbdFMVGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:06:46 -0400
Received: by mail-pf0-f171.google.com with SMTP id x63so73448873pff.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BdLYotMQb68dHe4kJCaYPkQsCEpL2edmiTN125qBgJU=;
        b=NTtnj+ui23uyp17mACRtYXdaVHh0dd4GuHZKVdvtEaukR2UJhosOxLg1h3KF+cE3TW
         864wWMqcLrduA1UHe6F/4EfDcoZN0P6C5KeT4DRg/60k+H/UsVOsg/iU+VN6cD6L2AIv
         dEuBo3sBLP61U36w1+Z+ZZOgy9jf3TISLVLBLn1Lpr20c+7hrEpCl79pVOUsn+YuPu0c
         2RGyr9hMXL5/I5rupoIXGeqTNeMDV6jQv8M9eDqiIIFDq5YNIoGuTgNIfXGF3H1O0psc
         nG3YQzA2kSlGHdjt3SCpwsBPyJeDRCb9+ScSlriwJbnw7oHN+QWcOtmPcDJIyxQtvZ0a
         E+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BdLYotMQb68dHe4kJCaYPkQsCEpL2edmiTN125qBgJU=;
        b=GnWXG4D9ZQ4ZIXzgOlCwXS5bkgGN1tjlrsvBQjRIi0sGBQbTO47XpbWaZr8ujhX/pl
         XGR4ejPeV8BppYK9Oy+sxPf/yotYQOzeU6EroZtPprdlmJAFyEC3P+XzyLsNFyutECWw
         paN7MvxXwD5/9m9/QtJT0Cg2ExwWOGq1fwOnMXxpHTl8o7pFDRAAGheydae94IBK2TwZ
         4VRKG5pt+/j9NEBfKm2yZttPzyMpJPSGRbfuTbcA6DThQ5tUtkPoKBlzCn3IwWbEFRqm
         RWaAnXLz/hC9fJvtwKF2rqJQ44XwFFiF4IQbc5Drk/jJqdlA9jy+DDVC81XALogBOwm/
         d2pw==
X-Gm-Message-State: AKS2vOwqFgb51jBzZ8nsECE8//htr2w5wdzuseef4rc6XJMkoX7DbA3G
        aga1wO+B01p/2OQt1WLvLjhzDIHs3l30znVAcg==
X-Received: by 10.98.63.10 with SMTP id m10mr1246145pfa.19.1497388000507; Tue,
 13 Jun 2017 14:06:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 14:06:40 -0700 (PDT)
In-Reply-To: <xmqqo9tr660x.fsf@gitster.mtv.corp.google.com>
References: <20170607185354.10050-1-sbeller@google.com> <xmqqo9tr660x.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 14:06:40 -0700
Message-ID: <CAGZ79kZdUARvhO=UwexFGkWQzsYSnyyiXJMX69W9ofhz13zjHQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] submodules: overhaul documentation
To:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding two native speakers as we start word smithing.

On Tue, Jun 13, 2017 at 12:29 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> +
>> +A submodule is another Git repository tracked in a subdirectory of your
>> +repository. The tracked repository has its own history, which does not
>> +interfere with the history of the current repository.
>
> "tracked in a subdirectory" sounds as if your top-level superproject
> has a dedicated submodules/ directory and in it there live a bunch
> of submodules.  Which obviously is not what you meant.  If phrased
> "tracked as a subdirectory", I think the sentence makes sense.

Given this explanation "as a" also sounds wrong[1], maybe we need to
separate (1) where it is put/mounted and (2) the fact that is tracked,
i.e. the superproject has an idea of what should be there at a given
revision. (I shortly thought about /s/as a/using/ in the above, but):

  A submodule is another Git repository at an arbitrary place inside
  the working tree, and also tracked. The tracked repository has its
  own history, which does not interfere with the history of the current
  repository.

[1] http://www.thesaurus.com/browse/as

>
> While "which does not interfere" may be technically correct, I am
> not sure what the value of saying that is.

I think we can drop it here. When writing I wanted to separate it from
subtrees, but this is the wrong place for that.

>
>> +Submodules are composed from a so-called `gitlink` tree entry
>> +in the main repository that refers to a particular commit object
>> +within the inner repository.
>
> Correct, but it may be unclear to the readers why we do so.  Perhaps
>
>         ... and this way, the tree of each commit in the main repository
>         "knows" which commit from the submodule's history is "tied" to it.
>
> or something like that?

sounds good to me.

>
>> +Additionally to the gitlink entry the `.gitmodules` file (see
>> +linkgit:gitmodules[5]) at the root of the source tree contains
>> +information needed for submodules.
>
> Is that really true?  Each submodule do not *need* what is in
> .gitmodules; the top-level superproject needs to learn about
> its submodules from the contents of that file, though.

Ha! The ediled words in my mind were:

 ... information needed for submodules [to work in the superproject].

But maybe we need to reword that as

  Additionally to the gitlink entry the `.gitmodules` file (see
  linkgit:gitmodules[5]) at the root of the source tree contains
  information on how to handle submodules.

I'd like to keep this part short and not go into detail.

>
>> +The only required information
>> +is the path setting, which estabishes a logical name for the submodule.
>
> The phrase "the path setting" feels a bit unfortunate.  Is that
> "only" thing we need?  Without URL we have no way to populate it,
> no?

    git config -f .gitmodules submodule.foo.path foo
    git config submodule.foo.url example.org/foo
    git submodule update --init

ought to work just fine. It is not the recommended way of working,
but it should work.

I think (in the far future) we actually should only have the path information
in-tree and *any* other information outside the tree, which includes the URL,

See[2], where I state how I'd like to shape the future:

  $ cat .gitmodules
  [submodule "sub42"]
    path = foo
  # path only in tree!

  $ cat .git/config
  ...
  [submodule]
    active = .
    active = :(exclude)Irrelevant/submodules/for/my/usecase/*
  # note how this is user centric

  $ git show refs/meta/magic/for/refs/heads/master:.gitmodules
  [submodule "sub42"]
    url = https://example.org/foo
    branch = .
  # Note how this is neither centering on the in-tree
  # contents, nor the user. Instead it focuses on the
  # project or group. It is *workflow* centric.
  # Workflows may change over time, e.g. the url could
  # be repointed to k.org or an in-house mirror without tree
  # changes.

Jonathan pointed out the ref name is chosen poorly, but conceptually
I would want to keep the URL setting outside the tree. The URL may
change over time, independently from the history currently checked out
(think of bisect, that includes an "submodule update --init" to bisect across
a fully populated superproject 'at the time')

[2] https://public-inbox.org/git/CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com/




>
>> +The usual git configuration (see linkgit:git-config[1]) can be used to
>> +override settings given by the `.gitmodules` file.
>> +
>> +Submodules can be used for two different use cases:
>> +
>> +1. Using another project that stands on its own.
>> +  When you want to use a third party library, submodules allow you to
>> +  have a clean history for your own project as well as for the library.
>> +  This also allows for updating the third party library as needed.
>> +
>> +2. Artificially split a (logically single) project into multiple
>> +   repositories and tying them back together. This can be used to
>> +   overcome deficiences in the data model of Git, such as:
>
> s/deficiences in the data model/current limitations/ perhaps?

makes sense.

>
>> +* To have finer grained access control.
>> +  The design principles of Git do not allow for partial repositories to be
>> +  checked out or transferred. A repository is the smallest unit that a user
>> +  can be given access to. Submodules are separate repositories, such that
>> +  you can restrict access to parts of your project via the use of submodules.
>
> Some servers implement per-branch access control that seems to work
> rather well.

True. So maybe s/partial repository/partial working tree/

> Given that "shallow history" is possible (i.e. you
> could give one commit without exposing older parts of the history),
> I think the limitation this paragrah refers to is that "a tree is
> the smallest unit that the user can be given access to."

yes. Though in theory (with the work on omitting blobs and potentially trees)
we could omit partial trees as well and just tell the user they cannot have it.

>
>> +* In its current form Git scales up poorly for very large repositories that
>> +  change a lot, as the history grows very large. For that you may want to look
>> +  at shallow clone, sparse checkout, or git-LFS.
>> +  However you can also use submodules to e.g. hold large binary assets
>> +  and these repositories are then shallowly cloned such that you do not
>> +  have a large history locally.
>
> This is why I suggest "current limitations"; this is not about
> deficiency in the data model.

ok.

>
>> +A submodule can be considered its own autonomous repository, that has a
>> +worktree and a git directory at a different place than the superproject.
>
> "Its own" I agree, but autonomous?

I'll drop that word.


>> +Workflow for an artifically split repo
>> +--------------------------------------
>> +
...
>> +
>> +  # change worktree
>> +  git checkout
>> +  git reset
>
> This part is interesting ;-)

and the problem is this is still in flux ...


>
>> +Deleting a submodule
>> +--------------------
>> +
>> +Deleting a submodule can happen on different levels:
>> +
>> +1) Removing it from the local working tree without tampering with
>> +   the history of the superproject.
>> +
>> +You may no longer need the submodule, but still want to keep it recorded
>> +in the superproject history as others may have use for it.
>> +--
>> +  git submodule deinit <submodule path>
>> +--
>> +will remove the configuration entries
>> +as well as the work
>
> Do we have an adjective used for submodules that are checked out
> vs deleted in this manner (I am thinking of "active" from earlier
> work by Brandon)?  Do we want to mention it around here?

We'd want to propagate "active" more throughout our documentation,
too.

I think this state would be called "unpopulated" (as: the working
tree is not populated, no hint wither the git dir of the submodule
exists)

>
>> +2) Remove it from history:
>> +--
>> +   git rm <submodule>
>> +--
>
> Is this removing from "history"?  Isn't it merely removing it from
> the index of the superproject (hence potentially removing it from
> the tree of the upcoming commit in the superproject)?

True.

>
>> +3) Remove the submodules git directory:
>> +
>> +When you also want to free up the disk space that the submodules git
>> +directory uses, you have to delete it manually. It is found in
>> +`$GIT_DIR/modules`.
>> +The steps 1 and 2 can be undone via `git submodule init` or
>> +`git revert`, respectively.  This step may incur data loss,
>> +and cannot be undone. That is why there is no builtin.
>
> Perhaps "deinit" can learn an option to do this (tangent).  When you
> are a follower, it is OK to do so.
>
> When you are removing the only copy of the repository, of course
> there will be some data loss ;-)

Good point. deinit seems to be the logical place to put it.
Although we could also argue to not hide it in a flag of deinit,
but have a new subcommand "git submodule delete" that removes
the working tree and the git dir, but not the gitlink.

>> +Other mechanisms
>> +----------------
>> +
>> +Git repositories are allowed to be kept inside other repositories without
>> +the need to use submodules. This however does not enable cross-repository
>> +versioning as the inner repository is unaware of the outer repository,
>> +which in turn ignores the inner.
>
> s/the inner/& repository/;
>
>> +Submodules are not to be confused with remotes, which are other
>> +repositories of the same project; submodules are meant for
>> +different projects you would like to make part of your source tree,
>> +while the history of the two projects still stays completely
>> +independent and you cannot modify the contents of the submodule
>> +from within the main project.
>
> Would anybody make such a confusion, though?  Perhaps drop the first
> sentence up to ';' in a follow-up patch?

This code was moved from the current git-submodule man page.
I questioned this confusion as well. Maybe this was confusing when
it was new?

Will remove.

>
>> +If you want to merge the project histories and want to treat the
>> +aggregated whole as a single project from then on, you may want to
>> +add a remote for the other project and use the 'subtree' merge strategy,
>> +instead of treating the other project as a submodule. Directories
>> +that come from both projects can be cloned and checked out as a whole
>> +if you choose to go that route.
>
> While it is correct, is this something we want to mention in
> gitsubmodule.txt?  It sounds more like what "git merge" should say,
> if we wanted to.

The section "Other mechanisms" would want to point out all
things that are useful for slightly different use cases, which includes
sub trees?

>
> Thanks.
