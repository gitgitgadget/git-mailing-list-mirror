Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188CB1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeAJUtR (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:49:17 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37396 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeAJUtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:49:14 -0500
Received: by mail-qk0-f178.google.com with SMTP id p13so869806qke.4
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cgR9NbblGZNkxVpy3mNbBZ39nvn/398Qe9IGWfa2cq0=;
        b=eVNZ4gLIsYe1QGtRzAlmPNqBCHrywSEB9KgFL2NI4J928ZQarUSmHgC9OfNbEB5YvP
         y/ppY5ZR8BlPuVcTlTqfdV4z21nPpEmusl4elKx1kVNX2RFBji+8XfeSAPWs6G3JDEIR
         7zQaDE8A4dcMTWr/2fXN8OBa0Qc/ZF8Sad6G2nP7HvNnAWR26fITHdsoQfdYcGPAx9ha
         e/Wx//IBagg6SgcrSt9kiK6evXXP2vkuRnSE8ppRNjJmqlgDfVRekkAh/alMQMHYzHql
         yyH50KF+5LbE93jKTRbMLhZzBTKpOCdfMscsbik50nf8sVatGFYdedfJ9+OkOKmLYIt6
         pyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cgR9NbblGZNkxVpy3mNbBZ39nvn/398Qe9IGWfa2cq0=;
        b=ND2yL9Jhn5clwGhvnrE1fcD3ae2kjjAhvQ5mM0t3hHPY7V7LH+iXfq2Xdc7yeP9fqJ
         EqN60IlqZnBDv9a7xHNj7UkhnPHLCr8E9cjTsl4mnLcJxVw5od/tLwPQk73pHEiSLhXS
         EgRHqfGvnFvJoL5k6aWaga0oKWdyKUTht0x8WurFISmcH9yd7aEvSkZjZhxKYBAQWD0/
         u76SvaPAQaOpGYxXXPzzXYWKD2Z5IsTl57Fiaj6TbZKZb7b40wJQ4+4xMsbbhvL8atxY
         MvwoNLmvGUc5cv1oRwz1zXiJfqwih7SkcliMCCru7HWN+EaCMYVkAGmKvAZT9BxrirfA
         adkA==
X-Gm-Message-State: AKwxytfBYKjmNUO7uCZeS4k0AWdOrSVO1eB9S/wWLBJYZpaBapDrOHPs
        ar0mSfz2YoxrV3mhVStZynLZOrJs6mMJpmmi6SvXTg==
X-Google-Smtp-Source: ACJfBosAOO3eeLrKMmZhlBKbKBcNKPKtJfn0YQ8jglNvpwN+LXhtT4SoMh1BiMedzio8l6U3p+rxLTT22BfNdBpWD/0=
X-Received: by 10.200.64.90 with SMTP id j26mr8590613qtl.29.1515617353482;
 Wed, 10 Jan 2018 12:49:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 10 Jan 2018 12:49:12 -0800 (PST)
In-Reply-To: <20180110064959.5491-2-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180110064959.5491-1-kaartic.sivaraam@gmail.com> <20180110064959.5491-2-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 10 Jan 2018 12:49:12 -0800
Message-ID: <CAGZ79kaEw7m=5c65-7n3kX7-zfPzHMeOXF0r-7D-RjsAEhg3Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Doc/gitsubmodules: make some changes to improve
 readability and syntax
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jon Forrest <nobozo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 10:49 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> * Only mention porcelain commands in examples
>
> * Split a sentence for better readability
>
> * Add missing apostrophes
>
> * Clearly specify the advantages of using submodules
>
> * Avoid abbreviations
>
> * Use "Git" consistently
>
> * Improve readability of certain lines
>
> * Clarify when a submodule is considered active
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---

Thanks for sending it in one patch,
Stefan

>  Documentation/gitsubmodules.txt | 93 +++++++++++++++++++++++++++++++----=
------
>  1 file changed, 72 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodule=
s.txt
> index 46cf120f6..ce2369c2d 100644
> --- a/Documentation/gitsubmodules.txt
> +++ b/Documentation/gitsubmodules.txt
> @@ -36,8 +36,8 @@ The `gitlink` entry contains the object name of the com=
mit that the
>  superproject expects the submodule=E2=80=99s working directory to be at.
>
>  The section `submodule.foo.*` in the `.gitmodules` file gives additional
> -hints to Gits porcelain layer such as where to obtain the submodule via
> -the `submodule.foo.url` setting.
> +hints to Git's porcelain layer. For example, the `submodule.foo.url`
> +setting specifies where to obtain the submodule.
>
>  Submodules can be used for at least two different use cases:
>
> @@ -51,18 +51,21 @@ Submodules can be used for at least two different use=
 cases:
>
>  2. Splitting a (logically single) project into multiple
>     repositories and tying them back together. This can be used to
> -   overcome current limitations of Gits implementation to have
> +   overcome current limitations of Git's implementation to have
>     finer grained access:
>
> -    * Size of the git repository:
> +    * Size of the Git repository:
>        In its current form Git scales up poorly for large repositories co=
ntaining
>        content that is not compressed by delta computation between trees.
> -      However you can also use submodules to e.g. hold large binary asse=
ts
> -      and these repositories are then shallowly cloned such that you do =
not
> +      For example, you can use submodules to hold large binary assets
> +      and these repositories can be shallowly cloned such that you do no=
t
>        have a large history locally.
>      * Transfer size:
>        In its current form Git requires the whole working tree present. I=
t
>        does not allow partial trees to be transferred in fetch or clone.
> +      If the project you work on consists of multiple repositories tied
> +      together as submodules in a superproject, you can avoid fetching t=
he
> +      working trees of the repositories you are not interested in.
>      * Access control:
>        By restricting user access to submodules, this can be used to impl=
ement
>        read/write policies for different users.
> @@ -73,9 +76,10 @@ The configuration of submodules
>  Submodule operations can be configured using the following mechanisms
>  (from highest to lowest precedence):
>
> - * The command line for those commands that support taking submodule spe=
cs.
> -   Most commands have a boolean flag '--recurse-submodules' whether to
> -   recurse into submodules. Examples are `ls-files` or `checkout`.
> + * The command line for those commands that support taking submodules
> +   as part of their pathspecs. Most commands have a boolean flag
> +   `--recurse-submodules` which specify whether to recurse into submodul=
es.
> +   Examples are `grep` and `checkout`.
>     Some commands take enums, such as `fetch` and `push`, where you can
>     specify how submodules are affected.
>
> @@ -87,8 +91,8 @@ Submodule operations can be configured using the follow=
ing mechanisms
>  For example an effect from the submodule's `.gitignore` file
>  would be observed when you run `git status --ignore-submodules=3Dnone` i=
n
>  the superproject. This collects information from the submodule's working
> -directory by running `status` in the submodule, which does pay attention
> -to its `.gitignore` file.
> +directory by running `status` in the submodule while paying attention
> +to the `.gitignore` file of the submodule.
>  +
>  The submodule's `$GIT_DIR/config` file would come into play when running
>  `git push --recurse-submodules=3Dcheck` in the superproject, as this wou=
ld
> @@ -97,20 +101,20 @@ remotes are configured in the submodule as usual in =
the `$GIT_DIR/config`
>  file.
>
>   * The configuration file `$GIT_DIR/config` in the superproject.
> -   Typical configuration at this place is controlling if a submodule
> -   is recursed into at all via the `active` flag for example.
> +   Git only recurses into active submodules (see 'ACTIVE SUBMODULES'
> +   section below).

The section below is capitalized differently?


>  +
>  If the submodule is not yet initialized, then the configuration
> -inside the submodule does not exist yet, so configuration where to
> +inside the submodule does not exist yet, so where to
>  obtain the submodule from is configured here for example.
>
> - * the `.gitmodules` file inside the superproject. Additionally to the
> -   required mapping between submodule's name and path, a project usually
> + * The `.gitmodules` file inside the superproject. A project usually
>     uses this file to suggest defaults for the upstream collection
> -   of repositories.
> +   of repositories for the mapping that is required between a
> +   submodule's name and its path.
>  +
> -This file mainly serves as the mapping between name and path in
> -the superproject, such that the submodule's git directory can be
> +This file mainly serves as the mapping between the name and path of subm=
odules
> +in the superproject, such that the submodule's Git directory can be
>  located.
>  +
>  If the submodule has never been initialized, this is the only place
> @@ -137,8 +141,8 @@ directory is automatically moved to `$GIT_DIR/modules=
/<name>/`
>  of the superproject.
>
>   * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
> -but no submodule working directory. The submodule=E2=80=99s git director=
y
> -may be there as after deinitializing the git directory is kept around.
> +but no submodule working directory. The submodule=E2=80=99s Git director=
y
> +may be there as after deinitializing the Git directory is kept around.
>  The directory which is supposed to be the working directory is empty ins=
tead.
>  +
>  A submodule can be deinitialized by running `git submodule deinit`.
> @@ -160,6 +164,53 @@ from another repository.
>  To completely remove a submodule, manually delete
>  `$GIT_DIR/modules/<name>/`.


> +Active submodules

The examples were not meant to be taken literally into the patch. ;)
(I should have been more careful for that :P)

