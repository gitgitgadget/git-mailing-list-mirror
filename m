Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C5C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbiBJPuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 10:50:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243796AbiBJPuu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 10:50:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D3EBC6
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 07:50:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cn6so11641785edb.5
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JK5JaJ6r9HfabxwpnGSnjQWPMSbYsxmoVQQ+jgpbb0=;
        b=nnMDTSQYqzLE2Q/p9wL+41ixdkPHpKsk+9E+av3JEMgqlBip3PmXCy7KJEtND4jTsh
         GGagbdi9ZhZ4dEPmLpl9MqGxyU9bqXI7W/zTM5IyXWaoJ1oRkazBEWWyl4YGb6xPbv94
         PsoFJ/00pKJNOYTdSETL/D24IbDBDP/uRamSfkyB++U0/s5I3PrCFxpyrlERS/M43zoB
         A6AOLzlsobtf1Dzm/0P++hDevP+k5pAfGvxOObvKZSYEbxwIYFqEcP+uBHR3WVP01A32
         ZwwpOFSz+Md1QgbQOJeqr9SztedRB7PHJM1jNg158sXVST9cvfPT6l8IbtU/EXWf4527
         yKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JK5JaJ6r9HfabxwpnGSnjQWPMSbYsxmoVQQ+jgpbb0=;
        b=XJ5ccQsjMfkkVilcqXmDV7fyPIjBdZqw5ciCDb6h84JDDJpZERErEf2hby5yX63Dxy
         CPoZwg16s2saIw7iJdvlRVzUh0UIcweshIJW1LFEK3qTexWd/OuW2mSX3JpNUF7663sH
         E2ow/24c4/fsFub8iaawFtvbJx3bGOpo0e7zzvdEl7ZUv4P5eppye4QhT7aq7Al9ZDCn
         SeF61igaC3ZCEA7lTspyHXwib6MglqYVBZws+uHxDwMWFVWgxIn/hf8Q6RPIurzSnLNl
         5SCcXXbB9n8oDJLKJ0VI05WEmPhH7X7yx86bg0ZlwLJ8w8fFrlDLF0n4e5F0JL4Z2UGn
         E0Rg==
X-Gm-Message-State: AOAM533CWDw6JAiSFqSIULfu2RfbkvG34eVuIEQ1n4ncPV9hc83X26Ue
        9jYu4OS+RWfPNnYfmBm8zL09043q8rd/Bom72Ks=
X-Google-Smtp-Source: ABdhPJxsJJE3VuOtK5YBxCjXYI/ExJXZwokUggVdicZzDfbna1QugDri5JxICpe13hJBixLIfuTal1d66gkLqUVP9xE=
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr8901421edd.126.1644508248849;
 Thu, 10 Feb 2022 07:50:48 -0800 (PST)
MIME-Version: 1.0
References: <xmqqczjvxy3o.fsf@gitster.g>
In-Reply-To: <xmqqczjvxy3o.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Feb 2022 07:50:37 -0800
Message-ID: <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 9, 2022 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> We have description on "per worktree ref", but "worktree" is not
> described in the glossary.  We do have "working tree", though.
>
> Casually put, a "working tree" is what your editor and compiler
> interacts with.  "worktree" is a mechanism to allow one or more
> "working tree"s to be attached to a repository and used to check out
> different commits and branches independently, which includes not
> just a "working tree" but also repository metadata like HEAD, the
> index to support simultaneous use of them.  Historically, we used
> these terms interchangeably but we have been trying to use "working
> tree" when we mean it, instead of "worktree".
>
> Most of the existing references to "working tree" in the glossary do
> refer primarily to the working tree portion, except for one that
> said refs like HEAD and refs/bisect/* are per "working tree", but it
> is more precise to say they are per "worktree".
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Mostly unchanged from the version in the original discussion
>    https://lore.kernel.org/git/xmqqo83hatm1.fsf@gitster.g/ except
>    that we now mention that pseudorefs are also per worktree.
>
>    One thing that makes me worried somewhat is what I did not touch,
>    namely, how pseudo refs are defined.  I know MERGE_HEAD is very
>    special and it may be impossible to coax it into refs API for
>    writing, so the text there makes sense for it, but there are
>    other all-caps-and-directly-under-dot-git-directory files like
>    ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
>    API, so the description would have to be updated there.

I'm not quite following; why would the description need to be updated?
 Sure MERGE_HEAD is written without using the refs API, but we didn't
mention how the pseduorefs were written in the description, and all of
MERGE_HEAD, CHERRY_PICK_HEAD, ORIG_HEAD, REVERT_HEAD get written
per-worktree so doesn't "pseudorefs like MERGE_HEAD" cover it as far
as the reader is concerned?

>  Documentation/glossary-content.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index c077971335..9eb8920552 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -312,7 +312,7 @@ Pathspecs are used on the command line of "git ls-files", "git
>  ls-tree", "git add", "git grep", "git diff", "git checkout",
>  and many other commands to
>  limit the scope of operations to some subset of the tree or
> -worktree.  See the documentation of each command for whether
> +working tree.  See the documentation of each command for whether
>  paths are relative to the current directory or toplevel.  The
>  pathspec syntax is as follows:
>  +
> @@ -446,7 +446,7 @@ exclude;;
>         interface than the <<def_plumbing,plumbing>>.
>
>  [[def_per_worktree_ref]]per-worktree ref::
> -       Refs that are per-<<def_working_tree,worktree>>, rather than
> +       Refs that are per-<<def_worktree,worktree>>, rather than
>         global.  This is presently only <<def_HEAD,HEAD>> and any refs
>         that start with `refs/bisect/`, but might later include other
>         unusual refs.
> @@ -669,3 +669,12 @@ The most notable example is `HEAD`.
>         The tree of actual checked out files.  The working tree normally
>         contains the contents of the <<def_HEAD,HEAD>> commit's tree,
>         plus any local changes that you have made but not yet committed.
> +
> +[[def_work_tree]]worktree::
> +       A repository can have zero (i.e. bare repository) or one or
> +       more worktrees attached to it. One "worktree" consists of a
> +       "working tree" and repository metadata, most of which are
> +       shared among other worktrees of a single repository, and
> +       some of which are maintained separately per worktree
> +       (e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
> +       per-worktree refs and per-worktree configuration file).
> --
> 2.35.1-102-g2b9c120970

The text looks good to me.
