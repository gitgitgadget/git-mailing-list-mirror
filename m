Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D7E1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeAPUDz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 15:03:55 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:39354 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeAPUDy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 15:03:54 -0500
Received: by mail-yw0-f170.google.com with SMTP id q26so7309826ywa.6
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wKLKz1HJ5SwKd8zka3w/i+WhQafMgzBcwwKef8/oXI8=;
        b=XzCPyPlgAfvXZ01oDRGlF4bPU2TBQbnGWeCt6fXYEFUe4cR5qCpZJJzy0AGNEeF1R1
         prrHuw7Liljdjtb37NGiZQB7y0KgFiMbjxdevkv94I77GT/R09a2VBpIx73UXHk593UU
         htN2xuz2CsJ99spiuu4amaRb5qkjkXYvVb/90kOw8yXnjbGPRJTUIvHD7vlK/qKJ5gEJ
         GPdUUhXY7FdVfx4qXdPgrIWPxhlQWa5+9VmctUQuaFPl+JVbL4DnYNBebzqMeulEJwo8
         o8rxOERpVIWwnH8HP10LXgJ4D8O/I8Yo0lH5w0iZ01iyNGK4zrdw1LzNO1NUObLNr3ju
         UDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wKLKz1HJ5SwKd8zka3w/i+WhQafMgzBcwwKef8/oXI8=;
        b=FE6a8r4OxNuPqyZkMiZBGwUsLJ1UXMDvFGKWFmSpTCTYdXkRCTvd4U6uBMtj2r4TTT
         2Jn+mtgRjZ7xKaC/Rw+ideGFnlTZVnikVLd8/86VE8N2FaA23n4qVbgzyPepbksAPtPh
         KLWhHCvqebjU8KkVSl2T5Urtm42yOl0bV6WHk1Po9BM0yfr4NXKS3nGoyXAij8vf6PbR
         5P9kP1S6F6tSG/MlTgqteUAeK8TSTOhMJPcF+4u4d02d8uZyysnOfNAVhcyMJkULIUtP
         JwhDHN9j62KrtANzWHsubrfkm103hlsN8UC6NTLPVfvo5IffM6VBHeCJRgcYZjwD3Znq
         wUUg==
X-Gm-Message-State: AKwxytdv8yTLujacb6Pow639+8N5AT+foMGbTpQl9WWCbeSVjyH/2pbB
        oVJhbBCdzfmQ1NYvrm86xGzGbLoc0fpJw4okEisY8g==
X-Google-Smtp-Source: ACJfBovR0vtE/mcKGu0dFSwcFglvkfwPHXAFpMpw7uu0wih1NOCC1Uu95tzTZyW/55vHyPDE2zbFyp5PXms4sUGovbs=
X-Received: by 10.129.119.131 with SMTP id s125mr359257ywc.166.1516133033128;
 Tue, 16 Jan 2018 12:03:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.134.197 with HTTP; Tue, 16 Jan 2018 12:03:52 -0800 (PST)
In-Reply-To: <20180114173737.13012-2-kaartic.sivaraam@gmail.com>
References: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
 <20180114173737.13012-1-kaartic.sivaraam@gmail.com> <20180114173737.13012-2-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 16 Jan 2018 12:03:52 -0800
Message-ID: <CAGZ79kZYidKKCNF1=ZCZaOgpNZu-tuaD4_56V1DTd9++_8YN=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Doc/gitsubmodules: make some changes to improve
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

On Sun, Jan 14, 2018 at 9:37 AM, Kaartic Sivaraam
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

Thanks,
Stefan

>  Documentation/gitsubmodules.txt | 100 +++++++++++++++++++++++++++++++---=
------
>  1 file changed, 79 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodule=
s.txt
> index 46cf120f6..4d6c17782 100644
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
> +   Git only recurses into active submodules (see "ACTIVE SUBMODULES"
> +   section below).
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
> @@ -160,6 +164,60 @@ from another repository.
>  To completely remove a submodule, manually delete
>  `$GIT_DIR/modules/<name>/`.
>
> +ACTIVE SUBMODULES
> +-----------------
> +
> +A submodule is considered active,
> +
> +  (a) if `submodule.<name>.active` is set to `true`
> +     or
> +  (b) if the submodule's path matches the pathspec in `submodule.active`
> +     or
> +  (c) if `submodule.<name>.url` is set.
> +
> +and these are evaluated in this order.
> +
> +For example:
> +
> +  [submodule "foo"]
> +    active =3D false
> +    url =3D https://example.org/foo
> +  [submodule "bar"]
> +    active =3D true
> +    url =3D https://example.org/bar
> +  [submodule "baz"]
> +    url =3D https://example.org/baz
> +
> +In the above config only the submodule 'bar' and 'baz' are active,
> +'bar' due to (a) and 'baz' due to (c). 'foo' is inactive because
> +(a) takes precedence over (c)
> +
> +Note that (c) is a historical artefact and will be ignored if the
> +(a) and (b) specify that the submodule is not active. In other words,
> +if we have an `submodule.<name>.active` set to `false` or if the
> +submodule's path is excluded in the pathspec in `submodule.active`, the
> +url doesn't matter whether it is present or not. This is illustrated in
> +the example that follows.
> +
> +  [submodule "foo"]
> +    active =3D true
> +    url =3D https://example.org/foo
> +  [submodule "bar"]
> +    url =3D https://example.org/bar
> +  [submodule "baz"]
> +    url =3D https://example.org/baz
> +  [submodule "bob"]
> +    ignore =3D true
> +  [submodule]
> +    active =3D b*
> +    active =3D :(exclude) baz
> +
> +In here all submodules except 'baz' (foo, bar, bob) are active.
> +'foo' due to its own active flag and all the others due to the
> +submodule active pathspec, which specifies that any submodule
> +starting with 'b' except 'baz' are also active, regardless of the
> +presence of the .url field.
> +
>  Workflow for a third party library
>  ----------------------------------
>
> --
> 2.16.0.rc1.281.g969645f98
>
