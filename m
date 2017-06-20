Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4EA20282
	for <e@80x24.org>; Tue, 20 Jun 2017 19:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbdFTTP1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 15:15:27 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33236 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdFTTP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 15:15:26 -0400
Received: by mail-pg0-f45.google.com with SMTP id f185so66680669pgc.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rIiZsoazgxWfrv7dGLYsPKShrC8rjDt1+9w6Mi+ZbyE=;
        b=NXvDHkXIOv0ANYgVtIev4nFxJ2S2tL9LbXTOfOxNtWdZ47T7F1a4oAnSOz0/i8MfB2
         APwq1WIHyGoBZtF4BzXCeokDzKt+IZELoBtJe4L3YweA9GAth7KSWTMVyCIE+FaQfbDY
         BfpMfCk3PSawOK5VwMfIOQ/okzoRJEruXSTyoHVxzpxu97musUu+F4fR0Rk0XrnmLi2g
         yqSf1o1D7lTTjFbIiuZRmzalb7gESSeXOoMHKGmZmpqusMGwdQuzA8ojhOlz+tBWzREy
         GHRh8jZRCsp4+eLq9MEq0tddxOSsSljI9RgIv1wbfiT4LtMntp6A85zlbgwuMxbtbeoL
         pLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rIiZsoazgxWfrv7dGLYsPKShrC8rjDt1+9w6Mi+ZbyE=;
        b=umGsiqbH9uPlJpiFFmwVQ8g9ei1EwjMNu3hXZ93PFu951Lff/KpVHAMolqSmCZd+Mo
         00H/cGNCYNVjwul8rbyZV6v1JHSay/BudZ4dYjP93NOEh9mC6XqwTKeJd/A1sYuKzyvv
         12VOP3RBEQUFjiOzruaSn3Af4j3nCbMw7UnnXqd73fDgN54eBiAVl1D86W6wNWZWNySV
         HPjgaJG5RAD0YgSR0i4hDzgb43ScFUAKrnZSdwvwZfXxsWuOwTxv1bMje1hutrjIJSbm
         7v8rBTgWgVCyXURk37rvH2gHH3NsQQktfyM1ZSFfTwjyffWB3XS66oeZiBrkdwanHEKE
         utDQ==
X-Gm-Message-State: AKS2vOwEe3mZivswDBZFXGvaaGa6vXBT86c1qI+bgL8FEO948Y3TIiLD
        lFKlaGmU+WCaOAApBUVH9w1p8ArD5Lw1
X-Received: by 10.98.49.2 with SMTP id x2mr11924792pfx.48.1497986124776; Tue,
 20 Jun 2017 12:15:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 20 Jun 2017 12:15:24 -0700 (PDT)
In-Reply-To: <20170620111844.1a8ebf37@twelve2.svl.corp.google.com>
References: <20170607185354.10050-1-sbeller@google.com> <20170620111844.1a8ebf37@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 12:15:24 -0700
Message-ID: <CAGZ79kaEtOiQ7k6HOdzqmqgzKAjbd3UDzq4tB+zj1Hi9YpiF1Q@mail.gmail.com>
Subject: Re: [RFC/PATCH] submodules: overhaul documentation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 11:18 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> +DESCRIPTION
>> +-----------
>> +
>> +A submodule is another Git repository tracked in a subdirectory of your
>> +repository. The tracked repository has its own history, which does not
>> +interfere with the history of the current repository.
>> +
>> +Submodules are composed from a so-called `gitlink` tree entry
>> +in the main repository that refers to a particular commit object
>> +within the inner repository.
>> +
>> +Additionally to the gitlink entry the `.gitmodules` file (see
>> +linkgit:gitmodules[5]) at the root of the source tree contains
>> +information needed for submodules. The only required information
>> +is the path setting, which estabishes a logical name for the submodule.
>
> I know that this was copied over, but this is confusing to me, so it
> might be worthwhile to change it. In particular, `gitlink` is, as far as
> I know, the type of the child object,

correct

> not any sort of tree entry. I

Well a tree references (a) other trees (b) blobs or (c) gitlinks, so calling
a gitlink a tree-entry is correct, but maybe confusing.

> would rewrite this as:
>
>     A submodule consists of a tracking subdirectory and an entry in the
>     `.gitmodules` file (see linkgit:gitmodules[5]).

    A submodule consists of a tracking subdirectory [in the working directory]
    and an entry in the `.gitmodules` file (see linkgit:gitmodules[5]).

>     The tracking subdirectory appears in the main repository as a
>     `gitlink` object (instead of a `tree` object). The parent of the
>     tracking subdirectory links to this `gitlink` object through its
>     hash, just like linking to a `tree` or `blob`. This `gitlink` object
>     contains the hash of a particular commit object of the submodule.
>

