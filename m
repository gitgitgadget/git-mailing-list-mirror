Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A55F20282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdFTSSv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:18:51 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36364 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTSSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 14:18:49 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so46757635pgb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyyXtkACjnSUu1uUhx3WwoRIZrLO9Y8oiaFi6yvPNgo=;
        b=pTh9wJw6yip9X186MMXheMiCFTNMY9G5bBrMkoWxesuWiA2tbHFF865W++YwX0C0Fy
         RW6NOZdm1VOhNTa33ZbL5mFYi3A/E17SL+KnZa5Ruj1jKouz8UQ7ScOsRNWa6XaCAKTh
         60P6ckd5ftiqVlE9YAyxTcikHwt5CWdE5bzX+FkSXc/LqR8+7HILhBi60wUyxKRIuUIU
         ndvzpC5M51Mp9GbJvxQxYuCJdq4qUW2F2505z7JNGW034OyqHVXKJsZ055n7HwqH2tJO
         6zM44FLlzVyI0cKVVEHSTKKH6AkBSiF7aXtGZwj8oNTik0gezaZyZcz6QBysfGC/XtYu
         zfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyyXtkACjnSUu1uUhx3WwoRIZrLO9Y8oiaFi6yvPNgo=;
        b=r2ERVo7PrJVD/DHjdbi8NZjjHf0nPtb5piy5DU+jw6Ky+Obz7bfQHoRsXuz5TEoye2
         cQMFnkgSPKvwR4eRMqqYLx3dR/qa17tOeKHRGqHP0alYUJa0DmE2vPeGHe1znVwMVQyr
         FOJYfD8+GmN2dlEVTa3dxFWdOLYTxwl0e6lETHd/a8g11g3OQU6eEnyvYrTI8sQEFmxN
         dO+8Rp7p8ZOQX/VLybRlZQlF1AgReTmmN3j3t/ggCMaiOYTvbJxKoHiYZa5TFE8ep6Zg
         mC9z0eJJUQGojO5mzruiS1e+GWYED0CurIUzI+dJQlW47UQHon4q8p+jcZrSDgGdvAdc
         ddbA==
X-Gm-Message-State: AKS2vOw/+BzbPzjN4WZkLDy+7vnE+lfI5KnInprLfqp7+L0veToCvher
        +PohRkc/0ZKe0a/h
X-Received: by 10.99.96.204 with SMTP id u195mr16947681pgb.125.1497982728703;
        Tue, 20 Jun 2017 11:18:48 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id a79sm22289176pfj.5.2017.06.20.11.18.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 11:18:48 -0700 (PDT)
Date:   Tue, 20 Jun 2017 11:18:44 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] submodules: overhaul documentation
Message-ID: <20170620111844.1a8ebf37@twelve2.svl.corp.google.com>
In-Reply-To: <20170607185354.10050-1-sbeller@google.com>
References: <20170607185354.10050-1-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed,  7 Jun 2017 11:53:54 -0700
Stefan Beller <sbeller@google.com> wrote:

[snip]

> +DESCRIPTION
> +-----------
> +
> +A submodule is another Git repository tracked in a subdirectory of your
> +repository. The tracked repository has its own history, which does not
> +interfere with the history of the current repository.
> +
> +Submodules are composed from a so-called `gitlink` tree entry
> +in the main repository that refers to a particular commit object
> +within the inner repository.
> +
> +Additionally to the gitlink entry the `.gitmodules` file (see
> +linkgit:gitmodules[5]) at the root of the source tree contains
> +information needed for submodules. The only required information
> +is the path setting, which estabishes a logical name for the submodule.

