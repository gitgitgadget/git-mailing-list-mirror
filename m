Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EFA41F462
	for <e@80x24.org>; Fri, 26 Jul 2019 05:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfGZFB0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 01:01:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38107 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfGZFBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 01:01:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so38223798qkk.5
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 22:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkHYBxfAXNhVX++Tagct47fR2ih4TQi93TcUhogxx/E=;
        b=pcjzx7Wf5U9I6UwjGgHsIh5dx7kb86JEjQIaPOVcx60GMJXjno+Bmuh4T3lkJ0raJl
         URBEmEHI7soN2OmQWaGkk+ELP/X35tLhvQ5HSJ0F9/QWFifKb/cwIQuI0dXvpOJwtGLw
         +wIW8DAIVhxiZPF99is4JNwM/T8sxfA7sskPjgUIk/hvxLBUIa0KuiBRx6mU+0Hd90dv
         84QBHUzDGkUVd1iu07cT37kc0snWbahL08yYTmYCjwMOgzNWmLtZbbN3eawlTT+1ui1Y
         /2lRsS8zUd57NWUPczTycKRaNoSKImbZmcSyYhtaGFaEqCZS74jGi/5uLifYy546bhnR
         StQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkHYBxfAXNhVX++Tagct47fR2ih4TQi93TcUhogxx/E=;
        b=q2b/4yxoyJ6VzjHWU2QQIKrDZWX406jsExsEikUOe6ASek3TqwtXXdtINEkFWapb22
         lARnvPvfm4arsOQIHB7G0LizaO40/Z+Bpuolo+6yeR8HeTZFlOi20F23qeVZQlqBVjPS
         xv8BYUtzrgucP9hTeJCYbJhIeUGY/JlAR5lNW5tKx+hrqhydD/YesJDpHvXbZMfxPs4C
         BAOXiZcAg+w1BZ6t7FNhpE617JRq6auPaGk9co0oLMqqJ+r3x2LzO2IPKHQbQpBBM4ZN
         ry8+XTHcqfNxKCZRmNMBb6FrxGtppMpEVWTJ7/wKS4RZ17qHO2NhIP/60KwfomoNM0Qc
         yA7g==
X-Gm-Message-State: APjAAAVYkd7M5jS41lmwhyNrQ1Tv/jV90ac1crPbsK+pfdjSEL74EESg
        ycnpRrTfYDWRGhZG/omY4xRSBwT1IgeHKYCIrOc=
X-Google-Smtp-Source: APXvYqzovmdHNGpfUkvG2Fqd5oxL0+S9AtTn4gfDJN/grVIGi/N1XcHn0Q+k2qA2Fne28CpXXhEvN0XN/IK5XVrGdH0=
X-Received: by 2002:a37:4986:: with SMTP id w128mr60068273qka.417.1564117284797;
 Thu, 25 Jul 2019 22:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190726045645.2437-1-vcnaik94@gmail.com>
In-Reply-To: <20190726045645.2437-1-vcnaik94@gmail.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Thu, 25 Jul 2019 22:01:13 -0700
Message-ID: <CAK_rgsG2ghwqDfRzyAy9MvFujsR=-Hy7YRiAv=RH1DpoZ-06hA@mail.gmail.com>
Subject: Re: [PATCH] checkout.c: unstage empty deleted ita files
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got the CC list wrong in the first email...

Varun


On Thu, Jul 25, 2019 at 9:57 PM Varun Naik <vcnaik94@gmail.com> wrote:
>
> It is possible to delete a committed file from the index and then add it
> as intent-to-add. After `git checkout HEAD` or `git restore --staged`,
> the file should be identical in the index and HEAD. This patch provides
> the desired behavior even when the file is empty in the index.
>
> Signed-off-by: Varun Naik <vcnaik94@gmail.com>
> ---
> CC Jeff because you wrote the code that I am changing now.
>
> checkout.c:update_some() discards the newly created cache entry when its
> mode and oid match those of the old entry. Since an ita file has the
> same oid as an empty file, an empty deleted ita file passes both of
> these checks, and the new entry is discarded. In this case, the file
> should be added to the cache instead.
>
> This change should not affect newly added ita files. For those, inside
> tree.c:read_tree_1(), tree_entry_interesting() returns
> entry_not_interesting, so fn (which points to update_some()) is never
> called.
>
> To the best of my understanding, the only other command that makes
> changes to the index differently for nonempty vs empty deleted ita files
> is "reset", which I am fixing in [0]. I am separating the two changes
> because this change affects "restore", which has not reached maint yet.
>
> [0]: https://public-inbox.org/git/20190726044806.2216-1-vcnaik94@gmail.com/
>
>  builtin/checkout.c        |  1 +
>  t/t2022-checkout-paths.sh | 11 +++++++++++
>  t/t2070-restore.sh        | 11 +++++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 91f8509f85..27daa09c3c 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -126,6 +126,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
>         if (pos >= 0) {
>                 struct cache_entry *old = active_cache[pos];
>                 if (ce->ce_mode == old->ce_mode &&
> +                   !ce_intent_to_add(old) &&
>                     oideq(&ce->oid, &old->oid)) {
>                         old->ce_flags |= CE_UPDATE;
>                         discard_cache_entry(ce);
> diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
> index fc3eb43b89..74add853fd 100755
> --- a/t/t2022-checkout-paths.sh
> +++ b/t/t2022-checkout-paths.sh
> @@ -78,4 +78,15 @@ test_expect_success 'do not touch files that are already up-to-date' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'checkout HEAD adds deleted intent-to-add file back to index' '
> +       echo "nonempty" >nonempty &&
> +       >empty &&
> +       git add nonempty empty &&
> +       git commit -m "create files to be deleted" &&
> +       git rm --cached nonempty empty &&
> +       git add -N nonempty empty &&
> +       git checkout HEAD nonempty empty &&
> +       git diff --staged --exit-code
> +'
> +
>  test_done
> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> index 2650df1966..09b1543a5b 100755
> --- a/t/t2070-restore.sh
> +++ b/t/t2070-restore.sh
> @@ -95,4 +95,15 @@ test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
>         )
>  '
>
> +test_expect_success 'restore --staged adds deleted intent-to-add file back to index' '
> +       echo "nonempty" >nonempty &&
> +       >empty &&
> +       git add nonempty empty &&
> +       git commit -m "create files to be deleted" &&
> +       git rm --cached nonempty empty &&
> +       git add -N nonempty empty &&
> +       git restore --staged nonempty empty &&
> +       git diff --staged --exit-code
> +'
> +
>  test_done
> --
> 2.22.0
>
