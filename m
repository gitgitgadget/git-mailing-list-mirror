Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378F51F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJCByA (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:54:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37823 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJCBx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:53:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so436369pfi.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euvE31kvUQM3D2LFL5LvhWDMz1LiKcuXNkA0biw8L7o=;
        b=jNYLtWj/88uXz4aXrS2jbgEm3X0vKhrVMiBtwCJLEnPCgLm6qVWXcaUyJ94G31tKHH
         3cdPQCLlrhxuxH69N5Dyk87DM2e7e4+qZaTNtcmlbiYIjitlJ1BvOeQg4e3GFgUQEi+r
         bGvBLYyElx5RS/pLWIqYkbW5Qws4RLxI1mFnV32DUYgNDyEbAmXpoyjATsNMrIcGCehS
         E8+kcTN4ed2/0DuPQCaQwk9ZI1IAsY0BQCkU/nlgNnRN9flybcuFMTc6iHAlH0eYWssK
         +FYAvgCEJmPWI+cLqqOrz0oX8QzFn1soS1DgCqvGpxXALnVMoPStqmC5nSbqemQ5uvwn
         SQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euvE31kvUQM3D2LFL5LvhWDMz1LiKcuXNkA0biw8L7o=;
        b=oVx1Pb6nH5IJRFbJEId06EgarmOS2+zRCEWuQqcQnmfTT+3KFmECF/SMioGtuu6CcL
         YA63HGaWZKt9kA94Dumf3sr1X0csXpXvJgfhDS0RZBhrJfqVCYqho2QCyUc5eRT1GQIC
         EZRFZvmvyw4OoYzZ0TZW1A6ue37Hlknk7yBysZxh6f7cZ+w145INHXg6onnMIkIjgm7E
         /UAr/KDCjJa/43yQAVDsWrUdw7MqA2lnXXwdCldgbHt6ln53hHGFOSYJm5ZoUGKi+itU
         t59rtY+f2HJPFDxrfihUTG3PYVhUeJ5Ss14pMQm9r5M27VIDns42CpD05BuHaDPrBS0Q
         kVmw==
X-Gm-Message-State: ABuFfoj3d4IP3GDnwx6fHOU4AbUnTorNXoGG4y8Sb0JwGvL6fBG2mZNF
        VSkb7ZgySexcGejRikyxtqSW4Gne6ODTxvftZEM=
X-Google-Smtp-Source: ACcGV600H3bYRyPgil4oH2DJ/KDaDWHPRUVlz5+Vy7kih8m6c3MlldkiTr9L1hfjXE4JndWDVRSCTJa1iC+WmnZGts0=
X-Received: by 2002:a62:9015:: with SMTP id a21-v6mr14640172pfe.49.1538507349131;
 Tue, 02 Oct 2018 12:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.42.git.gitgitgadget@gmail.com> <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com> <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 2 Oct 2018 21:08:57 +0200
Message-ID: <CAN0heSqOjYDXRf4KE_C0GDnFW8r4qVfWnUVuW-Q+4D87nhFURQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Oct 2018 at 19:59, Stefan Beller <sbeller@google.com> wrote:
> > > +
> > > +       string_list_clear(&list, 0);
> > >  }
> >
> > Nit: The blank line adds some asymmetry, IMVHO.
>
> I think these blank lines are super common, as in:
>
>     {
>       declarations;
>
>       multiple;
>       lines(of);
>       code;
>
>       cleanup;
>       and_frees;
>     }
>
> (c.f. display_table in column.c, which I admit to have
> cherry-picked as an example).
>
> While in nit territory, I would rather move the string list init
> into the first block:
>
>   {
>     struct string_list list = STRING_LIST_INIT_DUP;
>
>     for_each_ref(add_ref_to_list, &list);
>     write_commit_graph(obj_dir, NULL, &list, append);
>
>     string_list_clear(&list, 0);
>   }

Now this looks very symmetrical. :-)

> > >  void write_commit_graph(const char *obj_dir,
> > > @@ -846,9 +848,11 @@ void write_commit_graph(const char *obj_dir,
> > >         compute_generation_numbers(&commits, report_progress);
> > >
> > >         graph_name = get_commit_graph_filename(obj_dir);
> > > -       if (safe_create_leading_directories(graph_name))
> > > +       if (safe_create_leading_directories(graph_name)) {
> > > +               UNLEAK(graph_name);
> > >                 die_errno(_("unable to create leading directories of %s"),
> > >                           graph_name);
> > > +       }
> >
> > Do you really need this hunk?
>
> graph_name is produced via xstrfmt in get_commit_graph_filename,
> so it needs to be free'd in any return/exit path.

Agreed. Although I am questioning that `die()` and its siblings count.

> > In my testing with LeakSanitizer and
> > valgrind, I don't need this hunk to be leak-free.
>
>
> > Generally speaking, it
> > seems impossible to UNLEAK when dying, since we don't know what we have
> > allocated higher up in the call-stack.
>
> I do not understand; I thought UNLEAK was specifically for the purpose of
> die() calls without imposing extra overhead; rereading 0e5bba53af
> (add UNLEAK annotation for reducing leak false positives, 2017-09-08)
> doesn't provide an example for prematurely die()ing, only for regular
> program exit.
>
> > [...] With this hunk, I am
> > puzzled and feel uneasy, both about having to UNLEAK before dying and
> > about having to UNLEAK outside of builtin/.
>
> I am not uneasy about an UNLEAK before dying, but about dying outside
> builtin/ in general

Yeah, not dying would be even better (out of scope for this patch).

> (but having a die call accompanied by UNLEAK seems
> to be the right thing). Can you explain the worries you have regarding the
> allocations on the call stack, as xstrfmt is allocating on the heap and we
> only UNLEAK the pointer to that?

I think we agree that leaking things "allocat[ed] on the call stack"
isn't much of a worry. The reason I mentioned the call stack is that
we've got any number of calls behind us on it, and we might have made
all sorts of allocations on the heap, and at this point, we have no
idea about what we should be UNLEAK-ing.

My worry is that one of these would seem to be true:

* UNLEAK is unsuitable for the job. Whenever we have a `die()` as we do
  here, we can UNLEAK the variables we know of, but we can't do anything
  about the allocations we have made higher up the call-chain. Our test
  suite obviously provokes lots of calls to `die()` -- imagine that each
  of those leaves a few leaked allocations behind. We'd have a semi-huge
  number of leaks being reported. While we could mark with UNLEAK to
  reduce that number, we wouldn't be able to bring the number of leaks
  down to anywhere near manageable where we'd be able to find the last
  few true positives.

* We add code with no purpose. In this case, we're not talking a lot of
  lines, but across the code base, if they bring no gain, they are bound
  to provide a negative net value given enough time.

Martin
