Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E33C1F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 07:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeCYHKf (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 03:10:35 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39856 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeCYHKe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 03:10:34 -0400
Received: by mail-wm0-f50.google.com with SMTP id f125so10020628wme.4
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tau41YTx6IppQuLRj31OX5/LvtBIHADdifZqzUeItVI=;
        b=TA6hTVqbMrudW/Jaw3Ghz1cTgtvDhetPvlZrX4BzWw9+KallWbTGcp8cAzZXI5/yXi
         nm89ZYMjlQ/LYLGBWaSGPhc3p0m+gJdbPGjRcAdhjxcrtA5gRWRGj+3QT+eIGEZIEO9I
         pNhLc57u0JiVZ8agYMcGa1IXcpBj9T8555L2GqFJIt9RQ7VdXAabX8BKkOyXZSXzsBRy
         Xnregd6dKH5YUbEpkxKf+JxJW+ys12vEKIfgSPSmB4fdG/0fs/wSsfmHIjMxv5u0jhTL
         XgHOXzlDdBhMcOphDjL3lUGlefqSrlgQQSIqB3v22unytgn35KdjuMUy9vTAIzOVFHIM
         7dRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tau41YTx6IppQuLRj31OX5/LvtBIHADdifZqzUeItVI=;
        b=ZSOGTmSFkmJSoTpume+Assg8PPsKUUqRxC7tGIj6lAyYpUun9CSNf49xU5KJMZMhC6
         beoYOZJVS1KFAgVNQ5Z67VQrwyCsMh6dE7JNbGA3R4OsFbOdHd7CxgCallJRWAzPAG3Q
         h405b1QHAi5hKV9/bmCTMkqkW5DJOiQqeGFDI1fd2wyDBq9fRo6O9qkZnoa1lKeYJ2RR
         xk/i+7PX3EGMTl5QRxrpV1X0WOaAAz/P46muohPuGBTQebRxusw1g4/Cb6L2IWOOgDRb
         NE+e64p6rpvb+QHUpI98mOMGxxdurLyiwsZcZUJWC5Y4O+ELwcSh77+M+wgZf4NhvUnW
         tqGw==
X-Gm-Message-State: AElRT7EyAeAS9828EXqrzGI1qzyU/lHvA/kCw343ps0zd2Ynf1BFHCQG
        FPvC3SOu4TrBJ2BATg1C8otQk+GBuO1nv+CZl54XK8rq
X-Google-Smtp-Source: AG47ELv36oN1lrQx7RDedzjRBipc7hEZs3jvgJWnQ8EdjiZUVXNRkn1AojDsE/ADIN9jRcwicI1i+wR906epP004uQM=
X-Received: by 10.80.149.68 with SMTP id v4mr35956567eda.236.1521961833534;
 Sun, 25 Mar 2018 00:10:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.203.135 with HTTP; Sun, 25 Mar 2018 00:10:13 -0700 (PDT)
In-Reply-To: <CAA7Y+T3OdaSBcqPmfJcVbPTjY=VFnvx9PH-rW9utQ4mXce+S8w@mail.gmail.com>
References: <CAA7Y+T3OdaSBcqPmfJcVbPTjY=VFnvx9PH-rW9utQ4mXce+S8w@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 25 Mar 2018 00:10:13 -0700
Message-ID: <CA+P7+xp5dJUZVgFn6gK64dOMM1_3vmEJwOWb1TVZKLL7vb8JGQ@mail.gmail.com>
Subject: Re: query on git submodule (ignore)
To:     prashant Nidgunde <pashnidgunde@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 7:17 PM, prashant Nidgunde
<pashnidgunde@gmail.com> wrote:
> Hello,
>
> I am new to this community ,so please ignore if I am asking anything silly.
>
> Case :
> Today when I built my submodule , and did a git status , it shows as modified.
>
> After reading certain suggestions on web i found out that i can ignore
> that adding a line in .gitmodules
>
> But, I had to add that line manually ( which could be errorprone
> because of typos )
>
>
> Question:
>     1. Is it feasible to build a feature like :
>                    git submodule "zlib" ignore dirty ( which will
> ignore submodule zlib when its built and dirty  as it has new files in
> its directory)
>
> If this feature is feasible , how do i know if its developed  (
> awaiting merge ) or can I build the patch ?
>

I don't recall such a feature, but I'm sure patches to implement
something would be welcome to be reviewed! (For more information about
submitting patches you could read
https://github.com/git/git/blob/master/Documentation/SubmittingPatches)

I think having an option to automatically write this would be useful.
It may already be possible to do something similar via the git config
command with the -f file argument to edit the .gitmodules file (as it
uses the gitconfig format for its contents). However, this is
definitely not intuitive.

You can read the documentation for the commands using "git help
submodule" and "git help config". Patches are also definitely welcome
for updates to the documentation if it's not clear.


I know also that having a simpler interface to set submodules up so
that they are treated as unchanged would be useful as I have projects
at $dayjob which use submodules, and this is often a complaint against
their use by my co-workers (who sometimes then accidentally commit
re-wind updates to the submodules due to inattentiveness with use of
git add . or git commit -a).

Thanks,
Jake
