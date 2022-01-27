Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28DBC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 10:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiA0KzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiA0KzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 05:55:09 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BCC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 02:55:09 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id w133so5097970oie.7
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 02:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnZ/FlE6Ve5I8F60wxL/klxn2NUVuGSEVaqhnzd3+qQ=;
        b=LIioBhaRCO8bKZkPWZxdA1aZzFgnTCisUmwSyRbjpjiyGFg2IhMxuRkLSkMr7vjStt
         c8c+5OLI13oWuXlRyRw1yiw6hJ30HyC8OAQIryzyjq+G3trzwNqla84kZFCBoFAgohLD
         ukb7TUl0kALdpiierJv8pwrn8wuV1Oc8ldjCg3YJnPpu3vEeIlvULGhBrrEQd6XYVzx7
         Y0wuccOwzxA7r1zYF65v3zg3D3ddjjNeOhEgey6KqnFCZwk5x/hcIw305X85Ao502xXp
         jMdnO8iDRq5DPJrhQprV/Hr2XCPg56hbsQoZyM0afZGKTOhZr5v7VN/xjnxIHro+sqHy
         qv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnZ/FlE6Ve5I8F60wxL/klxn2NUVuGSEVaqhnzd3+qQ=;
        b=nUmkaDu1VNmMce641c0iecnj5ODE54uJl1ijWVfaUKere+A599CFTKMILNvdO5zuMw
         R3tbjIyRzKRxs0UzOIT71F/38L0lso25+gb/GRtPHWFUsot5HUQ+dxPXJAZlwW2C8Llu
         q5IuDYpsXtA9dBLRjXtJGdg/P4tNOiwBRR4nHrZzBevuHhsHBuHdaA7nF4Qj20omuPL6
         BTNy5K8O48KOGVqZBDIWN84jiCgqKho2kPIjpKMCjr/R+CjvkogglnavQn/GqCIPrSLA
         KVSGDNQTzMK77v+BJXQY5k7mOy/qlhSawBYd5w9hH1RfLJiXwfZG/UXdhGWKAB3w7/Yd
         QapQ==
X-Gm-Message-State: AOAM532pYvbQ3PUFgJJMogOQEvpfcaojtmPEdJVGycVKFb7w1BDvFRFb
        lrExo1naKvuM8JZY5LxEjkFvIZKM+28FyaUjpH1DsDi88GPuSukM
X-Google-Smtp-Source: ABdhPJzEmqKVKvOjiPtJ/Knm8DcSZcD5sBaSprhtR150kox3JguNXAY3oaWM5CBwRnRc9uIYXjyd024q3k7ITI7xGTQ=
X-Received: by 2002:aca:5e55:: with SMTP id s82mr6477956oib.109.1643280908961;
 Thu, 27 Jan 2022 02:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
In-Reply-To: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Thu, 27 Jan 2022 18:54:55 +0800
Message-ID: <CAJyCBOQvOZO9esuP4dZuRmSat8Ug+TJYkjBKqTznM1wq8e85xQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] lib-read-tree-m-3way: modernize a test script (style)
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure if this email is overlooked (I understand its content is
lackluster though).

I'm looking forward to participating in this year's GSoC :) And I will
be really appreciated if anyone could possibly reply to it (and my
self-intro).

--
Thanks,
Shaoxuan

