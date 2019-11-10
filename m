Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53BE91F454
	for <e@80x24.org>; Sun, 10 Nov 2019 01:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfKJBkw (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 20:40:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41054 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfKJBkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 20:40:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id a21so9176208edj.8
        for <git@vger.kernel.org>; Sat, 09 Nov 2019 17:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xsT5tywz/yioUPHXgYRWseFY6GBJYBiO1ys1NOJlrQE=;
        b=gYtugZXG7q2RY8+Vd54wulrwEf3AE4Q5w0mg8mziwU3yYf+ctccvyHZe6QmQxoqQVR
         nNmz9aW1bQUexGWqE+DAS0sBNd/JXm5jLSdbxfM0oKlfzzG48p+i0Enf5E1k6/9IYlhw
         y10dM3Mc7Fmdx52Eln9uMbURD/miNMWsVAAm/aD/pcPM7LcnXTgkL8dU/9Z2rl0fMhXi
         slN7p1FfOiE7JBV9Nhr4W1gHMXhb/w0DRWki8da/jR5N5qPcWutgenlc20IqAVF+mYaT
         YxI9J/KAJ5dQQQ5BN+s8APuZgLro5DTfAmlaQlK9nmmAO/XPhdO678J/YgAWjToCd5cT
         5uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xsT5tywz/yioUPHXgYRWseFY6GBJYBiO1ys1NOJlrQE=;
        b=NspxcwyEiLpyEeSLO6uJ/fBpZu7977B+I/Ue33yUK9BJVN25UVayqXzzOviD98RSoA
         WuM0hrtQb1y8ziCh+Q3typn71XDYYmaTUVlSruruyYspniKlgRuwHNa9L/tm/+gdPFhz
         plxmHzsJWa9bV644eXAD0DJPWzInkmjehqygbKnw6E1vs+eAC7XkOLU3Xe5JDormEW64
         RcdxEDFWQF+XgJMJKZIJfdD94b147+JEQC3KEINK0QVQJCeZDypTNy9WUkhvmV8qpCfu
         n591ZQvxFug6hw8VMDDOFBiV5BmwP371pfruHmZVeuzfsstvMBkAmomTvyUIlGnke246
         qf3A==
X-Gm-Message-State: APjAAAWDgtdtPfiowxlJIHK1tBGDGb5hsjl4lhqOPw0HEntLdTm6qEtC
        0q5G9pAeWv+1R624q2wN2R/wAoW+fEWjo9o3/6M=
X-Google-Smtp-Source: APXvYqwb7aNYH1gw65SDMq+hQbSGzUz5FnE8pOEV9cSerHrHaw2FtyPgfesECBmsuoHB+fticaQgX50tA5wQYegI1Ks=
X-Received: by 2002:a17:906:5e05:: with SMTP id n5mr15928060eju.116.1573350050859;
 Sat, 09 Nov 2019 17:40:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com> <dcb78b6708937c3c6af5a86c276918c19e46acd4.1573034387.git.gitgitgadget@gmail.com>
 <20191107012633.GG229589@google.com>
In-Reply-To: <20191107012633.GG229589@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sun, 10 Nov 2019 14:40:39 +1300
Message-ID: <CACg5j25iBo4djYVrUBRiTK3sL82ax=33PDw6bWPNkFfL59GBag@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] pathspec: move doc to pathspec.h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 7, 2019 at 2:26 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Nov 06, 2019 at 09:59:37AM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Move the documentation from Documentation/technical/api-setup.txt
> > to pathspec.h as it's easier for the developers to find the usage
> > information beside the code instead of looking for it in another doc file.
> >
> > Also documentation/technical/api-setup.txt is removed because the
> > information it has is now redundant and it'll be hard to keep it up to
> > date and synchronized with the documentation in the header file.
> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  Documentation/technical/api-setup.txt | 47 ---------------------------
> >  pathspec.h                            | 34 ++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/technical/api-setup.txt
> >
> > diff --git a/Documentation/technical/api-setup.txt b/Documentation/technical/api-setup.txt
> > deleted file mode 100644
> > index eb1fa9853e..0000000000
> > --- a/Documentation/technical/api-setup.txt
> > +++ /dev/null
> > @@ -1,47 +0,0 @@
> > -setup API
> > -=========
> > -
> > -Talk about
> > -
> > -* setup_git_directory()
> > -* setup_git_directory_gently()
> > -* is_inside_git_dir()
> > -* is_inside_work_tree()
> > -* setup_work_tree()
> > -
> > -(Dscho)
> > -
> > -Pathspec
> > ---------
> > -
> > -See glossary-context.txt for the syntax of pathspec. In memory, a
> I kind of miss this pointer after the change. But, maybe other folks in
> the project prefer to let someone grep for this themselves.

You're Emily, I'll add it.

>
> Otherwise it looks fine to me. Thanks.
>
>  - Emily

Thanks a lot
