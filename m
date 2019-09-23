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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9648D1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 14:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437717AbfIWOXj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 10:23:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39683 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437634AbfIWOXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 10:23:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id a15so10353480edt.6
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPjpxUuDwj2tybbJAcoOVzZzaqUu6h+xx2IMhYGGI3s=;
        b=oqIQZMBCbmUfgeUNOdFJwAWPnlzJyByRIQ+AGJ93UOH2sMaqarYojgUMcnPooYDaxn
         16iFRhdcSloUeF6RWW3zlTiW/2zHrPfeUtiCy11DPdMlFWDw6pEP5PxmSXkTPbtSOs/o
         u7XBZI4fYbe3p5etxyQnhNqY6N6EzxoUcHAnfY/d6vV7p5EwIUyqYVObhWyCzBoXXrMP
         eeC9qCxu7VGQ6YSJxSIrzqWc7PIHkQ038Z1adUgiHrkPox5VklniFnaySRXljdLFYV7n
         KnTlJtf4cBE5NfCpFzDxVe+7uwX3nuoSZ1lOzQV42ptmXNiaUMtysYZ7CJSaOQMncQ3y
         +YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPjpxUuDwj2tybbJAcoOVzZzaqUu6h+xx2IMhYGGI3s=;
        b=Ha0i2Riv7itVQvcsaQ5k7oQrsdjNqx22t71MjiqEK1nPc9LccLs3fGAILxNbCjNYKQ
         E5VEJHkOqAMf27eNIaNLB1YXyeRfAtHpJSLz7LSCV6cviTuBEvG9warOV00sADxHrFSi
         ZNihbDiVEvEGmx5A2kWXHcGVcw1O2xM3x7WC76WpSNXuv/euPMgd7yZZOZCiB7EzHghl
         cjQKgktlUPzYGiTQ4ZfNOPsUYBfdvhYJCzxoEfMQyM2llZP3eVeNxrC6BJ4/0DuaIqas
         atT/uXv8kDjxI/qUVoQ4MTPQULf/vljCoG/nvTDOJP1DOWVpNo3dJOfe2Yye/NHxXIuS
         V8iA==
X-Gm-Message-State: APjAAAV41WidVlWftqnekodnNkbqhYNdktlvEuIgPoYVdaxKnNGfsnXU
        qAtqD/fUUok54GljEIfRlJwZxY5MQx1tjVHWJlA=
X-Google-Smtp-Source: APXvYqwoQrYYUZO8eTJe58dhPogHdnVWxGW0cqmLWNpOlNTnua+YVoi/CAqmOWQaJxwXlaVENSln2mQfwa3GxkD58Oo=
X-Received: by 2002:a17:906:1c06:: with SMTP id k6mr118798ejg.217.1569248617821;
 Mon, 23 Sep 2019 07:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190913205148.GA8799@sigill.intra.peff.net> <20190920170448.226942-1-jonathantanmy@google.com>
 <20190921014701.GA191795@google.com>
In-Reply-To: <20190921014701.GA191795@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Sep 2019 16:23:25 +0200
Message-ID: <CAP8UFD3zw1dYUZ8Sei+kzcYmcsgQsRLoy1uHU+ZQp6CBDbCVkQ@mail.gmail.com>
Subject: Re: Git in Outreachy December 2019?
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 3:35 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Fri, Sep 20, 2019 at 10:04:48AM -0700, Jonathan Tan wrote:
>
> > I'm new to Outreachy and programs like this, so does anyone have an
> > opinion on my draft proposal below? It does not have any immediate
> > user-facing benefit, but it does have a definite end point.
>
> I'd appreciate similar opinion if anybody has it - and I'd also really
> feel more comfortable with a co-mentor.

First as the deadline is tomorrow, I think it is important to submit
projects to Outreachy even if they are not perfect and even if we
would like a co-mentor (which is also my case by the way).

We can hopefully improve the projects after the deadline or perhaps
drop them if we cannot find enough co-mentors or if we don't agree
with the goal or find it too difficult.

> """
> "Did You Mean..?"
>
> There are some situations where it's fairly clear what a user meant to
> do, even though they did not do that thing correctly. For example, if a
> user runs `git commit` with tracked, modified, unstaged files in their
> worktree, but no staged files at all, it's fairly likely that they
> simply forgot to add the files they wanted. In this case, the error
> message is slightly obtuse:
>
> $ git commit
> On branch master
> Changes not staged for commit:
>         modified:   foo.txt
>
> no changes added to commit
>
>
> Since we have an idea of what the user _meant_ to do, we can offer
> something more like:
>
> $ git commit
> On branch master
> Changes not staged for commit:
>         modified:   foo.txt
>
> Stage listed changes and continue? [Y/n]
>
> While the above case is a good starting place, other similar cases can
> be added afterwards if time permits. These helper prompts should be
> enabled/disabled via a config option so that people who are used to
> their current workflow won't be impacted.
> """

I agree that it might help. There could be significant discussion
about what the UI should be though. For example maybe we could just
promote `git commit -p` in the tutorials instead of doing the above.
Or have a commit.patch config option if we haven't one already.

Thanks,
Christian.
