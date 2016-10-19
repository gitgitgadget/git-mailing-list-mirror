Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9232720986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941136AbcJSUqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:46:02 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36239 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938911AbcJSUpz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:45:55 -0400
Received: by mail-qt0-f171.google.com with SMTP id m5so35049972qtb.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t0uvQNSKGAas8mUkT95b8Dd8H69nffDIuFT7HGTr7Jg=;
        b=MzWDuQnkARUOuDyNA8AHUEsCqFOaV1ur/2PUjJad1/1KXYvczGjYumqvCY/qecCGw3
         fWFA8uIaHzCiY+2f9gKVszdHgE6439tTsBY+StX+YQF4/kHqxxg0wJy8vF9CHH9+sfrz
         b1iDU/lcY0rGIQcwhphWlfLOeCohr0wkFyQBxn/RkQNcg3B3I7aanxxdGWztV4a8RJUX
         mt9qfRJTFAqTC6G2i1e9+jftVLpAv29SpGM9fFFL6tVGcykPWQdDBdV8KfSeLlGiR1QJ
         0ABQSgkHeeCoqrf1gBddAtZ+xvAnNgSrH6B8lkAJ7wkp+gUuLnXZ9y0j7vinm0WuXPB0
         FFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t0uvQNSKGAas8mUkT95b8Dd8H69nffDIuFT7HGTr7Jg=;
        b=PCb4UXQdDbyE1Fiz6gS+dStQQ/5kLtiIEQ/tpkLHvVcfZ1AA59NQHtkI6QEWExyOn/
         YoOHbs2McmvYMjGBSNlVWnsdiYOzhEhfRv1sEN7Wq1gWsI9qkySzdPpid6y2/tNIQ04Y
         dTYcH7LHI/kHy/Yo5TbPs8lNDCDL4rmk+NujPuy4QN8SlmZU5YkhzDF6vIuhEM+jssLc
         ZU0M3XxNLMPGTmD6WeZVVW3vztr8hHGGonRXbuXLPCAScsY/FPd/QIl2qay/MBokBgbn
         6irbdLDTYuWrx24Udek7Ca31OS/OLc67dh97xGINRnpFTrAJS3cOJx9bvNJZJtfs4PkQ
         HuPg==
X-Gm-Message-State: AA6/9Rmu2QIunIDCBE3vOF1Yns5WZbvLi+9Ecrnwo00My205p5h69MozJZd0SDRujTJtTaP3MnDHSqyVLUnW0WJX
X-Received: by 10.200.34.145 with SMTP id f17mr8371966qta.149.1476909953232;
 Wed, 19 Oct 2016 13:45:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 19 Oct 2016 13:45:52 -0700 (PDT)
In-Reply-To: <20161019204254.97659-1-bmwill@google.com>
References: <20161019204254.97659-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Oct 2016 13:45:52 -0700
Message-ID: <CAGZ79kZAgT2ac_D-xiYCWY-bJZYNx4r7zqbf2i0d4=vfmamw4A@mail.gmail.com>
Subject: Re: [PATCH] submodules: update documentaion for submodule branches
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 1:42 PM, Brandon Williams <bmwill@google.com> wrote:
> Update the documentaion for the the special value `.` to indicate that
> it signifies that the tracking branch in the submodule should be the
> same as the current branch in the superproject.

For reference of other reviewers:
See 4d7bc52b178bffe9e484c4dcd92d5353e2ce716f
as well as https://gerrit-review.googlesource.com/Documentation/user-submodules.html

Thanks,
Stefan

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/git-submodule.txt | 4 +++-
>  Documentation/gitmodules.txt    | 7 +++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bf3bb37..d841573 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -259,7 +259,9 @@ OPTIONS
>  --branch::
>         Branch of repository to add as submodule.
>         The name of the branch is recorded as `submodule.<name>.branch` in
> -       `.gitmodules` for `update --remote`.
> +       `.gitmodules` for `update --remote`.  A special value of `.` is used to
> +       indicate that the name of the branch in the submodule should be the
> +       same name as the current branch in the current repository.
>
>  -f::
>  --force::
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 10dcc08..8f7c50f 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -50,8 +50,11 @@ submodule.<name>.update::
>
>  submodule.<name>.branch::
>         A remote branch name for tracking updates in the upstream submodule.
> -       If the option is not specified, it defaults to 'master'.  See the
> -       `--remote` documentation in linkgit:git-submodule[1] for details.
> +       If the option is not specified, it defaults to 'master'.  A special
> +       value of `.` is used to indicate that the name of the branch in the
> +       submodule should be the same name as the current branch in the
> +       current repository.  See the `--remote` documentation in
> +       linkgit:git-submodule[1] for details.
>
>  submodule.<name>.fetchRecurseSubmodules::
>         This option can be used to control recursive fetching of this
> --
> 2.10.1
>
