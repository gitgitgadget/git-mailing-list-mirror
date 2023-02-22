Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2640C64EC4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 07:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBVHNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 02:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVHNc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 02:13:32 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7DCDE2
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 23:13:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b12so26473516edd.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 23:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ux+lOstEFz+jfCU/VzL6Yvkebi0Ovd9u/qJKYE4803k=;
        b=fhnCyuQa8avOP/yfvvBlzAuizhGBJhIiO+91UvCgIC/FStdWs18y/NxD/zu32xAJ9K
         SZC8sQG1ZWphwsqHXyc8SX2hlFjHXwdf1EQJyqZ5XI/Ce3O1L3aF8nYF8HfHMmhgVivi
         Ra68FamvBmRn41pBwZs31OlTwFmAhtzClQntnhozzxBfr14sB43xW6jVsZSHMA7exJtW
         zwOgNsJg5OJrfQQX+evVSqjPM6CDz4IUdtCn4wdr2BgbQYiXomKYKbbc8rdlVXJCuUhT
         /AmTGo8H969RP3G8lsrSezIXGhBWaqsZZQGmQT7eOeZVVkm3jrwc2XwOzVTNkWquusME
         7Axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ux+lOstEFz+jfCU/VzL6Yvkebi0Ovd9u/qJKYE4803k=;
        b=tcLvejf4M1p8FNuuX9KLAVhF3zr5ueOObOECav0zaByk053vzKo+/lUtPv/N/jsE+q
         QU3vuYBFVMVa7D0H6V771WTeNtLOOQDfmjivKmndbvXeOZANVKZMUUCxbMTmViqmjMtC
         GMClZ0PK9VgMIKgUhkVmIVk7qa9KqdPapDB58OStY2R3y50WcL2kGWZmHvdb3rewt+rO
         +zjmCtddbeERb8ll+vx2JQotpL6xBPa/DxCFGFFI21VMbF+qVge1d2V2hsoOKlu3sWn6
         EhJFrh9VTif1gYNfbJGCruk7eCmtHMzvDsrBpKwoWxzNYctw4NaHMVKyN4tEu8GFtMVa
         mQiw==
X-Gm-Message-State: AO0yUKWklMXnXei52lXiGZ7MTfGNPrd3h6P7+R4NkOs+pXQ47IVUcOR0
        dxkL+o8iXrbOEYNzRPaBNMRCyofJEL7OFFJXhRo=
X-Google-Smtp-Source: AK7set99qxSSr5QrcpB1Ma5NkmQNWQRDOLYUMR0OR9zxrC1Hvn4iNAUQefILlxrufqnMbDL1Bf4PF2TpT4bCoTgRJLc=
X-Received: by 2002:a17:907:a04b:b0:8af:3e28:acc with SMTP id
 gz11-20020a170907a04b00b008af3e280accmr6873389ejc.1.1677050009569; Tue, 21
 Feb 2023 23:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20230222040745.1511205-1-18994118902@163.com> <20230222040745.1511205-2-18994118902@163.com>
In-Reply-To: <20230222040745.1511205-2-18994118902@163.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Wed, 22 Feb 2023 00:13:18 -0700
Message-ID: <CADupsJMW8fRDvhknxFgnSRQ4O7+YDHkKsEBoFq-yhO2vCq5MBg@mail.gmail.com>
Subject: Re: [GSOC] [PATCH v1 1/2] Fix title style
To:     Zhang Yi <18994118902@163.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You are missing the body of the commit message. Commit message
should start with description of the existing problem in present tense,
something like:

     Test scripts in file t9700-perl-git.sh are written in old style,
     where the test_expect_success command and test title are written on
     separate lines ...

Then changes should be described using imperative mood, as if you are
giving commands to the codebase.  See section "[[describe-changes]]"
in "Documentation/SubmittingPatches" for details.

> Signed-off-by: Zhang Yi <18994118902@163.com>
> ---
>  t/t9700-perl-git.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index b105d6d9d5..3f6396ef63 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -13,9 +13,8 @@ skip_all_if_no_Test_More
>
>  # set up test repository
>
> -test_expect_success \
> -    'set up test repository' \
> -    'echo "test file 1" > file1 &&
> +test_expect_success 'set up test repository' '
> +     echo "test file 1" > file1 &&
>       echo "test file 2" > file2 &&
>       mkdir directory1 &&
>       echo "in directory1" >> directory1/file &&
> --

there should be no whitespace after redirect operators, so:

    echo "test file 1" > file1 &&

  should become:

    echo "test file 1" >file1 &&

Similar changes for the rest of the test script as well.

> 2.29.0-rc0
>
