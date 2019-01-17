Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6978E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbfAQUY6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:24:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44918 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfAQUY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:24:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so8794293lfe.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qK+RO/FUVOdAx2nNKMlTbZrampQWpxcYD/tTBxljk34=;
        b=C82Zn5da0bmmJDp7F/RrvVNn3EHGFUJWAUIIQjrIE5MbGT8DN0eRpKkbnBipa/NvSH
         ydCSsTNaKeWLa9dvjrSyBPZDT3K5WZMV/Kpmd88CnacwgNVskXm9ByU9lGvgFzFjJv5R
         LLEsOvEHUydEhjJL58WNHcMzoUuMnS/09NxR6liYsXXDO98ADw0XVNi4kAu2ij8EclSQ
         77pyAL/VV9LGSNiM19HGwyz58Cdt/bdo4FTuQHVqf3jqEitHKuAiwfHsCTqUGfvBhnbS
         HrF3EvH3GgEKuwkxWMVw//+eFpyRRkUcxYRFMgkUJRevlQg0jnZRcE8tv8clf7aXUl0f
         Mp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK+RO/FUVOdAx2nNKMlTbZrampQWpxcYD/tTBxljk34=;
        b=Co8x3FT+/bRmPXJNE6+jRC7+Q266dUvRkQ9pf87h9fdX/lNETBS2zCzGQbWvBjbTbt
         l05Di5HiCvezyvMRbHb5wf3ve3R4WpT5PxRCQxgwKgyjMmQg7uwI9Ins8eE0Sz6UbUcG
         wsEnZG69O272+ZJAkaFIRxmMgu6okZR9rs+AKct72oNEWQaq9PdrunV7shc6r23j2k1S
         NZsyT63z9iwe1Hj3s42znyfX20xzyI/pa9dQqIKNKG5q2J+yoYwy5Cj+K6y/w5ZaYUPn
         lqiAWLzywvQRnTx11CTtEfYiaKBnTJ8CyscPDBi3I6S+QK7s4E9oCfTj3HlrLn1uackv
         H6rw==
X-Gm-Message-State: AJcUukeDVs2F4sAgubbmocuB8S1DDv/p6n0d1uD7gm+QZc2MN2Ciyumr
        S36y4CLAAxgKu7oZxxbmgWIjf8BzoHeuiYfb4O8=
X-Google-Smtp-Source: ALg8bN6t0SrdE5NaEjxAvvUfcosXBgEmxoPR+ucaJlgwSXpw+danFx/vAk3Fq9yh8jYzlDIvwfBUF/OqGVaFjTLkUQk=
X-Received: by 2002:a19:f813:: with SMTP id a19mr10893871lff.67.1547756695618;
 Thu, 17 Jan 2019 12:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20190117192909.26064-1-brandon1024.br@gmail.com>
In-Reply-To: <20190117192909.26064-1-brandon1024.br@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 Jan 2019 21:24:43 +0100
Message-ID: <CAN0heSo_XVK67urjgCVGh23UvzhrquojBjNnp_P2NgS7eCUd1Q@mail.gmail.com>
Subject: Re: [PATCH] Allow usage of --gpg-sign flag in commit-tree builtin.
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

Welcome to the list! :-)

On Thu, 17 Jan 2019 at 20:30, Brandon Richardson
<brandon1024.br@gmail.com> wrote:

> Subject: [PATCH] Allow usage of --gpg-sign flag in commit-tree builtin.

Good find!

Maybe "commit-tree: handle --gpg-sign" which looks more like what we
see in `git log --oneline builtin/commit-tree.c`.

> Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>

It could be worthwhile to note in the proposed commit message that this
option is actually documented, since 55ca3f99ae ("commit-tree: add and
document --no-gpg-sign", 2013-12-13), so it's clearly an omission that
it's not implemented.

> Here are the steps I followed to replicate the issue:
>
> mkdir test && cd test
> git init
> echo 'test' > test.txt
> git hash-object -w test.txt
> git update-index --add --cacheinfo 100644 <blob hash> test.txt
> git write-tree
> git commit-tree --gpg-sign -m 'test commit msg' <tree obj hash>

Have you looked at turning this into a test in the t/ directory?
Grepping a little suggests that t7510-signed-commit.sh might be a good
spot. A test would make the patch more obviously correct, and would make
sure that this doesn't regress in the future.

> -               if (skip_prefix(arg, "-S", &sign_commit))
> +               if (skip_prefix(arg, "-S", &sign_commit) ||
> +                       skip_prefix(arg, "--gpg-sign=", &sign_commit) ||
> +                       skip_prefix(arg, "--gpg-sign", &sign_commit))
>                         continue;

This would match "--gpg-signfoo", which seems like a bug. The first two
`skip_prefix()` calls look ok. Then maybe

  if (!strcmp(arg, "--gpg-sign")) {
          sign_commit = "";
          continue;
  }

That's entirely untested, though.

Thanks for looking into this, rather than just side-stepping it. ;-)

Martin