I know that this was copied over, but this is confusing to me, so it
might be worthwhile to change it. In particular, `gitlink` is, as far as
I know, the type of the child object, not any sort of tree entry. I
would rewrite this as:

    A submodule consists of a tracking subdirectory and an entry in the
    `.gitmodules` file (see linkgit:gitmodules[5]).

    The tracking subdirectory appears in the main repository as a
    `gitlink` object (instead of a `tree` object). The parent of the
    tracking subdirectory links to this `gitlink` object through its
    hash, just like linking to a `tree` or `blob`. This `gitlink` object
    contains the hash of a particular commit object of the submodule.

    The entry in the `.gitmodules` file establishes the name of the
    submodule (to be used as a reference by other entries and commands)
    and references the tracking subdirectory as follows:

        submodule.my_submodule_name.path = path/to/my_submodule

There might also be a need to mention that when the submodule is
populated (or whatever the right term is), the tracking subdirectory in
the working tree contains both the submodule's working tree and the
submodule's Git directory.

> +The usual git configuration (see linkgit:git-config[1]) can be used to
> +override settings given by the `.gitmodules` file.

Not sure if this is relevant here.

> +Submodules can be used for two different use cases:

A creative person might come up with more, so this might be better as:

    Submodules can be used for at least these use cases:

> +1. Using another project that stands on its own.
> +  When you want to use a third party library, submodules allow you to
> +  have a clean history for your own project as well as for the library.
> +  This also allows for updating the third party library as needed.

Probably better as:

    1. Using another project while maintaining independent history.
    Submodules allow you to contain the working tree of another project
    within your own working tree while keeping the history of both
    projects separate. Also, since submodules are fixed to a hash, the
    other project can be independently developed without affecting the
    parent project, allowing the parent project to fix itself to new
    versions only whenever desired.

> +2. Artificially split a (logically single) project into multiple
> +   repositories and tying them back together. This can be used to
> +   overcome deficiences in the data model of Git, such as:

This should match the gerund used in point 1:

    2. Splitting a (logically single) project into multiple
    repositories. This can be used to overcome deficiencies in the data
    model of Git, such as:

> +* To have finer grained access control.
> +  The design principles of Git do not allow for partial repositories to be
> +  checked out or transferred. A repository is the smallest unit that a user
> +  can be given access to. Submodules are separate repositories, such that
> +  you can restrict access to parts of your project via the use of submodules.

Not sure about this point - if the project is logically single, you
would probably need to see the entire project. If this is about
different teams independently working on different subcomponents, this
seems more like point 1 (inclusion of other projects).

> +* In its current form Git scales up poorly for very large repositories that
> +  change a lot, as the history grows very large. For that you may want to look
> +  at shallow clone, sparse checkout, or git-LFS.
> +  However you can also use submodules to e.g. hold large binary assets
> +  and these repositories are then shallowly cloned such that you do not
> +  have a large history locally.
> +
> +The data model
> +--------------
> +
> +A submodule can be considered its own autonomous repository, that has a
> +worktree and a git directory at a different place than the superproject.

Isn't the worktree inside the superproject's worktree? I would write
this as:

    A submodule is its own repository, having its own working tree and
    Git directory.

> +The superproject only records the commit object name in its tree, such that
> +any other information, e.g. where to obtain a copy from, is not recorded
> +in the core data structures of Git. The porcelain layer of Git however
> +makes use of the `.gitmodules` file that gives hints where and how to
> +obtain a copy of the submodule git repository from.

I would write this as:

    Additional metadata (for example, from where this submodule was
    obtained) can be written to the `.gitmodules` file, to be used by
    the porcelain layer of Git.

> +Submodule operations can be configured using the following mechanisms
> +(from highest to lowest precedence):
> +
> + * the command line for those commands that support taking submodule specs.
> +
> + * the configuration file `$GIT_DIR/config`.

Which $GIT_DIR? The submodule or the superproject?

> + * the configuration file `config` found in the `refs/submodule/config` branch.
> +   This can be used to overwrite the upstream configuration in the `.gitmodules`
> +   file without changing the history of the project.
> +   Useful options here are overwriting the base, where relative URLs apply to,
> +   when mirroring only parts of the larger collection of submodules.
> +
> + * the `.gitmodules` file inside the repository. A project usually includes this
> +   file to suggest defaults for the upstream collection of repositories.

Which .gitmodules? The submodule's or the superproject's?

