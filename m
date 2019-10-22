Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D85D1F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfJVNme (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 09:42:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37556 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfJVNme (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 09:42:34 -0400
Received: by mail-io1-f67.google.com with SMTP id 1so9104344iou.4
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VTv5hqTpwI49Qas5OAabVxiHJYcAt3ucOrNGGqjdBpk=;
        b=M6f/ZfII+VEg4FWov5VvT2TuROHYSd9xr37/bezHlsU+8pYnGQ3EzLRtgwVo8wKxM/
         wNDV9ZxWOX8yckH+G4gBGErF5getoYcraucD6sjxyQCTH2PHn1nR9Oj8byunNFVEZwzu
         Y+NLBJQKquiSrSCuySU2VRKXiqH9MWLoz3eE1Lu69zpKDQtIruag0k7bIjz3yesG5IUw
         0d/vdaO7jX9u7Use/KitXld+EWE+EW/ZmswJpW432FbG5cD5J4pwkpzwiGetlV44SDPS
         dsaEGp8LJN+dft6jJTfMiuqLzDQn+E94gJMQ6tuzlnUhZhbDcn9I/psLfsQBPzddIDcL
         hCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VTv5hqTpwI49Qas5OAabVxiHJYcAt3ucOrNGGqjdBpk=;
        b=d6Fh7/rXdwSpzt4bRhm1y0MeEAJWGTYGmr0zTnHrMicrf7fbbUec/Tmuutfh2n7Fgn
         HZa2mkk9VUSmdt2JyVkcPlF3/ChbDwllH/Bb2YrHpRhBA08EYLzQTeMr1Y4TphnjOfHZ
         t8qLDp8BrpZGC2hlpKvV5n5VKEQyXqzTnwDvD525/tAdx1fIgqdxMiR/sSEU4BUNKuHS
         Bqz+/aS/pPJAbnMQWQWZLomLDLLdWMXnG6o59l6P2uMnYP1dfzz6+nXGLvD9DLfnCjBV
         9AG7X5qIhXRtxIHKr5MT7i+wEaTcttuwDjU7nqdUWkwefHSwKrCOL2HvbS1Jty5bt1xz
         Em4w==
X-Gm-Message-State: APjAAAXSmOSHfwxNLbodLR+DxaVgLSrHrrrFrPYyFfrD0hyT7V10H1eN
        13VljxTmiowM+CTt296GisOe+xi6EkfJ2yFs0Y7yCg==
X-Google-Smtp-Source: APXvYqz2hZ1+woHjldnxzrT38htbhJGVZET5EwvYhJgus3e3V6wlAQLHmwfCAv0DKLE5yFsry6wNJQMQO5RurW6AudQ=
X-Received: by 2002:a5d:8344:: with SMTP id q4mr3390082ior.99.1571751753369;
 Tue, 22 Oct 2019 06:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7CjDCacSKzN8fXgUe4ejNqM+AAe1o7NaDaFgM5WcYYV0bQ9g@mail.gmail.com>
 <20191021183519.GA139951@google.com>
In-Reply-To: <20191021183519.GA139951@google.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 22 Oct 2019 15:42:22 +0200
Message-ID: <CAN7CjDBZTBQKbDB=rCojEzqvwKZf8pfGq4ZwEmRV43FVWS8e=g@mail.gmail.com>
Subject: Re: [Outreachy] First contribution
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El lun., 21 oct. 2019 a las 20:35, Emily Shaffer
(<emilyshaffer@google.com>) escribi=C3=B3:
>
> On Mon, Oct 21, 2019 at 12:39:16PM +0200, Miriam R. wrote:
> > Dear Git developers,
> > I=E2=80=99m an Outreachy applicant, I would like to make my contributio=
n to
> > apply to this Outreachy internship period.
>
> Welcome, Miriam! Good to hear from you.
>
> >
> > I have found this issue tagged as open and goodfirstissue:
> > https://github.com/gitgitgadget/git/issues/230
> >
> > But there is a PR from 4 months ago:
> > https://github.com/gitgitgadget/git/pull/271  and I don't know how to
> > find out if a patch including that change already exists or if it
> > makes sense to do it.
>
> GitGitGadget exists to repackage PRs (which Git project doesn't use)
> into emailed patches (which Git project does use) when the author writes
> /submit on the PR comment chain. In that PR I see Johannes asking for a
> /submit, but no submit; next I would check if a patch with the same
> title came through in the mailing list by searching on the
> public-inbox.org mirror:
>
> https://public-inbox.org/git/?q=3Dis_directory+dir_exists
>
> Looks like, no, a patch with those hotwords wasn't mailed. Finally, I
> would check the project to see if it's still an issue:
>
>   $ cd my-git-dir/
>   $ git grep is_directory
>
> I still see 30 instances of is_directory in the codebase, so looks like
> we haven't made this change. :)
>

Thank you Emily!! Then I'll do this issue #230 :)

> >
> > In case this issue is not suitable for my first contribution,  I have
> > also found this:
> > https://github.com/gitgitgadget/git/issues/379
>
> This is also a fine change if you want to make it.
>
> Good luck, and remember it's fine to ask the mentor for the project you
> ultimately want to help on for help, code review in advance, etc.

Thank you for the advice!, I'm already in touch with Christian Couder.

Best,
Miriam

>
>  - Emily
