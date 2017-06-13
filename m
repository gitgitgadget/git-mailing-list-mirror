Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8881FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753897AbdFMT3H (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:29:07 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36450 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752168AbdFMT3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:29:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id v18so20416088pgb.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NCNIo+Eaq+O3Q/BhcrAdusNvi13jPPeoxCzeBMrNbf8=;
        b=iuYlflo5bT/VSUM39MgskjRLfq5VuzL5e4+lDuPKyDMUWaFm94u1DNDhj9njMDXTCI
         /H0ObccNgZTf9Q/tXdc6/iROY06KdLO9Bsq45pgxiXw6vSRWDJga4A6Bmv6LpNUyUaEJ
         9622lrH4IfiPlt8xywNVk2juFcAzh6VPIJNPjYQfDpBpihUt8slaOVTvvFie9R0S5L5V
         8P0Sm7d+l1+EhDwYywmmVMOimfH7pakKam3Zpbh9/ODFR2e+cfXxD48zIE3dFsEonWRm
         JDojjMotT1XYxeb7/mGF3k9zN3eIBdDJxlzy7b3Q/xm/KuhR2TLtuYyDQUJnKmAPVLiW
         9pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NCNIo+Eaq+O3Q/BhcrAdusNvi13jPPeoxCzeBMrNbf8=;
        b=B2hE1uPVV6k8EeoMVbCs18nhITYtjBUcwrrzckk1qH6vStmd8hDIhqmJQSv+4D4K5U
         Tvk4GpQjAA45tnt+8Qtzacc4thL8VI2zoQ9lUVWmE79yCebPre+s8NhG50PLuxu7rZC3
         qc4p1tvWFEze0BAT86dW5UsDjM9PtPvQKgzMSA+CUfy9DcoMw9M7WuhXN5r3RHbc0BC5
         51ABvmhuvVEh44XRkymnhGaP/SgwhHHeD1hx1T1DiSRixq99Mls0ooscHw0R2OKp/o96
         DPBNnbc8scZMk1BPPqo2P1hom8npI71NKxKNX2d9sp3d9X6+henkkK9kXWlua7hFTfxv
         dJSQ==
X-Gm-Message-State: AKS2vOw/7eBofoVrcfN73N4XNNMY+M7Unx5sGxXNNgGt9EI+FBXaR7dF
        VQb5KTiKKJODNg==
X-Received: by 10.98.78.70 with SMTP id c67mr1006799pfb.155.1497382144305;
        Tue, 13 Jun 2017 12:29:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id f71sm26580257pfd.98.2017.06.13.12.29.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 12:29:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] submodules: overhaul documentation
References: <20170607185354.10050-1-sbeller@google.com>
Date:   Tue, 13 Jun 2017 12:29:02 -0700
In-Reply-To: <20170607185354.10050-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 7 Jun 2017 11:53:54 -0700")
Message-ID: <xmqqo9tr660x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -149,15 +119,17 @@ deinit [-f|--force] (--all|[--] <path>...)::
>  	tree. Further calls to `git submodule update`, `git submodule foreach`
>  	and `git submodule sync` will skip any unregistered submodules until
>  	they are initialized again, so use this command if you don't want to
> -	have a local checkout of the submodule in your working tree anymore. If
> -	you really want to remove a submodule from the repository and commit
> -	that use linkgit:git-rm[1] instead.
> +	have a local checkout of the submodule in your working tree anymore.
>  +
>  When the command is run without pathspec, it errors out,
>  instead of deinit-ing everything, to prevent mistakes.
>  +
>  If `--force` is specified, the submodule's working tree will
>  be removed even if it contains local modifications.
> ++
> +If you really want to remove a submodule from the repository and commit
> +that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
> +options.

Good reorganization.

> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
> new file mode 100644
> index 0000000000..2bf3149b68
> --- /dev/null
> +++ b/Documentation/gitsubmodules.txt
> @@ -0,0 +1,214 @@
> +gitsubmodules(7)
> +================
> +
> +NAME
> +----
> +gitsubmodules - mounting one repository inside another
> +
> +SYNOPSIS
> +--------
> +.gitmodules, $GIT_DIR/config
> +------------------
> +git submodule
> +git <command> --recurse-submodules
> +------------------
> +
> +DESCRIPTION
> +-----------
> +
> +A submodule is another Git repository tracked in a subdirectory of your
> +repository. The tracked repository has its own history, which does not
> +interfere with the history of the current repository.

"tracked in a subdirectory" sounds as if your top-level superproject
has a dedicated submodules/ directory and in it there live a bunch
of submodules.  Which obviously is not what you meant.  If phrased
"tracked as a subdirectory", I think the sentence makes sense.

While "which does not interfere" may be technically correct, I am
not sure what the value of saying that is.

> +Submodules are composed from a so-called `gitlink` tree entry
> +in the main repository that refers to a particular commit object
> +within the inner repository.

Correct, but it may be unclear to the readers why we do so.  Perhaps

        ... and this way, the tree of each commit in the main repository
        "knows" which commit from the submodule's history is "tied" to it.

or something like that?

> +Additionally to the gitlink entry the `.gitmodules` file (see
> +linkgit:gitmodules[5]) at the root of the source tree contains
> +information needed for submodules.

Is that really true?  Each submodule do not *need* what is in
.gitmodules; the top-level superproject needs to learn about
its submodules from the contents of that file, though.

> +The only required information
> +is the path setting, which estabishes a logical name for the submodule.