> +-----------------
> +
> +A submodule is considered active,
> +
> +  (a) if `submodule.<name>.active` is set
> +     or
> +  (b) if the submodules path matches the pathspec in `submodule.active`
> +     or
> +  (c) if `submodule.<name>.url` is set.

and these are evaluated in this order, so if (a) or (b) is set but
indicates that the submodule is not active, we're done evaluating.
as seen by the example, if we have an .active =3D false set, the url
doesn't matter whether it is present or not.

> +
> +For example:
> +
> +    [submodule "foo"]
> +        active =3D false
> +        url =3D https://example.org/foo
> +    [submodule "bar"]
> +        active =3D true
> +        url =3D https://example.org/bar
> +    [submodule "baz"]
> +        url =3D https://example.org/baz
> +
> +In the above config only the submodule bar and baz are active,
> +bar due to (a) and baz due to (c).

"foo" is inactive because (a) takes precedence over (c).

> +
> +Note that '(c)' is a historical artefact and will be ignored if the
> +pathspec set in (b) excludes the submodule. For example:
> +
> +    [submodule "foo"]
> +        active =3D true
> +        url =3D https://example.org/foo
> +    [submodule "bar"]
> +        url =3D https://example.org/bar
> +    [submodule "baz"]
> +        url =3D https://example.org/baz
> +    [submodule "bob"]
> +        ignore =3D true
> +    [submodule]
> +        active =3D b*
> +        active =3D (:exclude) baz

 :(exclude)baz

This is regular pathspec magic, see 'pathspec' in 'man gitglossary'

> +In here all submodules except baz (foo, bar, bob) are active.
> +'foo' due to its own active flag and all the others due to the
> +submodule active pathspec, which specifies that any submodule
> +starting with 'b' except 'baz' are also active, no matter if
> +the .url field is present.
> +
>  Workflow for a third party library
>  ----------------------------------
>
> --
> 2.16.0.rc0.223.g4a4ac8367
>