On Sun, Jan 23, 2022 at 2:04 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>
> As a microproject, I found another small fix regarding styling to do.
>
> I changed the old style '\' (backslash) to new style "'" (single
> quotes).
>
> And I also fixed some double quotes misuse.
>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> Other than that, I forgot to introduce myself in the last patch and
> here it goes:
>
> I'm Shaoxuan Yuan, currently a sophomore majors in Computer Science and Engineering
> (CSE) @ University of California, Irvine.
>
> I have prior open-source experience in which I was [maintaining|contributing to] the
> Casbin community. My main language is Python, and I'm a C newbie
> because I'm quite interested in contributing to git (since it is in my main daily
> toolkit and it is a charm to wield :-) ).
>
> And for now I'm still taking baby steps trying to crack some test script
> styling issues. After getting more familiar with the git contribution
> process, I will try something bigger (though not THAT big) to get a
> firmer grasp of git.
>
>  t/lib-read-tree-m-3way.sh | 154 +++++++++++++++++++-------------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
>
> diff --git a/t/lib-read-tree-m-3way.sh b/t/lib-read-tree-m-3way.sh
> index 168329adbc..e40739b8db 100644
> --- a/t/lib-read-tree-m-3way.sh
> +++ b/t/lib-read-tree-m-3way.sh
> @@ -8,16 +8,16 @@ do
>          p=$a$b
>         echo This is $p from the original tree. >$p
>         echo This is Z/$p from the original tree. >Z/$p
> -       test_expect_success \
> -           "adding test file $p and Z/$p" \
> -           'git update-index --add $p &&
> -           git update-index --add Z/$p'
> +       test_expect_success 'adding test file $p and Z/$p' '
> +           git update-index --add $p &&
> +           git update-index --add Z/$p
> +    '
>      done
>  done
>  echo This is SS from the original tree. >SS
> -test_expect_success \
> -    'adding test file SS' \
> -    'git update-index --add SS'
> +test_expect_success 'adding test file SS' '
> +    git update-index --add SS
> +'
>  cat >TT <<\EOF
>  This is a trivial merge sample text.
>  Branch A is expected to upcase this word, here.
> @@ -30,12 +30,12 @@ At the very end, here comes another line, that is
>  the word, expected to be upcased by Branch B.
>  This concludes the trivial merge sample file.
>  EOF
> -test_expect_success \
> -    'adding test file TT' \
> -    'git update-index --add TT'
> -test_expect_success \
> -    'prepare initial tree' \
> -    'tree_O=$(git write-tree)'
> +test_expect_success 'adding test file TT' '
> +    git update-index --add TT
> +'
> +test_expect_success 'prepare initial tree' '
> +    tree_O=$(git write-tree)
> +'
>
>  ################################################################
>  # Branch A and B makes the changes according to the above matrix.
> @@ -45,48 +45,48 @@ test_expect_success \
>
>  to_remove=$(echo D? Z/D?)
>  rm -f $to_remove
> -test_expect_success \
> -    'change in branch A (removal)' \
> -    'git update-index --remove $to_remove'
> +test_expect_success 'change in branch A (removal)' '
> +    git update-index --remove $to_remove
> +'
>
>  for p in M? Z/M?
>  do
>      echo This is modified $p in the branch A. >$p
> -    test_expect_success \
> -       'change in branch A (modification)' \
> -        "git update-index $p"
> +    test_expect_success 'change in branch A (modification)' '
> +        git update-index $p
> +    '
>  done
>
>  for p in AN AA Z/AN Z/AA
>  do
>      echo This is added $p in the branch A. >$p
> -    test_expect_success \
> -       'change in branch A (addition)' \
> -       "git update-index --add $p"
> +    test_expect_success 'change in branch A (addition)' '
> +           git update-index --add $p
> +    '
>  done
>
>  echo This is SS from the modified tree. >SS
>  echo This is LL from the modified tree. >LL
> -test_expect_success \
> -    'change in branch A (addition)' \
> -    'git update-index --add LL &&
> -     git update-index SS'
> +test_expect_success 'change in branch A (addition)' '
> +    git update-index --add LL &&
> +    git update-index SS
> +'
>  mv TT TT-
>  sed -e '/Branch A/s/word/WORD/g' <TT- >TT
>  rm -f TT-
> -test_expect_success \
> -    'change in branch A (edit)' \
> -    'git update-index TT'
> +test_expect_success 'change in branch A (edit)' '
> +    git update-index TT
> +'
>
>  mkdir DF
>  echo Branch A makes a file at DF/DF, creating a directory DF. >DF/DF
> -test_expect_success \
> -    'change in branch A (change file to directory)' \
> -    'git update-index --add DF/DF'
> +test_expect_success 'change in branch A (change file to directory)' '
> +    git update-index --add DF/DF
> +'
>
> -test_expect_success \
> -    'recording branch A tree' \
> -    'tree_A=$(git write-tree)'
> +test_expect_success 'recording branch A tree' '
> +    tree_A=$(git write-tree)
> +'
>
>  ################################################################
>  # Branch B
> @@ -94,65 +94,65 @@ test_expect_success \
>
>  rm -rf [NDMASLT][NDMASLT] Z DF
>  mkdir Z
> -test_expect_success \
> -    'reading original tree and checking out' \
> -    'git read-tree $tree_O &&
> -     git checkout-index -a'
> +test_expect_success 'reading original tree and checking out' '
> +    git read-tree $tree_O &&
> +    git checkout-index -a
> +'
>
>  to_remove=$(echo ?D Z/?D)
>  rm -f $to_remove
> -test_expect_success \
> -    'change in branch B (removal)' \
> -    "git update-index --remove $to_remove"
> +test_expect_success 'change in branch B (removal)' '
> +    git update-index --remove $to_remove
> +'
>
>  for p in ?M Z/?M
>  do
>      echo This is modified $p in the branch B. >$p
> -    test_expect_success \
> -       'change in branch B (modification)' \
> -       "git update-index $p"
> +    test_expect_success 'change in branch B (modification)' '
> +           git update-index $p
> +    '
>  done
>
>  for p in NA AA Z/NA Z/AA
>  do
>      echo This is added $p in the branch B. >$p
> -    test_expect_success \
> -       'change in branch B (addition)' \
> -       "git update-index --add $p"
> +    test_expect_success 'change in branch B (addition)' '
> +           git update-index --add $p
> +    '
>  done
>  echo This is SS from the modified tree. >SS
>  echo This is LL from the modified tree. >LL
> -test_expect_success \
> -    'change in branch B (addition and modification)' \
> -    'git update-index --add LL &&
> -     git update-index SS'
> +test_expect_success 'change in branch B (addition and modification)' '
> +    git update-index --add LL &&
> +    git update-index SS
> +'
>  mv TT TT-
>  sed -e '/Branch B/s/word/WORD/g' <TT- >TT
>  rm -f TT-
> -test_expect_success \
> -    'change in branch B (modification)' \
> -    'git update-index TT'
> +test_expect_success 'change in branch B (modification)' '
> +    git update-index TT
> +'
>
>  echo Branch B makes a file at DF. >DF
> -test_expect_success \
> -    'change in branch B (addition of a file to conflict with directory)' \
> -    'git update-index --add DF'
> -
> -test_expect_success \
> -    'recording branch B tree' \
> -    'tree_B=$(git write-tree)'
> -
> -test_expect_success \
> -    'keep contents of 3 trees for easy access' \
> -    'rm -f .git/index &&
> -     git read-tree $tree_O &&
> -     mkdir .orig-O &&
> -     git checkout-index --prefix=.orig-O/ -f -q -a &&
> -     rm -f .git/index &&
> -     git read-tree $tree_A &&
> -     mkdir .orig-A &&
> -     git checkout-index --prefix=.orig-A/ -f -q -a &&
> -     rm -f .git/index &&
> -     git read-tree $tree_B &&
> -     mkdir .orig-B &&
> -     git checkout-index --prefix=.orig-B/ -f -q -a'
> +test_expect_success 'change in branch B (addition of a file to conflict with directory)' '
> +    git update-index --add DF
> +'
> +
> +test_expect_success 'recording branch B tree' '
> +    tree_B=$(git write-tree)
> +'
> +
> +test_expect_success 'keep contents of 3 trees for easy access' '
> +    rm -f .git/index &&
> +    git read-tree $tree_O &&
> +    mkdir .orig-O &&
> +    git checkout-index --prefix=.orig-O/ -f -q -a &&
> +    rm -f .git/index &&
> +    git read-tree $tree_A &&
> +    mkdir .orig-A &&
> +    git checkout-index --prefix=.orig-A/ -f -q -a &&
> +    rm -f .git/index &&
> +    git read-tree $tree_B &&
> +    mkdir .orig-B &&
> +    git checkout-index --prefix=.orig-B/ -f -q -a
> +'
> --
> 2.25.1
>
