Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA5620248
	for <e@80x24.org>; Thu, 28 Mar 2019 17:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1RoL (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 13:44:11 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40297 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1RoL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 13:44:11 -0400
Received: by mail-wr1-f41.google.com with SMTP id h4so8364760wre.7
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OZCOAJdsoCY6aEmRtmuMRTQ/dGHBxb+2FihaHKlcME4=;
        b=GEd7DIW9VEY67Yx4GePymNc+wXVdvhjllUAjutnF/Y4vHd5rKXq9NxR2pBs4O4YsfX
         X7KCrLvQYO8ByYQ+X0Zpn2frk3jNSCZRUlBTrKZ9bkzHtOVPc9Agt9/miw4zl0JgKwWz
         H175Io840nFPA1FUr3tAzmUtXrsE0r4CY4qZXFkDFS7JCdHqF5KP4HbEcmRULS4UeS1Y
         AuPLLeGe2iV4Wz3JJxIGz1PfED8DYRMPXdW4lUKggyIBHzuXfbr5CzNulV2G/Z5GN+S+
         Wq8hyDzjMtO72SbvTDhqOlt7IUHgz91I+iyyXcXO/VM4ApemidWeWPjRXQqeyrLxeSuN
         7bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OZCOAJdsoCY6aEmRtmuMRTQ/dGHBxb+2FihaHKlcME4=;
        b=BjLEfui8ROmpd0F7+XdI1nZ1aNcSxy3cMNlfxJDMS+WyuwPU/i0mV1ItjrJB8UlkJO
         ZuABnh74Yll2YyOZys1aFcKxe8uv2lbe2ik1XE2dLGn8SVZMBaMRnFe9TM0ZtJ0uXa+h
         +E5xNosUqi0UVycNSpFn6jWk9ERs1sUdAOxOYRtuwi81pomSRvCvCWW//WdmMLhQOu6x
         E0IOvon5ioyZh9wNT8RRGqhuI176q9ECv5EKrZn6tT5tE/v/phI+mTP8QikP4kIylTsH
         AGdH0f4M5dgZ3SuwMMrlYwwV0MQFZPzjgiAk+0mPbZzHM7q2+Mlb6PRcgBJYn7EswPy6
         IsJg==
X-Gm-Message-State: APjAAAVyrnDGEVQlydqWj0SBE1RB3qGcM3DncpWodbA3iuZxfcZZLghm
        9nZiBDg3878p7OqHEsomPG9yX6h8LZd/DuYrAZsfkw==
X-Google-Smtp-Source: APXvYqxKy071i3991L5fwhFxP7/WsCwbL0b0D6JwoZQIyZ9fqCHoZbMI96BCXSsQ8ouBQNT/R2aRWwkxLGf1tsV3MPM=
X-Received: by 2002:adf:f78d:: with SMTP id q13mr10771327wrp.194.1553795048878;
 Thu, 28 Mar 2019 10:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com> <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
In-Reply-To: <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Thu, 28 Mar 2019 20:43:57 +0300
Message-ID: <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D1=81=D1=80, 27 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 20:01, Kapil Jain =
<jkapil.cs@gmail.com>:
>
> > On Tue, Mar 26, 2019 at 2:48 AM Olga Telezhnaya <olyatelezhnaya@gmail.c=
om> wrote:
> >> Kapil Jain <jkapil.cs@gmail.com> wrote:
> > > Now, the verify_ref_format function can be used inside
> > > get_commit_format function, hence reusing logic.
> > > Is this a correct example to work on, for this project ?
> >
> > Hi! Yes, in my opinion your example looks like good starting point.
>
> I read through the code of both functions, and I think they are different=
.
> Please point out if I missed to see the similarity.
>
> or may be it seemed that way, because they both deal with different forma=
ts.
> So, first should a translating function (pretty to ref-filter) be written=
 ?
>
>
> > > Other than this I can't find any other example, for this project in
> > > pretty.* and ref-filter.*
> > > Perhaps some examples could be found in command specific files, right=
 ?
> >
> > Other parts of the project are about reusing other ref-filter logic.
>
> So, the project is not limited to reusing ref-filter logics in pretty,
> it is about reusing ref-filter logic wherever possible, right ?
>
> > For example, we could try to reuse format_ref_array_item() from
> > ref-filter.h.
>
> where can format_ref_array_item() be reused ?
>
> > I haven't dig into pretty.c logic much, but I guess it
> > is possible to translate "pretty" formatting commands to ref-filter
> > ones. That will allow us to remove similar logic from pretty.c. Our
> > final goal is to minimise code duplication and to have one unified
> > interface to extract all needed data from object and to print it
> > properly.
>
> I looked, and yes some, but not all pretty formats are translatable.
> For example: %GP, %p, %P. are not translatable to ref-filter. or is
> there a workaround to translate them ?

I will try to answer to all your questions here in general way.
Thomas, Christian, please correct me if you disagree.
Our main goal is to simplify codebase, get rid of duplication of
similar logic and, as a result, simplify adding new functionality. We
also need to save backward compatibility, so we can't just delete some
commands, rewrite them and change their interface (unfortunately). You
are free to suggest your own ideas how to achieve these goals, and you
are free to choose exact tasks. Yes, you are not limited only to
pretty.c, but it is a good place where to start.

I was an intern in winter 2017-2018 and I was trying to get rid of
formatting logic in cat-file. You may try to do same thing in
pretty.c. I guess it's easier to think how to reuse ref-filter in
pretty.c because ref-filter has the most general interface between all
these files. But, if you are sure that you have better idea - I am
strongly recommend you to share it with the mailing list.

Unfortunately, I can't consult you properly about structure of
pretty.c. I guess that would be your first task of the internship to
dive into it and think how to improve it. By the way, you could try to
make more detailed documentation and that could be one of your first
contributions. It will help you to understand the system better, and
other contributors will be happy to read it.

>
> It looks like to reuse ref-filter logic, a translator from pretty to
> ref-filter needs to be built.
> So, building a translator would be a starting point ?
> and then second step would be to recognise places where ref-filter can
> be reused, right ?
>
> > > what is atom ? is it a piece of a whole document ? and what is meant
> > > by used atoms ?
> >
> > I had the same question in my beginning. Please have a look at [1].
> > Another good question - what is object. You could ensure that you
> > understand this by reading [2].
> >
> > [1] https://git-scm.com/docs/git-for-each-ref#_field_names
> > [2] https://git-scm.com/book/en/v2/Git-Internals-Git-Objects
>
> Thanks, this helped.
