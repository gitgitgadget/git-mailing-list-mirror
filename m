Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328351F731
	for <e@80x24.org>; Tue,  6 Aug 2019 04:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfHFE7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 00:59:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40113 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfHFE7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 00:59:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so81050667eds.7
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UP1daW7PfITPb8s3RNnn/FlxGG/13cKqd05ict8o0/o=;
        b=KeSfLLRGrAOqI8EU3mqF+BfoKirmiVnqmAbbF32o9FGijYwUxrW3cX/dQJ+/URiAd4
         NL69AWBpycEC5TFX0qDEZZOkZLKEQ73haNGFNrVnj5LguM/Hivag5illW+PLBfXp2PgX
         YbzumdFj0ikyQqFdcndDG1YClXjLY2a8EaSUVlYoRHL8mj1HGwG3ZKocucmyn1vfMivL
         rwlvHgSTkU+DdxNDNbG+/8k5EnjHyKQGAA+318bjEtf24AVcE7uOJ4O/MH8y44hOzBvI
         UQpqWXDPdnVLxeTmtjmyXdOlxbOhu5IuZcJmfHc9z74osYoUgh5mFpr2ssy3RXfEuEtN
         HZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UP1daW7PfITPb8s3RNnn/FlxGG/13cKqd05ict8o0/o=;
        b=Yd8H+iNG5veGa8MoQYyaC2f7ORPB0WCTSrXHFd4W1tComHq90MfDTxoe2NkOROePYa
         m6fbUnHxxzv0xCmLGMs2Ri65Cg8gWGZw6xhzRBpkaKaIaNBUDgp2wL0Wzpv1AcEOFOdJ
         rIyXmlQeuawrzRdHhw4rnIVYUlGFwaM+kT+KhfXcNMWf85hOO0i8GLqBEVs+6IYPTpOm
         K1AauuRV11KBtKpxFx9X60rhm+Nwao9PmT6vbYHGWU9plmCN+kxfO9iqG7pYrHXE7X8c
         meLaeyheMkagQKNKPbKhQFEs9bIq4IWDq6WU0CQ6gJVPgpLs+VulKImsyB/Esg65nVZ+
         4dIA==
X-Gm-Message-State: APjAAAUOHRKjUuM7/FqDuoI/KSF72pK3jd6o/RDucMOcYl/q4iurF5l3
        QYIln7czMAHkZzpwwCH1rV2B13nhmuyh7P62bdoE1yc/
X-Google-Smtp-Source: APXvYqwH37R3Lc5KlGXHRlbN8mJhkMWA7kTH10x7VmMyV6u2VAPynco5U2JZFFASM6S9XqbDTNyip76k0yZTwImgi9A=
X-Received: by 2002:a17:906:3018:: with SMTP id 24mr1347913ejz.187.1565067572940;
 Mon, 05 Aug 2019 21:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190806014935.GA26909@google.com> <xmqqlfw7klwk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlfw7klwk.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 6 Aug 2019 06:59:21 +0200
Message-ID: <CAP8UFD1XNGWf8=_LvrEsFswZdw5pydk2VyVWxWvwALfhVbBOsg@mail.gmail.com>
Subject: Re: RFC - Git Developer Blog
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 6, 2019 at 5:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Shaffer <emilyshaffer@google.com> writes:
>
> > In backchannels recently there has been some discussion about the idea
> > of a Git-project-blessed blog written by Git contributors, generally
> > covering usability tips or overviews of the internals of Git which the
> > general public tend to find confusing.
> > ...
> > The idea is that we could cover high level topics stringing together
> > multiple components or giving power user advice, which we can't really
> > do with the manpages.
> >
> > Thoughts?
>
> Interesting.
>
> I recall that I used to do the "Fun with ..." series back when I was
> more into use-case-exploration mode; writing those articles was fun,
> but it took a lot of time and quite an effort, so I stopped after
> writing enough.

Linux-Kongress (LK) was a conference organized by the German Unix User
Group from 1994 to 2010. They asked authors of accepted submissions
for the technical sessions to provide a paper for publication in the
conference proceedings. As I wanted to give a presentation at LK 2009,
I wrote a paper about git bisect and asked kind souls (like Junio) to
review it on the mailing list. A bit later it was included in the Git
documentation and is still there:

https://git-scm.com/docs/git-bisect-lk2009.html

The git bisect man page links to it, but I must say that it tends to
be a bit obsolete as it has not really been updated.

There are also "guides" that are part of the actual documentation and
can be listed using `git help -g`.

> Making it a group effort may help by allowing writers and reviewers
> to encourage each other.

When Git Rev News was started I thought that there could be such a
group effort to encourage each other to publish articles in it, but I
must say that outside the group of editors (currently Jakub, Markus,
Gabriel and me) it hasn't happened much.

Each month though there are a small number of people helping on
smaller things like short news, typos, releases, etc. And people who
are interviewed are doing a great job when they accept to be
interviewed.

Maybe it's also not clear that we could accept other kind of articles
than just articles focused on what happens on the mailing list. I
think we have generally tried to highlight articles by Git developers
that were published on their blogs or their company's blog though.

In any case if you or others would like to join the editor group to
focus on other kind of articles, or just to help a bit, you are most
welcome!

I would also be ok to change the form of Git Rev News if there is an
official blog. For example the "Discussions" section could become
something like "Featured articles" with links to articles on the blog.