I think this is confusing, too. :)
That is because a subdirectory exists on the FS, whereas the gitlink
appears in gits representation of the world (in the tree). Maybe:

    The tracking subdirectory appears in the main repository at
    the point where it is tracked via the gitlink in the tree.
    It is empty when the submodule is not populated, otherwise
    it contains the content of the submodule repository.

    The gitlink object contains the hash of a particular commit
    object of the submodule.

    The .gitmodules file establishes a relationship between the
    path, which is where the gitlink is in the tree, and the logical
    name, which is used for the location of the submodules git
    directory. The .gitmodules file has the same syntax as the
    $Git_DIR/config file. The relationship mapping of path to name
    is done via setting submodule.<name value>.path = <path value>.

    The submodules git directory is found in in the main repositories
    '$GIT_DIR/modules/<name>' or inside the tracking subdirectory,
    but this is deprecated.

>     The entry in the `.gitmodules` file establishes the name of the
>     submodule (to be used as a reference by other entries and commands)
>     and references the tracking subdirectory as follows:
>
>         submodule.my_submodule_name.path = path/to/my_submodule
>
> There might also be a need to mention that when the submodule is
> populated (or whatever the right term is), the tracking subdirectory in
> the working tree contains both the submodule's working tree and the
> submodule's Git directory.

See the alternative proposal above, the git directory is best kept outside
the tracking subdirectory, but rather contained inside the superprojects
git dir itself.

>
>> +The usual git configuration (see linkgit:git-config[1]) can be used to
>> +override settings given by the `.gitmodules` file.
>
> Not sure if this is relevant here.

This is relevant for overwriting e.g. the submodule.NAME.url setting.

>
>> +Submodules can be used for two different use cases:
>
> A creative person might come up with more, so this might be better as:
>
>     Submodules can be used for at least these use cases:

ok.

>> +1. Using another project that stands on its own.
>> +  When you want to use a third party library, submodules allow you to
>> +  have a clean history for your own project as well as for the library.
>> +  This also allows for updating the third party library as needed.
>
> Probably better as:
>
>     1. Using another project while maintaining independent history.
>     Submodules allow you to contain the working tree of another project
>     within your own working tree while keeping the history of both
>     projects separate. Also, since submodules are fixed to a hash, the

"fixed to an arbitrary version" instead?

>     other project can be independently developed without affecting the
>     parent project, allowing the parent project to fix itself to new
>     versions only whenever desired.

>> +2. Artificially split a (logically single) project into multiple
>> +   repositories and tying them back together. This can be used to
>> +   overcome deficiences in the data model of Git, such as:
>
> This should match the gerund used in point 1:
>
>     2. Splitting a (logically single) project into multiple
>     repositories. This can be used to overcome deficiencies in the data
>     model of Git, such as:

as Junio pointed in a separate email out we'd not use "deficiencies
in the data model" but something else.

>> +* To have finer grained access control.
>> +  The design principles of Git do not allow for partial repositories to be
>> +  checked out or transferred. A repository is the smallest unit that a user
>> +  can be given access to. Submodules are separate repositories, such that
>> +  you can restrict access to parts of your project via the use of submodules.
>
> Not sure about this point - if the project is logically single, you
> would probably need to see the entire project.

