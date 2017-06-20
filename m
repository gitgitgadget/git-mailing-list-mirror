Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7701220282
	for <e@80x24.org>; Tue, 20 Jun 2017 16:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdFTQ6B (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 12:58:01 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33184 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdFTQ6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 12:58:01 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so72073086pfr.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sNc7GtfYoaWRlnNt9cNBpi5tj9f9BZyOtvmkiwpCrH4=;
        b=D6hA01V2rduArd86kbt1GVE/8DIAyi4XtyYLO3yW2y5+uf+2IfU9MYo9WFx+oWD6d/
         7sqGluvcWbsb8hZCP8YnsWGVVc+qyQOdJAnwl76yBpewEzEeCZ5LWIHWE53bBrGjvOWU
         9YlsuS2yhcxc5EfritU+anSSbY+uiRduRuxBweJEFIzzQF5xhFidwkTor1qS1EP3hcuc
         jlN5meGLvrHq0UwBDdoUrVfE4Wd2nnbvvzyum+fLH92StRcfgnPgjYVmBfFzwiquiEJX
         G7oiEuNK+PECp+M7I44DqjnAb5NBmFR+GE5s22RrKjGpwohFyzToFjxMY0ADOrDFd6t2
         78TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sNc7GtfYoaWRlnNt9cNBpi5tj9f9BZyOtvmkiwpCrH4=;
        b=PuvYB1PLwkScIKj7ynQrQeou/U5NXJ+tOoLR3XGL4kt5fzjVxpzRUaM7zrg96kisvE
         hpSsBkAfiE7FVcFXLZqVWf68kNCaEvTCWB5SPJqu9TGPN/h+TlwXUETtNDsPZm7YpT3d
         bRueThmLPMr2vNhUb7+FoDD1XBFxYJ2QV/q0smL7xbMosJsG3+qZrxwEwCeWuXLKIn74
         Gi5x2KvUaaTsVO2EQQhPp+A7k9rTDv43iaCinv+ghLg876+jaw387JUbn4ayD24YFlav
         /Qw2wdmhLC3zJfnodXPVgr7oqUWSHKHj9s/3moRTOZqWsWyTgRT+NMHgHeNO0N5as/ot
         IRsQ==
X-Gm-Message-State: AKS2vOyu+vecWQHg6VvyZA+A1a6SzQk46Hvgg3ByTz6QFNWQ/xOhD6/D
        pF5zDYnJLbVZOOLwssYRoDaWxyZf4abY
X-Received: by 10.98.69.76 with SMTP id s73mr26914280pfa.94.1497977880238;
 Tue, 20 Jun 2017 09:58:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 20 Jun 2017 09:57:59 -0700 (PDT)
In-Reply-To: <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
References: <CAGZ79kbMhQpxUa5TXK=WCzzKUCZ5vx3oC+fFTTozpgQihsUjTA@mail.gmail.com>
 <20170620031214.7616-1-kaarticsivaraam91196@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Jun 2017 09:57:59 -0700
Message-ID: <CAGZ79kbJx4p2y6Vjp3dVBP2pd=MYa_j3Mxfv=zUygHY-bHj0wQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 8:12 PM, Kaartic Sivaraam
<kaarticsivaraam91196@gmail.com> wrote:
> Make following changes to the git-submodule
> documentation:
>
> * Remove redundancy
> * Remove unclear back reference
> * Use more appropriate word
> * Quote important word
>
> Suggestions-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  Currently used the word "canonical" instead of "humanish". If that word
>  sounds more suitable then this is a [PATCH] and not a [PATCH/RFC].

canonical: "according to recognized rules or scientific laws."
sounds about right. :)

>
>  Documentation/git-submodule.txt | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 74bc6200d..045fef417 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -63,14 +63,6 @@ add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--dep
>         to the changeset to be committed next to the current
>         project: the current project is termed the "superproject".
>  +
> -This requires at least one argument: <repository>. The optional
> -argument <path> is the relative location for the cloned submodule
> -to exist in the superproject. If <path> is not given, the
> -"humanish" part of the source repository is used ("repo" for
> -"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> -The <path> is also used as the submodule's logical name in its
> -configuration entries unless `--name` is used to specify a logical name.
> -+
>  <repository> is the URL of the new submodule's origin repository.
>  This may be either an absolute URL, or (if it begins with ./
>  or ../), the location relative to the superproject's default remote
> @@ -87,21 +79,22 @@ If the superproject doesn't have a default remote configured
>  the superproject is its own authoritative upstream and the current
>  working directory is used instead.
>  +
> -<path> is the relative location for the cloned submodule to
> -exist in the superproject. If <path> does not exist, then the
> -submodule is created by cloning from the named URL. If <path> does
> -exist and is already a valid Git repository, then this is added
> -to the changeset without cloning. This second form is provided
> -to ease creating a new submodule from scratch, and presumes
> -the user will later push the submodule to the given URL.
> +The optional argument <path> is the relative location for the cloned
> +submodule to exist in the superproject. If <path> is not given, the
> +canonical part of the source repository is used ("repo" for
> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git"). If <path>
> +exists and is already a valid Git repository, then this is added
> +to the changeset without cloning.

While this was just reflowed and not newly introduced, I am still left
wondering what a changeset is in Git terms. Our Documentation/glossary
says:

  [[def_changeset]]changeset::
  BitKeeper/cvsps speak for "<<def_commit,commit>>". Since Git does not
  store changes, but states, it really does not make sense to use the term
  "changesets" with Git.

Maybe we should say instead:

    If <path>exists and is already a valid Git repository,
    then this is staged for commit without cloning.




> The <path> is also used as the
> +submodule's logical name in its configuration entries unless `--name`
> +is used to specify a logical name.
>  +
> -In either case, the given URL is recorded into .gitmodules for
> -use by subsequent users cloning the superproject. If the URL is
> -given relative to the superproject's repository, the presumption
> -is the superproject and submodule repositories will be kept
> -together in the same relative location, and only the
> -superproject's URL needs to be provided: git-submodule will correctly
> -locate the submodule using the relative URL in .gitmodules.
> +The given URL is recorded into `.gitmodules` for use by subsequent users
> +cloning the superproject. If the URL is given relative to the
> +superproject's repository, the presumption is the superproject and
> +submodule repositories will be kept together in the same relative
> +location, and only the superproject's URL needs to be provided.
> +git-submodule will correctly locate the submodule using the relative
> +URL in .gitmodules.
>

With or without this nit addressed, this patch looks good to me,

Thanks,
Stefan
