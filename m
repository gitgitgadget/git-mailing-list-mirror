Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1EF1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 20:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeLSUFy (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 15:05:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36505 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeLSUFy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 15:05:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so20293647otk.3
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flqNgFeCxhOO6WhHMWJfnfce98GB69YNK4X7DjL7p5I=;
        b=gqWk6dps7/zximZnihGV1DqfeM26AamqsKRjGYl4vmqcAbZ60hJI8ay8v7jKp84xGZ
         gl44bQHr+GjsJqOaJA7Nz/KahIAhOvb10oYli8N9hT0queNAs2EwAfH8U7zwX97A/k0H
         5gqe1Jaivv8I0oDt3eykUDamSpnqNDI91FiyNE2MdTVVcEIhjMr0RNLKTvRON4VwQQ+I
         K9EP018uY6O5M7dzJrIw0DNrODMQpvznXGuB/9U4Xd5ca8idJXhhO/GoimTGMU6GuRvc
         n5PDye52aEge6UUaRAHzu4nkzrsFFzSrm8R+EyPOPab7PLP21tfgVopiTl21teu/b1tu
         Ewwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flqNgFeCxhOO6WhHMWJfnfce98GB69YNK4X7DjL7p5I=;
        b=PpSk8mySCV9mw6k1YgYof0H/uyXDbAZkT65otdjcY9aq1a6Dtp5+/pvGnuwZAMeaTO
         jHqtZeVlUIrIVtWsgQdpmqpkAb002twWkT5f+eID0SQhWOx9r8Nx873xMweWgi3PShr0
         UZD1YP9DQswtfk4FyU8rFzjVilF/I3tWgqTSp7vyIWjMry6bvW2AXyvXpQf14xF3zkxQ
         /VA9AsPgKPJRYpn5CY78WTA8NK8FHpZhDFtYMfTw/5duBv06S9bA/FEHOPSlzThko+4x
         qxQUdJ0oZVW+Uugf/cbnukyv/2rJP82895LPuZ/whk8LmmaxtekCvJSRn0TUfVGEUB0l
         Oulw==
X-Gm-Message-State: AA+aEWbozYvrs0NXfv6in/++F5RsC83ybeqabF1zjkPZ8DKWS5Fy6Jmc
        Dtu8IpPBODgkgBXernT0x/t4ljv+vE8IiaOsczl37MXA
X-Google-Smtp-Source: AFSGD/XawxrcYGLkaWP5kieKFkjN310gJIioZLOFv0uDFYhh2etFdd65yF6nCnZuyeiWlXtR4wzm6l1yPu7nCURY23o=
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr15150223otk.209.1545249953159;
 Wed, 19 Dec 2018 12:05:53 -0800 (PST)
MIME-Version: 1.0
References: <20181219183939.16358-1-williamh@gentoo.org> <20181219183939.16358-2-williamh@gentoo.org>
In-Reply-To: <20181219183939.16358-2-williamh@gentoo.org>
From:   John Passaro <john.a.passaro@gmail.com>
Date:   Wed, 19 Dec 2018 15:05:15 -0500
Message-ID: <CAJdN7KhyTSSzTrJDPkfTMsJqojo9ReW5VeAikANPZNQSpvQBmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add author and committer configuration settings
To:     William Hubbs <williamh@gentoo.org>
Cc:     git@vger.kernel.org, chutzpah@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 19, 2018 at 2:19 PM William Hubbs <williamh@gentoo.org> wrote:
>
>     The author.email, author.name, committer.email and committer.name
>     settings are analogous to the GIT_AUTHOR_* and GIT_COMMITTER_*
>     environment variables, but for the git config system. This allows them
>     to be set separately for each repository.
>

Great! I didn't realize this wasn't already supported...

However your patch does seem to be missing tests.
t/t7517-per-repo-email.sh would appear to be a logical place to add
them.

> Signed-off-by: William Hubbs <williamh@gentoo.org>
> ---
>  Documentation/config/user.txt | 20 +++++++++++
>  builtin/commit.c              |  2 +-
>  cache.h                       |  5 ++-
>  config.c                      |  6 ++++
>  ident.c                       | 68 ++++++++++++++++++++++++++++++++---
>  log-tree.c                    |  3 +-
>  sequencer.c                   |  3 +-
>  7 files changed, 97 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index b5b2ba1199..6ba7002252 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -1,3 +1,23 @@
> +author.email::
> +Your email address to be recorded on the author line of any newly
> +created commits.
> +If this is not set, we use user.email.
> +
> +author.name::
> +Your full name to be recorded on the author line of any newly
> +created commits.
> +If this is not set, we use user.name.
> +
> +committer.email::
> +Your email address to be recorded on the committer line of any newly
> +created commits.
> +If this is not set, we use user.email.
> +
> +committer.name::
> +Your full name to be recorded on the committer line of any newly
> +created commits.
> +If this is not set, we use user.name.
> +
>  user.email::
>         Your email address to be recorded in any newly created commits.
>         Can be overridden by the `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL`, and

I think it would be wise to mention the new config items under
user.email and user.name as well.