Well no. Large projects do not require you to see everything. This can be
a decision by yourself ("I am only here to fix grammar in the docs /
I am only here to work on this niche feature contained in 3 submodules,
so I don't want to download the whole thing") or by the project ("You
are not trustworthy enough to read the 'sekret' submodule, which only
our top engineers have access too but believe me you don't need it").

> If this is about
> different teams independently working on different subcomponents, this
> seems more like point 1 (inclusion of other projects).

In the very first attempt of this man page overhaul I also had an example
of big binary files, which were put in submodules, such that it could be
understood as a solution to the same problem as git-LFS is offering. But
this is not a long term solution, as you are working on fixing this for real.
But that is how Android uses some repositories, today.

>> +* In its current form Git scales up poorly for very large repositories that
>> +  change a lot, as the history grows very large. For that you may want to look
>> +  at shallow clone, sparse checkout, or git-LFS.
>> +  However you can also use submodules to e.g. hold large binary assets
>> +  and these repositories are then shallowly cloned such that you do not
>> +  have a large history locally.
>> +
>> +The data model
>> +--------------
>> +
>> +A submodule can be considered its own autonomous repository, that has a
>> +worktree and a git directory at a different place than the superproject.
>
> Isn't the worktree inside the superproject's worktree? I would write
> this as:
>
>     A submodule is its own repository, having its own working tree and
>     Git directory.

yes, but continued:

    The working tree is inside the superprojects working tree, at the place
    as bound via its (gitlink entry) path.
    The git directory may be either inside the working tree or contained
    inside the superprojects git directory.

>
>> +The superproject only records the commit object name in its tree, such that
>> +any other information, e.g. where to obtain a copy from, is not recorded
>> +in the core data structures of Git. The porcelain layer of Git however
>> +makes use of the `.gitmodules` file that gives hints where and how to
>> +obtain a copy of the submodule git repository from.
>
> I would write this as:
>
>     Additional metadata (for example, from where this submodule was
>     obtained) can be written to the `.gitmodules` file, to be used by
>     the porcelain layer of Git.

s/was obtained/can be obtained/ IMHO, but this sounds good.

>
>> +Submodule operations can be configured using the following mechanisms
>> +(from highest to lowest precedence):
>> +
>> + * the command line for those commands that support taking submodule specs.
>> +
>> + * the configuration file `$GIT_DIR/config`.
>
> Which $GIT_DIR? The submodule or the superproject?

superprojects

>
>> + * the configuration file `config` found in the `refs/submodule/config` branch.
>> +   This can be used to overwrite the upstream configuration in the `.gitmodules`
>> +   file without changing the history of the project.
>> +   Useful options here are overwriting the base, where relative URLs apply to,
>> +   when mirroring only parts of the larger collection of submodules.
>> +
>> + * the `.gitmodules` file inside the repository. A project usually includes this
>> +   file to suggest defaults for the upstream collection of repositories.
>
> Which .gitmodules? The submodule's or the superproject's?

superprojects

>
>> +On the location of the git directory
>> +------------------------------------
>> +
>> +Since v1.7.7 of Git, the git directory of submodules is stored inside the
>> +superprojects git directory at $GIT_DIR/modules/<submodule-name>
>
> Missing period at end of sentence.
>
> Also, is this always true? We discussed that at least sometimes, it is
> in the .git directory of the tracking directory.
>
>> +This location allows for the working tree to be non existent while keeping
>> +the history around. So we can use `git-rm` on a submodule without loosing
>> +information that may only be local; it is also possible to checkout the
>> +superproject before and after the deletion of the submodule without the
>> +need to reclone the submodule as it is kept locally.
>
> For me, it is confusing to refer to it as a "submodule" after deletion,
> since when you delete something, normally it no longer exists. Maybe
> write this as:
>
>     When a submodule is deleted using `git-rm`, its Git directory is
>     moved to the superproject in $GIT_DIR/modules/<submodule-name>. This
>     allows a submodule of the same name to later be re-added.

Not just re-added but also it is kept around if you checkout an older commit.

> Also, this seems like a strange feature to me - if there is a rationale,
> maybe it could be added.

The rationale is to not throw away the data, but you can reconstruct any
state before its deletion locally without having to re-clone/fetch it.


>
> [snip]
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
> Incomplete sentence? Also, won't removing the configuration entries
> tamper with the history of the superproject? (.gitmodules is usually
> tracked, right?)

configuration entries in the .git/config file that are overwriting the
entries from the .gitmodules file.

>
>> +2) Remove it from history:
>> +--
>> +   git rm <submodule>
>> +--
>
> Does this completely delete the Git directory of the submodule too?
> Above, it is stated that in such a case, the directory will be moved to
> the superproject.
>
> Actually, after reading below, I see that it is not the case. I would
> include the commit step and then mention how the whole thing can be
> undone.
>
>     git rm <submodule>
>     git commit
>
>     This can be undone with `git revert`.

That makes sense.

>
>> +3) Remove the submodules git directory:
>> +
>> +When you also want to free up the disk space that the submodules git
>> +directory uses, you have to delete it manually. It is found in
>> +`$GIT_DIR/modules`.
>> +The steps 1 and 2 can be undone via `git submodule init` or
>> +`git revert`, respectively.  This step may incur data loss,
>> +and cannot be undone. That is why there is no builtin.
>> +
>> +Other mechanisms
>> +----------------
>> +
>> +Git repositories are allowed to be kept inside other repositories without
>> +the need to use submodules. This however does not enable cross-repository
>> +versioning as the inner repository is unaware of the outer repository,
>> +which in turn ignores the inner.
>
> Not sure if this is necessary.
>
>> +Submodules are not to be confused with remotes, which are other
>> +repositories of the same project; submodules are meant for
>> +different projects you would like to make part of your source tree,
>> +while the history of the two projects still stays completely
>> +independent and you cannot modify the contents of the submodule
>> +from within the main project.
>> +If you want to merge the project histories and want to treat the
>> +aggregated whole as a single project from then on, you may want to
>> +add a remote for the other project and use the 'subtree' merge strategy,
>> +instead of treating the other project as a submodule. Directories
>> +that come from both projects can be cloned and checked out as a whole
>> +if you choose to go that route.
>> +
>> +Third party tools
>> +-----------------
>> +
>> +There are a variety of third party tools that manage multiple repositories
>> +and their relationships to each other, such as Androids repo tool or git-slave.
>> +Often these tools lack cross repository versioning.
>> +
>> +https://source.android.com/source/using-repo
>> +
>> +http://gitslave.sourceforge.net/
>
> Not sure if this is necessary.
>
>> +Implementation details
>> +----------------------
>> +
>> +When cloning or pulling a repository containing submodules the submodules
>> +will not be checked out by default; You can instruct 'clone' to recurse
>
> semicolon -> period
>
>> +into submodules. The 'init' and 'update' subcommands of 'git submodule'
>> +will maintain submodules checked out and at an appropriate revision in
>> +your working tree.
>
> This part should probably be in the workflow section above. Also, above,
> "git checkout" was introduced as a way to update the state of a
> submodule - what's the difference between this and "git submodule
> update"?

checkout doesn't do any network traffic, whereas "submodule update"
tries everything it can including re-clone to obtain the submodule at the
recorded state.
