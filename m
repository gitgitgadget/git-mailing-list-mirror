Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B29B1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbeHVSvb (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 14:51:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32784 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHVSvb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 14:51:31 -0400
Received: by mail-io0-f194.google.com with SMTP id r196-v6so1758008iod.0
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 08:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZdrU5KcfNYLoXRqFfKBD9bGt/DxTP8Lq6c6D0QE6BXI=;
        b=eBfkYWprxMEtPS4f8b2bZs40n1vc12CSodOw8HA1/Mi/KdccrkgQPEY+G4N9LnyrzG
         g55CmAI5yE4m06RC4wlvxXgsAQ/ez1d9sEgXN+SDlTL6X/lE0K3EuP96N8VzYttTyEwD
         QxPr65nxJagQ1VyGXjpsopBCf9mbcLtqt6G6bMBtdQoc7PptVx3swAWPfiiGDHLeWSJ+
         8qzw0SySDe3t1jPKXem5cAPJJvediguf7DFPiZX+iUS86uxCGloY/EWDTBfcFykd+UbL
         tfVSM5jFf12x7HZzwaIXz730UXkKD2sF7Xm9aXK14RETMZhhH4sKvoR8tqmdWv7PIWZ1
         uoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZdrU5KcfNYLoXRqFfKBD9bGt/DxTP8Lq6c6D0QE6BXI=;
        b=EmU+odFc1LdIuDE/nHkhsvGi1WQwap+fpkeEe51QJMT1KgVnGdvVvYBG9M7YJk7AoQ
         uWjemZ/YIpMjUOpaZGYeVy8J1+gaxOC4+Ic82VOSGzT/AOoJONG/lPI5CbyQG3dC/wP+
         uSwZoM95C5N/xPFZ7Eh3gOgOrole6DaI5KZipZhoO53As29aNecGnqkGgksftvtFWNFI
         logYbnB4WNUvpeTUtAq6vDZtYgMZxbdoxnuYEXXHIBVkxT7bvWoJQqSbS0KV71OcQLar
         uGHZnDKzWQ8LFw2L2dbh7NBh/50JTjnrgcb5N51jhD7K6idm5sd6rlDXSlo1Q++byFPw
         cyvA==
X-Gm-Message-State: APzg51DzjqUSg1IkvV11jXfJ56JdOz3ES+AINnXnKbm8n4xZcN7t2adW
        j1ea2r8DVJN+oSDRRMo7Ykrh/W4OZoOJ38pK+JI=
X-Google-Smtp-Source: ANB0VdZ5GZ+mdo+gKsMWB4/+bSCJ32/oCQZy9H57bAxvzH61qgfM/GQopUvtHh0xUA8hgYVi6DzxtIW8J99SEjQNlJY=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr11430203iok.236.1534951570842;
 Wed, 22 Aug 2018 08:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180822131547.56899-1-dstolee@microsoft.com>
In-Reply-To: <20180822131547.56899-1-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 22 Aug 2018 17:25:44 +0200
Message-ID: <CACsJy8C6DPTjhLm0tgyK4+RepQmWBkxnwTwoUhVvDYoXC_+m4w@mail.gmail.com>
Subject: Re: [PATCH] config: fix commit-graph related config docs
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 3:18 PM Derrick Stolee <dstolee@microsoft.com> wrot=
e:
>
> The core.commitGraph config setting was accidentally removed from
> the config documentation. In that same patch, the config setting
> that writes a commit-graph during garbage collection was incorrectly
> written to the doc as "gc.commitGraph" instead of "gc.writeCommitGraph".
>
> Reported-by: Szeder G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>
> Szeder reported this in [1] and I forgot until now to come back to it.
>
> [1] https://public-inbox.org/git/20180803093909.2853-1-szeder.dev@gmail.c=
om/
>
>  Documentation/config.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1c42364988..f846543414 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -917,7 +917,11 @@ core.notesRef::
>  This setting defaults to "refs/notes/commits", and it can be overridden =
by
>  the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>
> -gc.commitGraph::
> +core.commitGraph::
> +       Enable git commit graph feature. Allows reading from the
> +       commit-graph file.
> +
> +gc.writeCommitGraph::

Do

git grep -i '^[a-z.]*::' Documentation/config.txt

and you will see that we (mostly) group config keys by section.
There's already gc group and this gc.writeCommitGraph belongs there,
not in the middle of "core" stuff.

>         If true, then gc will rewrite the commit-graph file when
>         linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
>         '--auto' the commit-graph will be updated if housekeeping is
>
> base-commit: 7e8bfb0412581daf8f3c89909f1d37844e8610dd
> --
> 2.19.0.rc0
>


--=20
Duy
