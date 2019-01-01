Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186591F770
	for <e@80x24.org>; Tue,  1 Jan 2019 10:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfAAKlJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 05:41:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34844 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbfAAKlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 05:41:09 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so35920900itp.0
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 02:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxpZqsXOqP7QwGjTy+2TnpU3kRAj4oIDk2CQQL89iQw=;
        b=BTr6rlkyVSHbsM1LAhf4i0YyjMnmdZhoV2QMy+71J0W3tpU1IXKy8GwZVS9uuo/Tsn
         gx3JFPYg7yw47ABRsPPi2xQE9ABhvMgFjQMw/jobZ180xnlbmZcoRS6dSp7HeNGBRvXE
         v9+jXY3au/4ORsFsNty9JScNu9szcoVkEkpierz9axR6qWA77XI/AMNbK3mL5tSV4+34
         AAownFlaG0UYN1jGpWsDT9W3QItTk3UJKOAzAJ17tgBpcfOPy+d3AeXK4X1PQm94qnPZ
         E/CwFogxnI/GXXJILeJ2cbXRKjJJeKSCspNSQQ0qx7ifgozpbXwb9N2eBFRsoQY6FkTz
         Lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxpZqsXOqP7QwGjTy+2TnpU3kRAj4oIDk2CQQL89iQw=;
        b=ZhgwpI7cdaiaDVZy/iS2SRSpSe8h3G4kV7NZe6fFosQdTNDMNjvmG7nkTgA1PMyHQ6
         LMmD3j4BL43VSAtgAzPEo4U6Rzf5i5iS9K543dWnVtu26A9RbjAZG3KG+VfDFCZk14+n
         fQMZs9TNWv9ai7oEo2UWCIfIuXqs0prAwBrNy5GSZGGDovCck6kTsSFcqWHi0nG+iPoD
         B5glTV4UXI8fYUSRBXRp60IGKAMQakpy57rpBYNl2P3mXGJy+ajQx5lVhn5tYND2gnHW
         Jt8L0giYEs0cI9gyL2BONGUOIXZgg3W7WCZm8yV39NoWg30mK9TCPpX3QLjI0a7920Ar
         WmqQ==
X-Gm-Message-State: AA+aEWZVba1EdK6bDjyRVSFGEk7Tyr8dAInCfLTBUizdNxlA7S2LlEID
        UOGspYQyvRiFqOCqP4HFTeivrYBY+OC0MOeaZQI=
X-Google-Smtp-Source: AFSGD/XZ7uk4l5I+3scw+mIegLpbPzD3cUjz9JhzzjAvsWsQIme3MBzKCY8YIjXo3Xdi3RDX0DhRa30yWzlYqZvZ98s=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr25679724ith.123.1546339267787;
 Tue, 01 Jan 2019 02:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20181231235713.76200-1-aburthinds@gmail.com>
In-Reply-To: <20181231235713.76200-1-aburthinds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 1 Jan 2019 17:40:41 +0700
Message-ID: <CACsJy8D_gTKWXogPDNW7NQk_a0ChBu28HfGu388hFn3-by_cRw@mail.gmail.com>
Subject: Re: [PATCH] doc: remove unneeded TODO for release_commit_memory
To:     Albert Burt <aburthinds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 1, 2019 at 7:02 AM Albert Burt <aburthinds@gmail.com> wrote:
>
> The code that was merged with commit 1102405 left in an TODO that

People usually use something this to produce the commit reference

    git show -s --date=short --pretty='format:%h (%s - %ad)'

which produces

110240588d (Merge branch 'sb/object-store-alloc' - 2018-06-25)

> is no longer relevant. It seems as if we can remove this todo.
> util seems to not be a field of the struct commit,
> definition of struct commit --> commit.c:27
> The commit list also, does not contain a field for util.

There was commit->util, which was deleted in 9d2c97016f (commit.h:
delete 'util' field in struct commit - 2018-05-19). You can mention it
too if you reroll this patch.

> ____
> By making a contribution to this project, I certify that:
>
> a. The contribution was created in whole or in part by me and I
>    have the right to submit it under the open source license
>    indicated in the file; or
>
> b. The contribution is based upon previous work that, to the best
>    of my knowledge, is covered under an appropriate open source
>    license and I have the right under that license to submit that
>    work with modifications, whether created in whole or in part
>    by me, under the same open source license (unless I am
>    permitted to submit under a different license), as indicated
>    in the file; or
>
> c. The contribution was provided directly to me by some other
>    person who certified (a), (b) or (c) and I have not modified
>    it.
>
> d. I understand and agree that this project and the contribution
>    are public and that a record of the contribution (including all
>    personal information I submit with it, including my sign-off) is
>    maintained indefinitely and may be redistributed consistent with
>    this project or the open source license(s) involved.
> ____

I think you can drop this. Your S-o-b below implies all this.

> Signed-off-by: Albert Burt <aburthinds@gmail.com>
> ---
>  commit.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 2d94e0b199..2ff6dca0bc 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -357,8 +357,6 @@ void release_commit_memory(struct commit *c)
>         c->index = 0;
>         free_commit_buffer(c);
>         free_commit_list(c->parents);
> -       /* TODO: what about commit->util? */
> -

Obviously correct :)

>         c->object.parsed = 0;
>  }
>
> --
> 2.17.2 (Apple Git-113)
>


-- 
Duy
