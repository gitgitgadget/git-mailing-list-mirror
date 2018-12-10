Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AC1720A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeLJSv5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:51:57 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:37104 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeLJSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:51:56 -0500
Received: by mail-it1-f175.google.com with SMTP id b5so19925955iti.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sUgZw2gtbMr+Og3F/UKL5sPoIK5FspoSTfcLEE/1Lqw=;
        b=Bvbrmp7/5inToIm9298iLn9GRsD5cUSKNMyB0wicS0fsN95cjldjlEFSr7xQeJL7RY
         +lc/+ZkullMDia9ubkYUrV8kw1YHo2lM4UjYPHVGmA+MbBnlGzKNEevcs/A0cjBOLQDq
         h9F36b61/KBZzNC5w7DKRGiSEm4odTzg00pV8yVZrqtUiDXbevDs4u51wGZKZCyq9Rfj
         FaeLSFonnV4b05MipfXTg9VKM2EF9DL8lczkgEduCsow7lufzz3qzc9A8fqCv2nZDLK8
         MyHIPnUsQZK3AiQz0yBrB0uWTkH2juefid87wJKuIAfBW+JNTDOtnIpB0Uuq2F8yQRTn
         uHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sUgZw2gtbMr+Og3F/UKL5sPoIK5FspoSTfcLEE/1Lqw=;
        b=GMZpmAfDOywi5+RV9mnqHXjj6LwrwVV6ZRYS1dv0PhLtoF7EaD91kRrgOjVb6qpeJ7
         atT4We2fORrxYD5+RaxuqKPRgq4SWgeScMAwjW2WjNNSlqiEPxf8lBglmJskNSm+A8zE
         2W2T4/TcfvfvvhGGkoN1W54EzcRhwjd/ri6ZnoPvBYRBv45uU9rxA9ExVCJPuHkeuFfr
         uD8nmbVnzgGB1Ym/BdX3fF46oezO+H8NKDHN1NkcB8+XGN1fn9U+G+V+ovhiA2ZwzkqL
         qRDvQx4iz2nWTO0nq+Z7+wYF1IdUTeJAG9XFziPF+u/ZD0nLGKtpb61NpKY+eSkmr1U3
         Hj8g==
X-Gm-Message-State: AA+aEWbthd2tS4OyY8Ixcv7S28BIuqku3v4fJVQC/ke+XUdbpC2Wzq4O
        imleFSN9Tc5upm5R1SemsFJWurPAevaGLCRINCfQKA==
X-Google-Smtp-Source: AFSGD/WFmRyyszSF1Uu5TnzDWPF5OD+K761UjsaEgLPmTf8/AToCfz93RvJTMctLgdFABcHAMzIHK9xl+wg4IhS0Zog=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr11930680jak.30.1544467915659;
 Mon, 10 Dec 2018 10:51:55 -0800 (PST)
MIME-Version: 1.0
References: <20181209102521.5301-1-pclouds@gmail.com> <CAGZ79kZpcgRFs=2NgaYHUAfRQ16u-LG7CjEJJg4+=oxUQ6Bbnw@mail.gmail.com>
In-Reply-To: <CAGZ79kZpcgRFs=2NgaYHUAfRQ16u-LG7CjEJJg4+=oxUQ6Bbnw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 19:51:29 +0100
Message-ID: <CACsJy8B=C05jc512yTRBy6s6BPu0kvfCo2mgoD7O-N29adMnKg@mail.gmail.com>
Subject: Re: [PATCH] style: the opening '{' of a function is in a separate line
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 7:47 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Sun, Dec 9, 2018 at 2:25 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> >  bisect.c                   | 3 ++-
> >  builtin/config.c           | 3 ++-
> >  builtin/push.c             | 4 +++-
> >  convert.c                  | 3 ++-
> >  credential-cache--daemon.c | 3 ++-
> >  diff.c                     | 6 ++++--
> >  git.c                      | 3 ++-
> >  imap-send.c                | 3 ++-
> >  remote-curl.c              | 3 ++-
> >  sequencer.c                | 6 ++++--
> >  string-list.c              | 3 ++-
> >  t/helper/test-sigchain.c   | 3 ++-
> >  transport-helper.c         | 3 ++-
> >  url.c                      | 3 ++-
> >  userdiff.c                 | 3 ++-
> >  15 files changed, 35 insertions(+), 17 deletions(-)
>
> Can you say more about how you found these?

I was updating diff.c (65 patches coming soon!) and found one function
that triggered me. "git grep '^static.*) {$'" caught most of them. A
bit more regex got some more but I don't even know if I have caught
them all.

> (Are these all of them, or did you look through some subset of files?)

I left compat and xdiff directories out if I remember correctly.

> Or did you use a formatting tool?

Unfortunately no. Perhaps clang-format can do it? I didn't try.
--=20
Duy
