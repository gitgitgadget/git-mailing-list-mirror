Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E055A1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 18:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeD2SX4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 14:23:56 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41511 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbeD2SXz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 14:23:55 -0400
Received: by mail-ot0-f193.google.com with SMTP id t1-v6so7309035oth.8
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+mTg09CakH4AFzNToa/H0+lxbS8/HXHeDE87dyEjTvY=;
        b=LqKgQ8EABUZgp9Nn+e4mXv/2J/KUfPGa5BFz0QfOVGY4mKyTgR2outz496RLqOkgY1
         SQh6n6lpcLnF5FuyEY9IbbMHelp/yrPyh8BRCbomckUxmWFP1pnDWhY11ZkURFjUwJ8V
         hMS/DFeVPdOPVYlBL8vZ8Czve7T6LdYZwm7m80ltXMDoJcXkWxugeJrifQUDyHltxOIF
         VBekOi98d/AKCjisfgMWnfAlmgl7dAxhY8QZCT4DXJH3uD46+IC+LPDrL8ofIHY8G/4Z
         RmpfoYYOPzoQt+67+KK6fn3Dja69EpZvP5+WWSDh9iRfHduOhUe6G6SmxzhCY3FVtHAT
         4qog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+mTg09CakH4AFzNToa/H0+lxbS8/HXHeDE87dyEjTvY=;
        b=WPQsKoCkCArTn5bP316W18l6V40KA23yM0D4z/1LPao+vjbLcAWo2Tm3jGl0Ubd7nA
         fxPkqtySjQ1WwC5tVmya+a6H/YV38MkMdgsiB2bSVpPptVJ0mytc4lKmYHmPpbZ1cMAn
         uvznTRLAyuDJ21jJMkqJ6pCCzqMZVyI8SOTRdy24bEic4xEc7q3oGnN6A6uPFFTm6iOH
         5iXC0w8cVPZioZXblMQRmRgD78NXqt/Yjty0OhMuuDZGWnTH6DE2iSS99jpD1Gz7TZpS
         mpYyWzDcsHBZzrjl/wHpzSWKRXwGs1ODlwlNbLj199LiKK/otzicXZ/hJ4umNmWfGCTT
         g8vA==
X-Gm-Message-State: ALQs6tAqaJ6ZUa8ikpRgblqGuXt/YDtBZ+iNQiu05MEDIuXPb5SvUUed
        Eoifp6zjEEtpBEJsIvAQhAGhEE0u0O5+Uthdhow=
X-Google-Smtp-Source: AB8JxZpjYiuX6b/5SySptRIpU2w4NzyYhLG0pn9O+ExjwQRqg3gMwz5lQXLdM7R7t697VFsuw7tcsCXrQKBAh3p0viE=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr7102933otb.356.1525026235024;
 Sun, 29 Apr 2018 11:23:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 29 Apr 2018 11:23:24 -0700 (PDT)
In-Reply-To: <20180429181844.21325-10-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180429181844.21325-1-pclouds@gmail.com>
 <20180429181844.21325-10-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 29 Apr 2018 20:23:24 +0200
Message-ID: <CACsJy8ADj-bTMYDHxRNLOMppOEdPbVwL49u3XCfNBCmoLLZo+A@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] help: use command-list.txt for the source of guides
To:     Duy Nguyen <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip (and others) the changes in this patch make "git help -g" now
lists a lot more guides than just the "common" one as advertised (see
below for the exact list). The man page for "git help -g" also
mentions that it would list "useful" guides, not all guides. But we
have no way to list all guides as far as I can tell.

I guess we have two options forward:

