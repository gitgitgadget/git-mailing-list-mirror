Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CCA2035F
	for <e@80x24.org>; Wed,  9 Nov 2016 00:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbcKIABb (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 19:01:31 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34722 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbcKIAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 19:01:29 -0500
Received: by mail-yw0-f195.google.com with SMTP id l124so7577450ywb.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 16:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9xwS5rdPC3cmlgoEV72S/hFZcJHnAV5lEX9pykLSZxo=;
        b=INye/zHDeBoqD8qwyUqrr+bfJ4PiAORMKbETjJEUufpbpR2q0EyDxrngNAUj80LJGB
         7Xl6f5NhEEX4OwhLhTXK+QSLWVFz5JD8eYOd9ZTJYwY0z0uPe8/P8gtGgsPYN+gyHjaR
         hlnmTp8c9V5mZzCRqBOqYrKDDWySWQ90lnKu+UR2vtYJoIU1adGwUB9S2rJ+wJuz4sYs
         dyiFhprnrEMFC1p/0md0MDaWT6iVun8VE3Czxtm1NbN/crOfnHxqEDB8RIoyLGr343hG
         mHXgSgHOlXXibPwjue4ryg/cntQ/b8mkKil9ozvIx/3KhArbN79frPI0EkydX4YMiHq5
         D7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9xwS5rdPC3cmlgoEV72S/hFZcJHnAV5lEX9pykLSZxo=;
        b=S5k+UFscH0JIcyucsGPYFkDVyLR08ghQIA3fCmMLcnQE1H8mEkPmaUsQbIhFnFmJJI
         OsU+db+iWXFu/ZugPj4rsqc1/KMgm0bK4bbjQE+13XNv5fhiIq/xv+hZ7JMyZshMyOKo
         /xsiQ/jXd8LJEh0/L/5FlCqu42ZYPOXUDnf4e2rQOhmp9ppNGtRi5AAceXC1P4eHyzxK
         Ix0+ukdNyUH6IedhXvVcwsGZm7vbKA0S3y+r9Y0VNKmNTePy8tcO6tyGQgCAf9ppP/GC
         9WgFPgJLxTcHxxoLh1OYQnJ3Jh8V2D4J5J4xmx68MHpKT3Cu5306Fu2VeCO9V5lyfuuu
         Pj9Q==
X-Gm-Message-State: ABUngvehCg5lWcBRvdR3B7+MPvsZ6kqMr+xqVIhekR37wez0zqCbD/vs+oSJo/UZvVOdRdgykDuhdp+tayoiBg==
X-Received: by 10.13.221.12 with SMTP id g12mr16173799ywe.257.1478649688239;
 Tue, 08 Nov 2016 16:01:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 16:01:07 -0800 (PST)
In-Reply-To: <20161108201211.25213-16-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-16-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 16:01:07 -0800
Message-ID: <CA+P7+xrm22pb2jPmTeBux3TmniWKJEeEVqy_J=DawmW2svHq=w@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] branch, tag: use porcelain output
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Call ref-filter's setup_ref_filter_porcelain_msg() to enable
> translated messages for the %(upstream:tack) atom. Although branch.c
> doesn't currently use ref-filter's printing API's, this will ensure
> that when it does in the future patches, we do not need to worry about
> translation.
>

Makes sense.

Thanks,
Jake

> Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/branch.c | 2 ++
>  builtin/tag.c    | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index be9773a..dead2b8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -656,6 +656,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 OPT_END(),
>         };
>
> +       setup_ref_filter_porcelain_msg();
> +
>         memset(&filter, 0, sizeof(filter));
>         filter.kind = FILTER_REFS_BRANCHES;
>         filter.abbrev = -1;
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 50e4ae5..a00e9a7 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -373,6 +373,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>                 OPT_END()
>         };
>
> +       setup_ref_filter_porcelain_msg();
> +
>         git_config(git_tag_config, sorting_tail);
>
>         memset(&opt, 0, sizeof(opt));
> --
> 2.10.2
>
