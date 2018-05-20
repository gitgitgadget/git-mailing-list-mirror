Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E7F1F51C
	for <e@80x24.org>; Sun, 20 May 2018 14:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeETO1f (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 10:27:35 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45231 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeETO1e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 10:27:34 -0400
Received: by mail-ua0-f194.google.com with SMTP id j5-v6so8300154uak.12
        for <git@vger.kernel.org>; Sun, 20 May 2018 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h3Ze2RxcdoYAJtO3WNXVYoQ5j3a6QyDXB8HY7OS6wgo=;
        b=hTHsXB94WLAmumd7ZoauuJ+2LVdy1sPw2l0FstpvmN+yntdUXSwivK0izvX5Oo1EPI
         twsIdahxXoxWA2BpPsi/VcnsHrE5/T0iLSaCMDKvX9pgiA+h/cQn1NIxv0dlMg1A8BS+
         wwdHbag5fnB//CPs6XhbplE25nc6B8D4Om2A9Yn5TboaVe+iX7Xe8nnfqdhfjGCVXpSA
         zFyD3PiLPAGf5kRTD5dgl6jaoiMxLYWpsZoFl0h0UhMw6IFA/WtTXR/qOnGbCPrSvuqT
         N6F6cyGIPwmA+41h3nF/wh39TPL5NA1dEep8eK8WIqrZg1BM4dr7cLQYT8M5sThIMTP5
         Jyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h3Ze2RxcdoYAJtO3WNXVYoQ5j3a6QyDXB8HY7OS6wgo=;
        b=GOYDQ90CS7oQruEQ/Th/IcDb7fBfFDBfsr7qUUuBUSS/wo3B2AE5dD+RnoTTHYSw0F
         nca8MVJ7+RSVuB+altjASKH0zUwmQcuRewf6F+oXATjHaokjbdGLdF+DXt9U9qvVu8xN
         rdJcUQ59amjB3S0W3tgP0pVfN4oTnrD46IX8ldHweMhDPzjXsX8pi3q1+7AMeZOP+cbV
         cYOQ+1uYvcByqYB3FsPuv9acL2vo/omjO4gFIfOWDKSKP0c3BUcFZ6skM/XDJE0gsPCZ
         t90lnauzYcMCSPn8pl6m0lzjJ/2DaY3JLFrpTS5t5e2qswLn11Y8zzQNczWLxUQZZDUt
         4e2A==
X-Gm-Message-State: ALKqPwcA6fKvh4KS3qsTiwzxjoMbNI0GcaLM/2XZTLA+D6sZUReVM/fh
        +K5RKERBohwVK2ANHBwLGD3PUL6gVUFRZ5jOoHo=
X-Google-Smtp-Source: AB8JxZrQAidg6GmUH4ieiU30HETZtOE9xHrNr7zkE1dVDWp/y0YnfG3m+ee5JYUBf0kR54D2jD/X+XfvjThG6XWQ0rc=
X-Received: by 2002:a9f:2d98:: with SMTP id v24-v6mr12314514uaj.5.1526826452896;
 Sun, 20 May 2018 07:27:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.22.212 with HTTP; Sun, 20 May 2018 07:27:32 -0700 (PDT)
In-Reply-To: <20180519042752.8666-15-pclouds@gmail.com>
References: <20180519042752.8666-1-pclouds@gmail.com> <20180519042752.8666-15-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sun, 20 May 2018 16:27:32 +0200
Message-ID: <CAM0VKjn1WyRgGZDidPjr3YatRV65h_sSzQQpg+=OUtiaTxMgpw@mail.gmail.com>
Subject: Re: [PATCH 14/14] completion: allow to customize the completable
 command list
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 19, 2018 at 6:27 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> By default we show porcelain, external commands and a couple others
> that are also popular. If you are not happy with this list, you can
> now customize it. See the big comment block for details.
>
> PS. perhaps I should make aliases a group too, which makes it possible
> to _not_ complete aliases by omitting this special group in
> $GIT_COMPLETION_CMD_GROUPS

Note that the completion script reads the configured aliases each time
the user attempts to complete commands.  So if the user adds or
removes an alias, then it will automatically be taken into account the
next time after 'git <TAB>'.  By turning aliases into a group listed
by 'git help' they would be cached like all other commands, so this
would no longer be the case.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  Documentation/config.txt               | 10 ++++++++
>  contrib/completion/git-completion.bash | 28 +++++++++++++++++++++-
>  git.c                                  |  2 ++
>  help.c                                 | 33 ++++++++++++++++++++++++++
>  help.h                                 |  1 +
>  5 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2659153cb3..91f7eaed7b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1343,6 +1343,16 @@ credential.<url>.*::
>  credentialCache.ignoreSIGHUP::
>         Tell git-credential-cache--daemon to ignore SIGHUP, instead of qu=
itting.
>
> +completion.commands::
> +       This is only used by git-completion.bash to add or remove
> +       commands from the complete list. Normally only porcelain

s/complete list/list of completed commands/ perhaps?

> +       commands and a few select others are in the complete list. You

s/in the complete list/completed/

> +       can add more commands, separated by space, in this
> +       variable. Prefixing the command with '-' will remove it from
> +       the existing list.
> ++
> +This variable should not be per-repository.

I think this should also mention that changing the value of this
config variable will not immediately affect the commands listed after
'git <TAB>', but the user will have to re-dot-source the completion
script first.

The way I understand the rest of the patch, this config variable
doesn't have any effect if $GIT_COMPLETION_CMD_GROUPS doesn't contain
"config".  If that is indeed the case, then that should be mentioned
here as well.

Having said that, I wonder whether we should really require "config"
in $GIT_COMPLETION_CMD_GROUPS.  Isn't having 'completion.commands' set
in the config a clear enough indication in itself that the user wants
to customize the listed commands?

> +
>  include::diff-config.txt[]
>
>  difftool.<tool>.path::
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index cd1d8e553f..f237eb0ff4 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -38,6 +38,29 @@
>  #
>  #     When set to "1", do not include "DWIM" suggestions in git-checkout
>  #     completion (e.g., completing "foo" when "origin/foo" exists).
> +#
> +#   GIT_COMPLETION_CMD_GROUPS
> +#
> +#     When set, "git --list-cmds=3D$GIT_COMPLETION_CMD_GROUPS" will be
> +#     used to get the list of completable commands. The default is
> +#     "mainporcelain,others,list-complete" (in English: all porcelain

Mental note #1: "mainporcelain"

> +#     commands and external ones are included. Certain non-porcelain
> +#     commands are also marked for completion in command-list.txt).
> +#     You could for example complete all commands with
> +#
> +#         GIT_COMPLETION_CMD_GROUPS=3Dmain,others

Mental note #2: "main"

> +#
> +#     Or you could go with main porcelain only and extra commands in
> +#     the configuration variable completion.commands with
> +#
> +#         GIT_COMPLETION_CMD_GROUPS=3Dmainporcelain,config
> +#
> +#     Or go completely custom group with
> +#
> +#         GIT_COMPLETION_CMD_GROUPS=3Dconfig
> +#
> +#     Or you could even play with other command categories found in
> +#     command-list.txt.
>
>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
> @@ -842,8 +865,11 @@ __git_commands () {
>                 if test -n "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
>                 then
>                         printf "%s" "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
> +               elif test -n "$GIT_COMPLETION_CMD_GROUPS"
> +               then
> +                       git --list-cmds=3D"$GIT_COMPLETION_CMD_GROUPS"
>                 else
> -                       git --list-cmds=3Dlist-mainporcelain,others,list-=
complete
> +                       git --list-cmds=3Dlist-mainporcelain,others,list-=
complete,config

So first it was "mainporcelain", then simply "main", then
"mainporcelain" again, and now "list-mainporcelain"?!
You've lost me here.

Are the possible values documented anywhere?

Furthermore, the default value mentioned in the comments above didn't
include "config", either (but then again, I don't think we really need
"config" in the first place).

>                 fi
>                 ;;
>         all)
> diff --git a/git.c b/git.c
> index 4d5b8a9931..ea4feedd0b 100644
> --- a/git.c
> +++ b/git.c
> @@ -60,6 +60,8 @@ static int list_cmds(const char *spec)
>                         list_all_main_cmds(&list);
>                 else if (match_token(spec, len, "others"))
>                         list_all_other_cmds(&list);
> +               else if (match_token(spec, len, "config"))
> +                       list_cmds_by_config(&list);
>                 else if (len > 5 && !strncmp(spec, "list-", 5)) {
>                         struct strbuf sb =3D STRBUF_INIT;
>
> diff --git a/help.c b/help.c
> index 23924dd300..abf87205b2 100644
> --- a/help.c
> +++ b/help.c
> @@ -366,6 +366,39 @@ void list_cmds_by_category(struct string_list *list,
>         }
>  }
>
> +void list_cmds_by_config(struct string_list *list)
> +{
> +       const char *cmd_list;
> +
> +       /*
> +        * There's no actual repository setup at this point (and even
> +        * if there is, we don't really care; only global config
> +        * matters). If we accidentally set up a repository, it's ok
> +        * too since the caller (git --list-cmds=3D) should exit shortly
> +        * anyway.
> +        */
> +       if (git_config_get_string_const("completion.commands", &cmd_list)=
)
> +               return;
> +
> +       string_list_sort(list);
> +       string_list_remove_duplicates(list, 0);
> +
> +       while (*cmd_list) {
> +               struct strbuf sb =3D STRBUF_INIT;
> +               const char *p =3D strchrnul(cmd_list, ' ');
> +
> +               strbuf_add(&sb, cmd_list, p - cmd_list);
> +               if (*cmd_list =3D=3D '-')
> +                       string_list_remove(list, cmd_list + 1, 0);
> +               else
> +                       string_list_insert(list, sb.buf);
> +               strbuf_release(&sb);
> +               while (*p =3D=3D ' ')
> +                       p++;
> +               cmd_list =3D p;
> +       }
> +}
> +
>  void list_common_guides_help(void)
>  {
>         struct category_description catdesc[] =3D {
> diff --git a/help.h b/help.h
> index b2293e99be..3b38292a1b 100644
> --- a/help.h
> +++ b/help.h
> @@ -26,6 +26,7 @@ extern void list_all_main_cmds(struct string_list *list=
);
>  extern void list_all_other_cmds(struct string_list *list);
>  extern void list_cmds_by_category(struct string_list *list,
>                                   const char *category);
> +extern void list_cmds_by_config(struct string_list *list);
>  extern const char *help_unknown_cmd(const char *cmd);
>  extern void load_command_list(const char *prefix,
>                               struct cmdnames *main_cmds,
> --
> 2.17.0.705.g3525833791
>
