Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04A01F453
	for <e@80x24.org>; Tue, 22 Jan 2019 10:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfAVKKD (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 05:10:03 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:33959 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAVKKC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 05:10:02 -0500
Received: by mail-io1-f47.google.com with SMTP id b16so18705408ior.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oV1gyGLciT3lJX5ydoYjodzEcxBa1W9TLjYQxe6AeWw=;
        b=dzVdjETWloZDPdxup4o33yQV+DasWG06CkA8NXiXGXacHqFLXl1YpT/RqQfN1jygGG
         spyr2iRnSgHyFcTs/2aQhnTvt5JZn65ZDqFQyqHm3/9VZEFFZ8FEDlvRtUVRGOGzv3tK
         k5O6wKIKOFE66ApadrM5nyZdE8FlKDsaYaYs4oMz2ssQRYVR3hz8S37xwBVB3B1l1+fL
         dn68Rhbl1+yWSrYfcKZ8p1ct51hF31IwnC/zuVSP2zpCv5WDYSZIhz/RGkMcJ7778PE0
         kSML64xle0KQqnmXK4U3q9F0GvMbN/VdA09d7h3ghIhPacNA2YBgzcTmZ10Y0+4z4/9S
         BewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oV1gyGLciT3lJX5ydoYjodzEcxBa1W9TLjYQxe6AeWw=;
        b=KmUJEvMokYYXUzCni2zLXQwMyMqt7tf7xuYzfonHS4j+iyFIbJDZi7xzJ2LUA2fvCo
         ka0L5+1YybvXNGf8Crj7tyzQCxvqSTTFSdT5hC0207KtHXSC+7znnpSmvx26NxFFX/JF
         VDOA7YjAxnQzjXdNKu04a2Rmms8FXa7QyiQ4WZGL4aYnsEw/lBjefC+HFJTdbCgCemJO
         L1/ZMYmTTIzF/fLWnuMKQpBDX8R7r+bB0l0H7aoeKV3L97qfDLIkJuIWJ3r7CkizsU5d
         Jup2d1npwMXj9mVsbu7UHPLsEw0n/irq9ZVVbMpjJ9skUOrg6ewPtkZUrmsooQ9WWv+6
         l3UQ==
X-Gm-Message-State: AJcUukfApiYv6sOqmqsomfVkXNl41npCkVJXHXr8Q2S32RZLvKA5t/Wo
        HNGd9usDT/szIbNMz1P6jbpmwGk0ZkkysH4QqGntBJrn
X-Google-Smtp-Source: ALg8bN5h6LNhXEBU3jGMmRYEij+4Vu9zpH5F/LeKWjBOZYGfQq73ONKwnxDy8Za8Y8hlpZjTkFZ9vRJ4qSQK1VIVIGs=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr18850087iof.118.1548151801240;
 Tue, 22 Jan 2019 02:10:01 -0800 (PST)
MIME-Version: 1.0
References: <86fttvcehs.fsf@matthieu-moy.fr>
In-Reply-To: <86fttvcehs.fsf@matthieu-moy.fr>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Jan 2019 17:09:34 +0700
Message-ID: <CACsJy8CiPPp0C6o_ADv_mvi2gv=PsR+W=E3OHYw8hWbsPhrpOQ@mail.gmail.com>
Subject: Re: Students projects: looking for small and medium project ideas
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 12:55 AM Matthieu Moy <git@matthieu-moy.fr> wrote:
>
> Hi,
>
> ...
>
> You may suggest ideas by editting the wiki page, or just by replying to
> this email (I'll point my students to the thread). Don't hesitate to
> remove entries (or ask me to do so) on the wiki page if you think they
> are not relevant anymore.

I just mentioned this elsewhere [1] but let me summarize it here
because I think this could be an interesting thing to do and once you
get attr.c code it's not that hard to do. The student would need to
understand about git attributes and how it's implemented in attr.c.
But that's about it. More background below, but the summary line is
"optimize attribute lookup to be proportional with the number of
attributes queried, not the number of attributes present in
.gitattributes files".

So, we normally look up the same set of attributes over a long list of
paths. We do this by building up an "attribute stack" containing all
attribute info collected from all related .gitattributes files.
Whenever we move from one path to the next, we update the stack
slightly (e.g. if the previous path is a/b/c and the current one is
a/d/e, we need to delete attributes from a/b/.gitattributes from the
stack, then add ones from a/d/.gitattributes). Looking up is just a
matter of going through this stack, find attribute lines that match
the given path, then get the attribute value.

This approach will not scale well. Assume that you have a giant
.gitattrbutes file (or spreading over many files) with a zillion
random attributes and two lines about "love" attribute. When you look
up this "love" attribute you may end up going through all those
attribute lines. [2] hints about a better approach in the comment near
cannot_trust_maybe_real. If you know you are looking for "love", when
you build up the attribute stack, just keep "love" and ignore
everything else [3]. This way, the attribute stack that we need to
lookup will have two lines about "love". Lookup time is of course now
much faster. In the best possible case, when you look for an attribute
that is not defined anywhere in .gitattributes files in your repo, you
get an instant "not found" response because the attribute stack is
empty. This edge case was implemented in [4].

[1] https://public-inbox.org/git/20190118165800.GA9956@sigill.intra.peff.net/T/#m32fef6a9e8f65dffae41e44a62dd76b4a84fa0fe
[2] 7d42ec547c (attr.c: outline the future plans by heavily commenting
- 2017-01-27)
[3] well, macros make it a bit more complex, but I'll leave that as an exercise.
[4] 06a604e670 (attr: avoid heavy work when we know the specified attr
is not defined - 2014-12-28)
-- 
Duy
