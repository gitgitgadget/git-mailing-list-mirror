Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B72FC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 07:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjBVHYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 02:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBVHYa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 02:24:30 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666AB28D3D
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 23:24:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h16so26766241edz.10
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 23:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVW/JR3fs1oSiXouIGabfnWHAh40Csm18NVsOF04RHg=;
        b=KK8zAvKe2b9VwTHT1zScEbj20NzeR4nkubeZufZhIvSgNbskv47sXkFJAt04ZGQVuc
         VeN6c80R8nZUkhmLG06oEvwd5vq50MFsJSQm0P6oPaRvWKCt5CY8UeskkqROWAE6DMg2
         Tl3XK7WyWqwbDQTREVfcmhvPanEoPYAiGajA6N4+kBzpcfKP9RZmTJ0PVaGVKxClurIL
         V7RQL35+JErN9CfxuzkMvD5aLnuY0TLCnA/otudIWiDn+QUcT80gMl8t5uv97iBmhrbX
         hc5zbzfGHyUtuqY8KS6QAxmN7maQbSJNsD1SAzZ+c2HzbBDtg9yIalm0RpiCtXZkY0xg
         aRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MVW/JR3fs1oSiXouIGabfnWHAh40Csm18NVsOF04RHg=;
        b=GyPhGQTGMhzw2UqeSvbqXOp6hpikSCkvqWnScvnrBZvrusxCYn0i10QZ6JAGfZY3R1
         R6CuuwTqq/CbytFXQQ2QjOLCsKI4I/K2lK10EfCeEWWqWu/dvx2yYb6WTaoJ8eeZgatJ
         rNHT7yHuxmCdHhmZOa13NI3XrqUpeSbHCIgIFZ2usD1Udr0Plc8PxYXW2nw4j8o9zTzg
         GXwJdqiFbqHeDNH9TBlxMyfiER3Uc0Om/olQcvUpLJSrSmnu79Vbp3cGV7GVCzB4nj/f
         ONQ92/NnpEK/ywli/QGPfLzoq5ZkDe1A45Un8VPpv/zeHu9GcVsLypB3UNUh1s6/Xug1
         Nl+Q==
X-Gm-Message-State: AO0yUKUwe5EamauYHgGMZv63pCCeSapX8qIQYGGjaGnr+Hk6deQiTwcJ
        T4M7w8HnMdQRkE/dmEvHX428Jbe0VxGLM/qSuo5sFET49Yc=
X-Google-Smtp-Source: AK7set+hJNcHDISkhDrKinF+lyBaj3HZ+KJJS7xkahpJi8Z7Ek3dOXpFZZYCK/9aebYVo+ZUZ0C8PHnIVaNDOW7xwWw=
X-Received: by 2002:a17:906:ce59:b0:8b1:7de9:b39b with SMTP id
 se25-20020a170906ce5900b008b17de9b39bmr8704061ejb.1.1677050666854; Tue, 21
 Feb 2023 23:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20230222040745.1511205-1-18994118902@163.com> <20230222040745.1511205-3-18994118902@163.com>
In-Reply-To: <20230222040745.1511205-3-18994118902@163.com>
From:   Vivan Garg <v.garg.work@gmail.com>
Date:   Wed, 22 Feb 2023 00:24:15 -0700
Message-ID: <CADupsJPLF94EnMHYNO08dFV+DEooeB6+YB8bgkRJwBrFtBbOwQ@mail.gmail.com>
Subject: Re: [GSOC] [PATCH v1 2/2] Change indents to TAB
To:     Zhang Yi <18994118902@163.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You are missing the body of the commit message here as well, Please add one
in your next re-roll.

On Tue, Feb 21, 2023 at 10:01 PM Zhang Yi <18994118902@163.com> wrote:
>
> Signed-off-by: Zhang Yi <18994118902@163.com>
> ---
>  t/t9700-perl-git.sh | 58 ++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index 3f6396ef63..671875a3fc 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -14,35 +14,35 @@ skip_all_if_no_Test_More
>  # set up test repository
>
>  test_expect_success 'set up test repository' '
> -     echo "test file 1" > file1 &&
> -     echo "test file 2" > file2 &&
> -     mkdir directory1 &&
> -     echo "in directory1" >> directory1/file &&
> -     mkdir directory2 &&
> -     echo "in directory2" >> directory2/file &&
> -     git add . &&
> -     git commit -m "first commit" &&
> -
> -     echo "new file in subdir 2" > directory2/file2 &&
> -     git add . &&
> -     git commit -m "commit in directory2" &&
> -
> -     echo "changed file 1" > file1 &&
> -     git commit -a -m "second commit" &&
> -
> -     git config --add color.test.slot1 green &&
> -     git config --add test.string value &&
> -     git config --add test.dupstring value1 &&
> -     git config --add test.dupstring value2 &&
> -     git config --add test.booltrue true &&
> -     git config --add test.boolfalse no &&
> -     git config --add test.boolother other &&
> -     git config --add test.int 2k &&
> -     git config --add test.path "~/foo" &&
> -     git config --add test.pathexpanded "$HOME/foo" &&
> -     git config --add test.pathmulti foo &&
> -     git config --add test.pathmulti bar
> -     '
> +       echo "test file 1" > file1 &&
> +       echo "test file 2" > file2 &&
> +       mkdir directory1 &&
> +       echo "in directory1" >> directory1/file &&
> +       mkdir directory2 &&
> +       echo "in directory2" >> directory2/file &&
> +       git add . &&
> +       git commit -m "first commit" &&
> +
> +       echo "new file in subdir 2" > directory2/file2 &&
> +       git add . &&
> +       git commit -m "commit in directory2" &&
> +
> +       echo "changed file 1" > file1 &&
> +       git commit -a -m "second commit" &&
> +
> +       git config --add color.test.slot1 green &&
> +       git config --add test.string value &&
> +       git config --add test.dupstring value1 &&
> +       git config --add test.dupstring value2 &&
> +       git config --add test.booltrue true &&
> +       git config --add test.boolfalse no &&
> +       git config --add test.boolother other &&
> +       git config --add test.int 2k &&
> +       git config --add test.path "~/foo" &&
> +       git config --add test.pathexpanded "$HOME/foo" &&
> +       git config --add test.pathmulti foo &&
> +       git config --add test.pathmulti bar
> +'
>
>  test_expect_success 'set up bare repository' '
>         git init --bare bare.git
> --

There should be no whitespace after redirect operators; as described in the last
commit of this patch. Make sure to fix that in your next re-roll for
this test script
as well. You might also want to look at this for a summary of all the
things you
need to do:
https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/

> 2.29.0-rc0
>

Thanks!
