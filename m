Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3CF1F424
	for <e@80x24.org>; Wed, 20 Dec 2017 08:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbdLTI6r (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 03:58:47 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36783 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbdLTI6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 03:58:46 -0500
Received: by mail-qt0-f173.google.com with SMTP id a16so27432580qtj.3
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kvmAD2Gfy7W86gFDndjgd+Cx85d9YbLAouDLKVBwHQ0=;
        b=UIfUHMMSo96woO3W2iR27B8/l8hLGqpaGlBn35ZEH+d1diwpZl/HLwxEdeWDGxvVtJ
         /0shl3Yi3FGozEYAW7nN0Row7f6mlUL1eHCA2itvGFku1WPE/nhB/cVdDWHNhreJbs5q
         3/SVe5YCQmUBXRk8DFY3aelkgfRnXshPOgNbLIiczlr779Zn92Br/wuKzSQvOp5YSRij
         01Brr1ZoD25qpxw5ZWO14EPBlwq43qlICAUTXNhVUOCFKjUbp3CuQb6CCdiRvlokUxhK
         /aWj0/TraO7G+mZNfrSrfrNwc/3em+Rkx/QrHsLgkkkAbZmJH2t3PU0c1ivH3bR19ixd
         uJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kvmAD2Gfy7W86gFDndjgd+Cx85d9YbLAouDLKVBwHQ0=;
        b=WN2E9UqYFjRV+2+9kgBUT2KdXysq7rFQHNcWuj5PVJRXBthMIa0MpWbaUCIJmPSSEg
         C3gmft/ke1mmc11Ojy44dcNChajSP3hRqwm6e4Ww52wlYWE2IkV4+lpD75AH40LT3qDM
         9mbsAX5jLQWv38zOrs1jnKzzkJjGNsJmWyYkzEOcx78NGi7fhIqbJJ3ImFab14sTgfWJ
         dbeQ5gYEhzsHHVUTN7E4yD8vVU76IbQ1j1xoQ9uyhHw/45JFMxQqs3Tg/cGYNwus6vw8
         13/2UHv7dCY4bk+4a3R9a96rNHpexITHcVOt2edPJoN9OcplElk00l+nvd7RV0S1S0bg
         1Ayw==
X-Gm-Message-State: AKGB3mJ9kLrz0ciYRl5UkK31MizgMyzxha4a414jrMxvuCJVyKXwncMm
        /O11vQhfInuuz7GdmTQvSBM+BXkmThUmDGek5ZQEPA==
X-Google-Smtp-Source: ACJfBouKxJ/h3Baq+uW/zM6MAX4LGClbzJ0tSWTn/kuHz5gRzzsH8m+eQQVNfRumBLKpBj9Hk/5mNvNdgprneF0mttE=
X-Received: by 10.200.35.28 with SMTP id a28mr9541471qta.51.1513760325278;
 Wed, 20 Dec 2017 00:58:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Wed, 20 Dec 2017 00:58:44 -0800 (PST)
In-Reply-To: <20171213182802.114615-1-bmwill@google.com>
References: <20171212005221.GD177995@google.com> <20171213182802.114615-1-bmwill@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 20 Dec 2017 03:58:44 -0500
X-Google-Sender-Auth: lZ_-KaItE_JPMm4YHIr8ghGk8zY
Message-ID: <CAPig+cTG8Sp7G+A9sbV9u4HbtgSu9-X7FiamvM4Ncu1_VhgVXA@mail.gmail.com>
Subject: Re: [PATCH] path: document path functions
To:     Brandon Williams <bmwill@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 13, 2017 at 1:28 PM, Brandon Williams <bmwill@google.com> wrote:
> As promised here is an update to the documentation for the path generating
> functions.

Thanks for working on this. Aside from the review comments by
Junio[1], see a few more below. Although I had some familiarity with
the non-repo versions of these functions a couple year ago when
working on git-worktree, I've since forgotten much of it, so take my
comments as if from someone trying to learn this API from scratch
(which is effectively what I'm doing again). In particular, as I read
this patch, I find that I still have to consult the source code
(path.c) to figure out what some of these functions are for or what
they do.

[1]: https://public-inbox.org/git/xmqqr2rywid7.fsf@gitster.mtv.corp.google.com/

> diff --git a/path.h b/path.h
> @@ -4,53 +4,144 @@
>  /*
> + * The result to all functions which return statically allocated memory may be
> + * overwritten by another call to _any_ one of these functions. Consider using
> + * the safer variants which operate on strbufs or return allocated memory.
>   */
>
> +/*
> + * Return a statically allocated path.
> + */
> +extern const char *mkpath(const char *fmt, ...)
> +       __attribute__((format (printf, 1, 2)));

It's not, at first glance, clear what benefit this function provides
over simply constructing a path manually with, say, sprintf() or
strbuf. Should this mention that a certain amount of normalization is
performed on the path?

Furthermore, perhaps the comment block above which talks about
"statically allocated memory" could do a better job of conveying that
these functions rid the caller of the responsibility of managing
string storage itself. I wonder if it also might make sense to mention
that the returned path won't necessarily be overwritten by the very
next call (or is that an implementation detail we'd rather people not
rely upon?).

> +/*
> + * Return a path.
> + */
> +extern char *mkpathdup(const char *fmt, ...)
> +       __attribute__((format (printf, 1, 2)));

I realize that it's implied by "dup", but perhaps the documentation
should state explicitly that the caller is responsible for freeing the
result?

> +/*
> + * The `git_common_path` family of functions will construct a path into a
> + * repository's common git directory, which is shared by all worktrees.
> + */

My first question when reading this was "What is a common git
directory? (Is that where a bunch of repositories live or what?)". I
suppose if it had said "common .git/ directory", it would have been
clearer. Perhaps mentioning GIT_DIR might help clarify it, as well.

    ...repository's common .git/ directory (or $GIT_DIR), which
    is shared by all worktrees.

> +/*
> + * Constructs a path into the common git directory of repository `repo` and
> + * append it in the provided buffer `sb`.
> + */
>  extern void strbuf_git_common_path(struct strbuf *sb,
>                                    const struct repository *repo,
>                                    const char *fmt, ...)
>         __attribute__((format (printf, 3, 4)));

It's nice that this states explicitly that it _appends_ rather than
overwrites. So often, one has to consult the implementation to
determine the actual behavior.

Perhaps I'm simple-minded, but at this point in the read, the concept
of "common git directory" still feels nebulous. If the documentation
presented even a simple example of how this is used (such as, for
instance, calling this function to obtain ".git/HEAD"), it would help
make the concept more concrete. Or, perhaps the example could be
presented in the comment block just above which talks about this
family of functions.

> +/*
> + * Return a statically allocated path into the main repository's
> + * (the_repository) common git directory.
> + */
> +extern const char *git_common_path(const char *fmt, ...)
>         __attribute__((format (printf, 1, 2)));

I suppose that other repositories would be submodules? Would it make
sense to mention something about that to clue in readers?

    Return a statically allocated path into the common .git/ directory
    of the main repository (not a submodule repository).

Or something.

Aside: After reading "main repository" here and seeing the 'repo'
variants below, one wonders why the corresponding
repo_git_common_path() doesn't exist. (Just an idle question; not
actionable, and outside the scope of this patch.)

> +/*
> + * The `git_path` family of functions will construct a path into a repository's
> + * git directory.
> + *
> + * These functions will perform adjustments to the resultant path to account
> + * for special paths which are either considered common among worktrees (e.g.
> + * paths into the object directory) or have been explicitly set via an
> + * environment variable or config (e.g. path to the index file).
> + *
> + * For an exhaustive list of the adjustments made look at `common_list` and
> + * `adjust_git_path` in path.c.
> + */

I feel somewhat clueless after reading this. It doesn't necessarily
give enough information for the reader to understand when or why these
functions should be used as opposed to one of the functions described
earlier. This may be due to it not stating early enough or forcefully
enough that the location of certain files is not fixed, that they
reside elsewhere when worktrees are involved. Perhaps something along
these lines would help make it more concrete:

    Administrative files within .git/ may reside at different
    locations depending upon whether worktrees are involved. Some
    files and directories are common to all worktrees (for instance,
    ".git/hooks", ".git/objects") but others are localized to the main
    directory or to each worktree (for instance, ".git/HEAD" vs
    ".git/worktrees/<id>/HEAD). Other factors, such as environment
    variables or configuration settings may also impact locations of
    administrative files.

    The 'git_path' family of functions employs specialized knowledge
    of these issues when constructing a path to an administrative file
    or directory, thus relieving the caller of the burden of manually
    figuring out where resources reside.

> +/*
> + * Return a path into the git directory of repository `repo`.
> + */
>  extern char *repo_git_path(const struct repository *repo,
>                            const char *fmt, ...)
>         __attribute__((format (printf, 2, 3)));

I presume by the return type that the caller is responsible for
freeing the result. Perhaps the documentation can state that
explicitly.

> +/*
> + * Return a path into the main repository's (the_repository) git directory.
> + */
> +extern char *git_pathdup(const char *fmt, ...)
> +       __attribute__((format (printf, 1, 2)));

Perhaps mention that the caller is responsible for freeing the result.

> +/*
> + * Construct a path into the main repository's (the_repository) git directory
> + * and place it in the provided buffer `buf`, the contents of the buffer will
> + * be overridden.

s/overridden/overwritten/

> + */
> +extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
> +       __attribute__((format (printf, 2, 3)));

Nice to see that this explains that the buffer will be overwritten (as
opposed to appended). This function is a less flexible special case of
strbuf_git_path() below. Does this mean it is deprecated? Should the
documentation say something about preferring strbuf_git_path()
instead?

> +/*
> + * Construct a path into the main repository's (the_repository) git directory
> + * and append it to the provided buffer `sb`.
> + */
> +extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
> +       __attribute__((format (printf, 2, 3)));
> +
> +/*
> + * Return a path into the worktree of repository `repo`.
> + *
> + * If the repository doesn't have a worktree NULL is returned.
> + */
>  extern char *repo_worktree_path(const struct repository *repo,
>                                 const char *fmt, ...)
>         __attribute__((format (printf, 2, 3)));

Now this is getting confusing. The documentation for the 'git_path'
family of functions said that it takes worktrees into consideration.
So what precisely do the 'worktree_path' family of functions do? When
does one use them over the 'git_path' family?

Also, caller is responsible for freeing result.

> +/*
> + * Return a path into a submodule's git directory located at `path`.  `path`
> + * must only reference a submodule of the main repository (the_repository).
> + */

Ouch, ambiguity hurts my brain. Does this mean that the submodule is
located at 'path' or that the .git/ directory is located at 'path'?
Perhaps:

    Return a path into the .git/ directory of a submodule located at
    'path'.