> +On the location of the git directory
> +------------------------------------
> +
> +Since v1.7.7 of Git, the git directory of submodules is stored inside the
> +superprojects git directory at $GIT_DIR/modules/<submodule-name>

Missing period at end of sentence.

Also, is this always true? We discussed that at least sometimes, it is
in the .git directory of the tracking directory.

> +This location allows for the working tree to be non existent while keeping
> +the history around. So we can use `git-rm` on a submodule without loosing
> +information that may only be local; it is also possible to checkout the
> +superproject before and after the deletion of the submodule without the
> +need to reclone the submodule as it is kept locally.

For me, it is confusing to refer to it as a "submodule" after deletion,
since when you delete something, normally it no longer exists. Maybe
write this as:

    When a submodule is deleted using `git-rm`, its Git directory is
    moved to the superproject in $GIT_DIR/modules/<submodule-name>. This
    allows a submodule of the same name to later be re-added.

Also, this seems like a strange feature to me - if there is a rationale,
maybe it could be added.

[snip]

> +Deleting a submodule
> +--------------------
> +
> +Deleting a submodule can happen on different levels:
> +
> +1) Removing it from the local working tree without tampering with
> +   the history of the superproject.
> +
> +You may no longer need the submodule, but still want to keep it recorded
> +in the superproject history as others may have use for it.
> +--
> +  git submodule deinit <submodule path>
> +--
> +will remove the configuration entries
> +as well as the work

Incomplete sentence? Also, won't removing the configuration entries
tamper with the history of the superproject? (.gitmodules is usually
tracked, right?)

> +2) Remove it from history:
> +--
> +   git rm <submodule>
> +--

Does this completely delete the Git directory of the submodule too?
Above, it is stated that in such a case, the directory will be moved to
the superproject.

Actually, after reading below, I see that it is not the case. I would
include the commit step and then mention how the whole thing can be
undone.

    git rm <submodule>
    git commit

    This can be undone with `git revert`.

> +3) Remove the submodules git directory:
> +
> +When you also want to free up the disk space that the submodules git
> +directory uses, you have to delete it manually. It is found in
> +`$GIT_DIR/modules`.
> +The steps 1 and 2 can be undone via `git submodule init` or
> +`git revert`, respectively.  This step may incur data loss,
> +and cannot be undone. That is why there is no builtin.
> +
> +Other mechanisms
> +----------------
> +
> +Git repositories are allowed to be kept inside other repositories without
> +the need to use submodules. This however does not enable cross-repository
> +versioning as the inner repository is unaware of the outer repository,
> +which in turn ignores the inner.

Not sure if this is necessary.

> +Submodules are not to be confused with remotes, which are other
> +repositories of the same project; submodules are meant for
> +different projects you would like to make part of your source tree,
> +while the history of the two projects still stays completely
> +independent and you cannot modify the contents of the submodule
> +from within the main project.
> +If you want to merge the project histories and want to treat the
> +aggregated whole as a single project from then on, you may want to
> +add a remote for the other project and use the 'subtree' merge strategy,
> +instead of treating the other project as a submodule. Directories
> +that come from both projects can be cloned and checked out as a whole
> +if you choose to go that route.
> +
> +Third party tools
> +-----------------
> +
> +There are a variety of third party tools that manage multiple repositories
> +and their relationships to each other, such as Androids repo tool or git-slave.
> +Often these tools lack cross repository versioning.
> +
> +https://source.android.com/source/using-repo
> +
> +http://gitslave.sourceforge.net/

Not sure if this is necessary.

> +Implementation details
> +----------------------
> +
> +When cloning or pulling a repository containing submodules the submodules
> +will not be checked out by default; You can instruct 'clone' to recurse

semicolon -> period

> +into submodules. The 'init' and 'update' subcommands of 'git submodule'
> +will maintain submodules checked out and at an appropriate revision in
> +your working tree.

This part should probably be in the workflow section above. Also, above,
"git checkout" was introduced as a way to update the state of a
submodule - what's the difference between this and "git submodule
update"?
