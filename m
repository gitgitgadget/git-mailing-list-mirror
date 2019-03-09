Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D604C20248
	for <e@80x24.org>; Sat,  9 Mar 2019 19:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCIThp (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 14:37:45 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42289 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIThp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 14:37:45 -0500
Received: by mail-ua1-f67.google.com with SMTP id s26so302776uao.9
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 11:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q4nVmn43C/8Q+VLXI/4vIl9QL/kvhE9lTM1vugC0QPQ=;
        b=BdRdXvS9mjaI+2OTPw4fAhVG7ZudpQSNqdF3DyGUiONmJ63/56bShQv8H4vcxdhH77
         9jjloW6BBB3V1zPA5cs5cLNmOUlOdQwg8dqNoO0J36un2xU1w79/Z7bTioRDYJcWOqmf
         Tw0hcgOv0eVbUf3mJKCauQviRflcGFQads0CX0KKw+clhVep7spLoAP2rHYcAC1O/l9V
         jRYTh7zO0TkUN9P99IEgm1TUbOZvCgj3ulBWSBKTQe1y5C/kgXDMrdohsrGOtkVVrxPu
         zNIU1Ga51Y0AkOB7gNmqEq/9gxeNgh2mW4HhmUNfPjdC73HfvMiuS7fo5kDciZLRNuGN
         fdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q4nVmn43C/8Q+VLXI/4vIl9QL/kvhE9lTM1vugC0QPQ=;
        b=rNNm7rha+o+nWS/jSN1Hl0HDuxmn0+XfGZd9MeA16uLqFiSxab0K5bCvocgYbB/dlD
         hLA/9p/2WVXsGq6gH/Xhc99URx5MD+++satKJl0c8YSQS8xJWc5szhr5k8rv1N2K1tJ9
         OIo/nA236awZVBA/F9+0O4sI0B6P+omrb2QoWibsEKrT4h9W9U+iJjC8ScKqi8pDKE+f
         Eu6F2YDZfo2y11Vrmay+W8u7GFg17GP4RC+/QQoPz5fFX3Z/JdBkVSZVFOlLKZ5yNZfy
         zvex4kFyvUOViK5c1lpOKvDdZhqzcBhhfRrWrFl9eDfzVFbn7YWpUjkFHNN8ffPUQShv
         U2pQ==
X-Gm-Message-State: APjAAAXBuZJVwZKcI8fH4kVPZltQh27Aj6EGMhk15wxmZxL51C+DZQ3l
        TkgK8YT7h1pxFMDuAc9PalDpY0k+0yXup9Nru68=
X-Google-Smtp-Source: APXvYqwzo8UsVGEIYJzYiaWofFqNhN4f54nI7+ZFQJUlsvd4Z1Hqyz2Zww187sx/phV4oJ6/mrIMi38Co9Q04eEgbSY=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr12893990uao.20.1552160263697;
 Sat, 09 Mar 2019 11:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-12-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-12-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 11:37:32 -0800
Message-ID: <CABPp-BEVMc+k7fTtZqqAf=WdpFi3W-Tcjw+Ah57bcetOXVwxkQ@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] doc: promote "git restore"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> The new command "git restore" (together with "git switch") are added
> to avoid the confusion of one-command-do-all "git checkout" for new
> users. They are also helpful to avoid ambiguation context.

s/ambiguation/ambiguous/ or s/ambiguation context/ambiguity/?

> For these reasons, promote it everywhere possible. This includes
> documentation, suggestions/advice from other commands.
>
> One nice thing about git-restore is the ability to restore
> "everything", so it can be used in "git status" advice instead of both
> "git checkout" and "git reset".  The three commands suggested by "git
> status" are add, rm and restore.
>
> "git checkout" is also removed from "git help" (i.e. it's no longer
> considered a commonly used command)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---

> @@ -56,7 +56,7 @@ summary of what is included by any of the above for the=
 next
>  commit by giving the same set of parameters (options and paths).
>
>  If you make a commit and then find a mistake immediately after
> -that, you can recover from it with 'git reset'.
> +that, you can recover from it with 'git restore' or 'git reset'.

Does 'git revert' also belong in this set?  And do we need to extend
our blurb differentiating reset and restore to also include revert?

> @@ -26,8 +26,8 @@ effect of some earlier commits (often only a faulty one=
).  If you want to
>  throw away all uncommitted changes in your working directory, you
>  should see linkgit:git-reset[1], particularly the `--hard` option.  If
>  you want to extract specific files as they were in another commit, you
> -should see linkgit:git-checkout[1], specifically the `git checkout
> -<commit> -- <filename>` syntax.  Take care with these alternatives as
> +should see linkgit:git-restore[1], specifically the `--source`
> +option  Take care with these alternatives as
>  both will discard uncommitted changes in your working directory.

Missing period after "option".

>  -------------------------------------------------
> -$ git reset --hard HEAD
> +$ git merge --abort

Nice additional cleanup, but should it be in a separate patch since it
isn't about the restore command?


Elijah