The phrase "the path setting" feels a bit unfortunate.  Is that
"only" thing we need?  Without URL we have no way to populate it,
no?

> +The usual git configuration (see linkgit:git-config[1]) can be used to
> +override settings given by the `.gitmodules` file.
> +
> +Submodules can be used for two different use cases:
> +
> +1. Using another project that stands on its own.
> +  When you want to use a third party library, submodules allow you to
> +  have a clean history for your own project as well as for the library.
> +  This also allows for updating the third party library as needed.
> +
> +2. Artificially split a (logically single) project into multiple
> +   repositories and tying them back together. This can be used to
> +   overcome deficiences in the data model of Git, such as:

s/deficiences in the data model/current limitations/ perhaps?

> +* To have finer grained access control.
> +  The design principles of Git do not allow for partial repositories to be
> +  checked out or transferred. A repository is the smallest unit that a user
> +  can be given access to. Submodules are separate repositories, such that
> +  you can restrict access to parts of your project via the use of submodules.

Some servers implement per-branch access control that seems to work
rather well.  Given that "shallow history" is possible (i.e. you
could give one commit without exposing older parts of the history),
I think the limitation this paragrah refers to is that "a tree is
the smallest unit that the user can be given access to."

> +* In its current form Git scales up poorly for very large repositories that
> +  change a lot, as the history grows very large. For that you may want to look
> +  at shallow clone, sparse checkout, or git-LFS.
> +  However you can also use submodules to e.g. hold large binary assets
> +  and these repositories are then shallowly cloned such that you do not
> +  have a large history locally.

This is why I suggest "current limitations"; this is not about
deficiency in the data model.

> +A submodule can be considered its own autonomous repository, that has a
> +worktree and a git directory at a different place than the superproject.

"Its own" I agree, but autonomous?

The mention of "main repository" in the earlier part of the document
may want to use the same phrase "superproject".

> +The superproject only records the commit object name in its tree, such that
> +any other information, e.g. where to obtain a copy from, is not recorded
> +in the core data structures of Git. The porcelain layer of Git however
> +makes use of the `.gitmodules` file that gives hints where and how to
> +obtain a copy of the submodule git repository from.

OK.

> +On the location of the git directory
> +------------------------------------
> +
> +Since v1.7.7 of Git, the git directory of submodules is stored inside the
> +superprojects git directory at $GIT_DIR/modules/<submodule-name>
> +This location allows for the working tree to be non existent while keeping
> +the history around. So we can use `git-rm` on a submodule without loosing

s/git-rm/git -rm/
s/loosing/losing/

> +Workflow for a third party library
> +----------------------------------
> +
> +  # add the submodule
> +  git submodule add <url> <path>
> +
> +  # occasionally update the submodule to a new version:
> +  git -C <path> checkout <new version>
> +  git add <path>
> +  git commit -m "update submodule to new version"

OK.

> +Workflow for an artifically split repo
> +--------------------------------------
> +
> +  # Enable recursion for relevant commands, such that
> +  # regular commands recurse into submodules by default
> +  git config --global submodule.recurse true
> +
> +  # Unlike the other commands below clone still needs
> +  # its own recurse flag:
> +  git clone --recurse <URL> <directory>
> +  cd <directory>
> +
> +  # Get to know the code:
> +  git grep foo
> +  git ls-files
> +
> +  # Get new code
> +  git fetch
> +  git pull --rebase
> +
> +  # change worktree
> +  git checkout
> +  git reset

This part is interesting ;-)

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

Do we have an adjective used for submodules that are checked out
vs deleted in this manner (I am thinking of "active" from earlier
work by Brandon)?  Do we want to mention it around here?

> +2) Remove it from history:
> +--
> +   git rm <submodule>
> +--

Is this removing from "history"?  Isn't it merely removing it from
the index of the superproject (hence potentially removing it from
the tree of the upcoming commit in the superproject)?

> +3) Remove the submodules git directory:
> +
> +When you also want to free up the disk space that the submodules git
> +directory uses, you have to delete it manually. It is found in
> +`$GIT_DIR/modules`.
> +The steps 1 and 2 can be undone via `git submodule init` or
> +`git revert`, respectively.  This step may incur data loss,
> +and cannot be undone. That is why there is no builtin.

Perhaps "deinit" can learn an option to do this (tangent).  When you
are a follower, it is OK to do so.

When you are removing the only copy of the repository, of course
there will be some data loss ;-)


> +Other mechanisms
> +----------------
> +
> +Git repositories are allowed to be kept inside other repositories without
> +the need to use submodules. This however does not enable cross-repository
> +versioning as the inner repository is unaware of the outer repository,
> +which in turn ignores the inner.

s/the inner/& repository/;

> +Submodules are not to be confused with remotes, which are other
> +repositories of the same project; submodules are meant for
> +different projects you would like to make part of your source tree,
> +while the history of the two projects still stays completely
> +independent and you cannot modify the contents of the submodule
> +from within the main project.

Would anybody make such a confusion, though?  Perhaps drop the first
sentence up to ';' in a follow-up patch?

> +If you want to merge the project histories and want to treat the
> +aggregated whole as a single project from then on, you may want to
> +add a remote for the other project and use the 'subtree' merge strategy,
> +instead of treating the other project as a submodule. Directories
> +that come from both projects can be cloned and checked out as a whole
> +if you choose to go that route.

While it is correct, is this something we want to mention in
gitsubmodule.txt?  It sounds more like what "git merge" should say,
if we wanted to.

Thanks.
