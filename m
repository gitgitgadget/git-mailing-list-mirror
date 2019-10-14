Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B151F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 02:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfJNCzV (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 22:55:21 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40733 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbfJNCzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 22:55:21 -0400
Received: by mail-qt1-f182.google.com with SMTP id m61so23395130qte.7
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JqG8FztTwkR3wttfYb0m0bzhvxDjdmYPIQHTIB3O6us=;
        b=p2c3Lc8ljMQlKJvjAdYj4FmrgjzRpyi1zszOtNz7LGkkXgP4b6ZzUO68vsWgEa7xTu
         +rChH1MLpy+I5AGL8dmPVJsc0jmTdXwg2p9deT5Re0c+i8M9lIsJ/vYFA03o1mYWQ3v7
         dZVAtVF9Is5jQVyFoL5FgjhWw3Lc9Dsf39mXJHcBqKAfF6pMUB/nEgXrVrhI8/l0cxEH
         pLBOsazWU2ocsfZdc0idunISfoyEMQEz6Zm4sz+2dHTbKsZfze2uT9eIoilh4vUm45zQ
         4WSKZJRk0o/OJ4cU0NjWor/GEC+YqGXWXgOU2l7V0XRI98FhrBs4FDzjEUJtISJn/O30
         M7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JqG8FztTwkR3wttfYb0m0bzhvxDjdmYPIQHTIB3O6us=;
        b=r9bHXhBfPITIljteQCZ1YL6aixjuBzHNbphjlAaZ0R5pqR8fsZ+EVkMsYASHwKlEh2
         n83bKuUGyDJpy1JIiusFHYf31J+YaLXxw2LmXCDZg626VQX77DFKlfHJ1PiAvIHOEeWk
         wAcJvllLiwuwfDpzyn1IOXbiYMXoMF6JHXLyUBZ1ZAsKhK6HU+A2Xu7mQ/EZOiR3qm20
         mv8lZoGocuDGJb4zXEMLmKYJhWtz0ws8ijQvVJb/h6KawOQ7IFXS+VPYqGdsvHipSMLA
         hd56IfTBFEPGk51BX8Azoi5AziLBp97rLJq0NSz7pGFlrSQjoCLRbrTfKNA5lEjJ9HVG
         8eTA==
X-Gm-Message-State: APjAAAWFjYKVt+U2xHEAM0cMm9tNH0oRD0c7zW7Mdxz05Jlh68yRFsYq
        ia0+vO01HBnnPFY3YYI5/Lk542iPip7dXJ3eCGg=
X-Google-Smtp-Source: APXvYqz7ahi8fqOCjEt8089TJKujlPjmr02Ob6+cgaP9qpoQZzC/Sk3Q7b4tE9FKcoelxawJx036xR8qUqxCwIqhN7c=
X-Received: by 2002:ad4:5847:: with SMTP id de7mr2468276qvb.168.1571021719002;
 Sun, 13 Oct 2019 19:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <f5eba6e8-b51a-d1a0-0d8f-0aed76d803c9@naver.com>
In-Reply-To: <f5eba6e8-b51a-d1a0-0d8f-0aed76d803c9@naver.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 14 Oct 2019 10:55:07 +0800
Message-ID: <CANYiYbF3T=1e-ro5mOBWYjhvRWyr8--mZCa8JQMoPB52w505vQ@mail.gmail.com>
Subject: Re: Is GIT GUI still in progress?
To:     =?UTF-8?B?6rmA6rG07Jqw?= <rlarjsdn122@naver.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=EA=B9=80=EA=B1=B4=EC=9A=B0 <rlarjsdn122@naver.com> =E4=BA=8E2019=E5=B9=B41=
0=E6=9C=8810=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8812:02=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Hello.
>
> I have a question whether the GIT GUI project still in progress or not
> because I want to contribute to translating GIT GUI into Korean. I asked
> prati0100 who is a maintainer of GIT GUI on
> Github(https://github.com/prati0100/git-gui), but he doesn't know the
> project is on.
> If the project is in progress, please reply this E-mail with how to
> contribute the GIT GUI for translation.
>
> Thank you.
>
> --
> Signed-off-by: Kim Geonwoo (=EA=B9=80=EA=B1=B4=EC=9A=B0)<rlarjsdn122@nave=
r.com>
>

Git GUI is a stand-alone project which is periodically merged to Git
project by a subtree merge. According to the latest
SubmittingPatches[1] documentation, git-gui is managed by Pratyush
Yadav in a separate project[2].

As a separate  project, the git-l10n project will merge l10n
contributions into itself and then merge them to Git as a whole
through a subtree merge. As what README.md[3] of git-gui says,
contributing to git-gui should using mailing list. This means l10n
contributors for git-guil, have to use git-format-patch and git
send-email commands to send patches to the mailing list, which is
inconvenience for git-gui l10n contributors. I suppose using a
dedicate git-guil l10n coordinator repository or simply using pull
requests of "prati0100/git-gui" as the l10n contribution workflow,
@Yadav.

[1] https://github.com/git/git/blob/master/Documentation/SubmittingPatches#=
L375
[2] https://github.com/prati0100/git-gui
[3] https://github.com/prati0100/git-gui/blob/master/README.md