- keep "help -g" to common guide (we can tag common guides in
command-list.txt) and add a new option to list all guides ("help
-ag"?)
- reword the man page to make "help -g" list all guides

I'm ok with either direction. What's your preference?

For comparison, this is the new output

The common Git guides are:
   attributes          Defining attributes per path
   cli                 Git command-line interface and conventions
   core-tutorial       A Git core tutorial for developers
   cvs-migration       Git for CVS users
   diffcore            Tweaking diff output
   everyday            A useful minimum set of commands for Everyday
Git
   glossary            A Git Glossary
   hooks               Hooks used by Git
   ignore              Specifies intentionally untracked files to
ignore
   modules             Defining submodule properties
   namespaces          Git namespaces
   repository-layout   Git Repository Layout
   revisions           Specifying revisions and ranges for Git
   tutorial            A tutorial introduction to Git
   tutorial-2          A tutorial introduction to Git: part two
   workflows           An overview of recommended workflows with Git

compared to the old version

The common Git guides are:

   attributes   Defining attributes per path
   everyday     Everyday Git With 20 Commands Or So
   glossary     A Git glossary
   ignore       Specifies intentionally untracked files to ignore
   modules      Defining submodule properties
   revisions    Specifying revisions and ranges for Git
   tutorial     A tutorial introduction to Git (for version 1.5.1 or
newer)
   workflows    An overview of recommended workflows with Git




On Sun, Apr 29, 2018 at 8:18 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The help command currently hard codes the list of guides and their
> summary in C. Let's move this list to command-list.txt. This lets us
> extract summary lines from Documentation/git*.txt. This also
> potentially lets us list guides in git.txt, but I'll leave that for
> now.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  Documentation/gitattributes.txt        |  2 +-
>  Documentation/gitmodules.txt           |  2 +-
>  Documentation/gitrevisions.txt         |  2 +-
>  Makefile                               |  2 +-
>  builtin/help.c                         | 32 --------------------------
>  command-list.txt                       | 16 +++++++++++++
>  contrib/completion/git-completion.bash | 15 ++++++++----
>  help.c                                 | 18 ++++++++++++---
>  help.h                                 |  1 +
>  t/t0012-help.sh                        |  6 +++++
>  10 files changed, 52 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribute=
s.txt
> index 1094fe2b5b..083c2f380d 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -3,7 +3,7 @@ gitattributes(5)
>
>  NAME
>  ----
> -gitattributes - defining attributes per path
> +gitattributes - Defining attributes per path
>
>  SYNOPSIS
>  --------
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index db5d47eb19..4d63def206 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -3,7 +3,7 @@ gitmodules(5)
>
>  NAME
>  ----
> -gitmodules - defining submodule properties
> +gitmodules - Defining submodule properties
>
>  SYNOPSIS
>  --------
> diff --git a/Documentation/gitrevisions.txt b/Documentation/gitrevisions.=
txt
> index 27dec5b91d..1f6cceaefb 100644
> --- a/Documentation/gitrevisions.txt
> +++ b/Documentation/gitrevisions.txt
> @@ -3,7 +3,7 @@ gitrevisions(7)
>
>  NAME
>  ----
> -gitrevisions - specifying revisions and ranges for Git
> +gitrevisions - Specifying revisions and ranges for Git
>
>  SYNOPSIS
>  --------
> diff --git a/Makefile b/Makefile
> index 71b5b594cd..18696e35b0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1939,7 +1939,7 @@ $(BUILT_INS): git$X
>
>  command-list.h: generate-cmdlist.sh command-list.txt
>
> -command-list.h: $(wildcard Documentation/git-*.txt)
> +command-list.h: $(wildcard Documentation/git*.txt)
>         $(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt =
>$@+ && mv $@+ $@
>
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
> diff --git a/builtin/help.c b/builtin/help.c
> index 83a7d73afe..b58e8d5f6a 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -402,38 +402,6 @@ static void show_html_page(const char *git_cmd)
>         open_html(page_path.buf);
>  }
>
> -static struct {
> -       const char *name;
> -       const char *help;
> -} common_guides[] =3D {
> -       { "attributes", N_("Defining attributes per path") },
> -       { "everyday", N_("Everyday Git With 20 Commands Or So") },
> -       { "glossary", N_("A Git glossary") },
> -       { "ignore", N_("Specifies intentionally untracked files to ignore=
") },
> -       { "modules", N_("Defining submodule properties") },
> -       { "revisions", N_("Specifying revisions and ranges for Git") },
> -       { "tutorial", N_("A tutorial introduction to Git (for version 1.5=
.1 or newer)") },
> -       { "workflows", N_("An overview of recommended workflows with Git"=
) },
> -};
> -
> -static void list_common_guides_help(void)
> -{
> -       int i, longest =3D 0;
> -
> -       for (i =3D 0; i < ARRAY_SIZE(common_guides); i++) {
> -               if (longest < strlen(common_guides[i].name))
> -                       longest =3D strlen(common_guides[i].name);
> -       }
> -
> -       puts(_("The common Git guides are:\n"));
> -       for (i =3D 0; i < ARRAY_SIZE(common_guides); i++) {
> -               printf("   %s   ", common_guides[i].name);
> -               mput_char(' ', longest - strlen(common_guides[i].name));
> -               puts(_(common_guides[i].help));
> -       }
> -       putchar('\n');
> -}
> -
>  static const char *check_git_cmd(const char* cmd)
>  {
>         char *alias;
> diff --git a/command-list.txt b/command-list.txt
> index 3bd23201a6..99ddc231c1 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -139,3 +139,19 @@ gitweb                                  ancillaryint=
errogators
>  git-whatchanged                         ancillaryinterrogators
>  git-worktree                            mainporcelain
>  git-write-tree                          plumbingmanipulators
> +gitattributes                           guide
> +gitcli                                  guide
> +gitcore-tutorial                        guide
> +gitcvs-migration                        guide
> +gitdiffcore                             guide
> +giteveryday                             guide
> +gitglossary                             guide
> +githooks                                guide
> +gitignore                               guide
> +gitmodules                              guide
> +gitnamespaces                           guide
> +gitrepository-layout                    guide
> +gitrevisions                            guide
> +gittutorial-2                           guide
> +gittutorial                             guide
> +gitworkflows                            guide
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 77cfb8a20b..50d14a93dc 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1570,6 +1570,13 @@ _git_grep ()
>         __git_complete_refs
>  }
>
> +__git_all_guides=3D
> +__git_compute_all_guides ()
> +{
> +       test -n "$__git_all_guides" ||
> +       __git_all_guides=3D$(git --list-cmds=3Dlist-guide)
> +}
> +
>  _git_help ()
>  {
>         case "$cur" in
> @@ -1579,11 +1586,9 @@ _git_help ()
>                 ;;
>         esac
>         __git_compute_all_commands
> -       __gitcomp "$__git_all_commands $(__git_aliases)
> -               attributes cli core-tutorial cvs-migration
> -               diffcore everyday gitk glossary hooks ignore modules
> -               namespaces repository-layout revisions tutorial tutorial-=
2
> -               workflows
> +       __git_compute_all_guides
> +       __gitcomp "$__git_all_commands $(__git_aliases) $__git_all_guides
> +               gitk
>                 "
>  }
>
> diff --git a/help.c b/help.c
> index f9da0214f1..f4629d0ee1 100644
> --- a/help.c
> +++ b/help.c
> @@ -39,12 +39,14 @@ static struct category_description main_categories[] =
=3D {
>         { 0, NULL }
>  };
>
> -static const char *drop_prefix(const char *name)
> +static const char *drop_prefix(const char *name, uint32_t category)
>  {
>         const char *new_name;
>
>         if (skip_prefix(name, "git-", &new_name))
>                 return new_name;
> +       if (category =3D=3D CAT_guide && skip_prefix(name, "git", &new_na=
me))
> +               return new_name;
>         return name;
>
>  }
> @@ -66,7 +68,7 @@ static void extract_cmds(struct cmdname_help **p_cmds, =
uint32_t mask)
>                         continue;
>
>                 cmds[nr] =3D *cmd;
> -               cmds[nr].name =3D drop_prefix(cmd->name);
> +               cmds[nr].name =3D drop_prefix(cmd->name, cmd->category);
>
>                 nr++;
>         }
> @@ -358,10 +360,20 @@ void list_cmds_by_category(const char *cat)
>                 struct cmdname_help *cmd =3D command_list + i;
>
>                 if (cmd->category & cat_id)
> -                       puts(drop_prefix(cmd->name));
> +                       puts(drop_prefix(cmd->name, cmd->category));
>         }
>  }
>
> +void list_common_guides_help(void)
> +{
> +       struct category_description catdesc[] =3D {
> +               { CAT_guide, N_("The common Git guides are:") },
> +               { 0, NULL }
> +       };
> +       print_cmd_by_category(catdesc);
> +       putchar('\n');
> +}
> +
>  void list_all_cmds_help(void)
>  {
>         print_cmd_by_category(main_categories);
> diff --git a/help.h b/help.h
> index 090d46ba01..5d27368fe4 100644
> --- a/help.h
> +++ b/help.h
> @@ -18,6 +18,7 @@ static inline void mput_char(char c, unsigned int num)
>
>  extern void list_common_cmds_help(void);
>  extern void list_all_cmds_help(void);
> +extern void list_common_guides_help(void);
>  extern void list_all_main_cmds(void);
>  extern void list_all_other_cmds(void);
>  extern void list_cmds_by_category(const char *category);
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 060df24c2d..bc27df7f38 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -66,6 +66,12 @@ test_expect_success 'git help' '
>         test_i18ngrep "^   commit " help.output &&
>         test_i18ngrep "^   fetch  " help.output
>  '
> +test_expect_success 'git help -g' '
> +       git help -g >help.output &&
> +       test_i18ngrep "^   attributes " help.output &&
> +       test_i18ngrep "^   everyday   " help.output &&
> +       test_i18ngrep "^   tutorial   " help.output
> +'
>
>  test_expect_success 'generate builtin list' '
>         git --list-cmds=3Dbuiltins >builtins
> --
> 2.17.0.664.g8924eee37a
>



--=20
Duy
