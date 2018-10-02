Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D4701F453
	for <e@80x24.org>; Tue,  2 Oct 2018 16:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJBXAt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 19:00:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54935 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeJBXAs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 19:00:48 -0400
Received: by mail-it1-f194.google.com with SMTP id l191-v6so4197230ita.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ghN9OXAqksLOJGXGemyH5KQlO8iPxUvpGxT0AjI6TYs=;
        b=bkiLNE+TgmDNiKlBFQA0e5uPHP1h2mffK3jbSA/dbVfQB+QKRIDwhBGPwdI+AeJHv4
         +rJis5Ax9AsnnoR0H+JwiEtsu7l4PynqDhnKJdRXFeDCe/awZPr6hyjLWB1DFmY9tRUU
         DNiF+vP1HdgSMOb4kxIfGDX0yajKmDar4XAWxWlf7YC0s0EOnm8EgWY0iqLz69g6Pm4b
         nQVy7WZ6P5qR9a6OI6COPiCsux8WIo2EBHk9sk7EGOJfzbaiRpz0Yv1amH+nDmv7rGHb
         aG1nI5beZQC8kiX1Twcb/WRb1QzyjjhkR6RAjYNhIK8Lf8jhKIXFLyX5QQ2SHuGnq6TL
         NKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ghN9OXAqksLOJGXGemyH5KQlO8iPxUvpGxT0AjI6TYs=;
        b=XB+bB+O0e/c4QSnpzM/e3BXwYZHmyi6b5LgQw6jDX3ol1S+BmJ08mAURXvC3LdYHgj
         SbjV1iXbqLdd+8AutJ28k4TYhK0t8xS6sRvKQofyEbVQ739I+IoRen/Q6rCjyhfrftYi
         m0jR++POq2Vw4/tJjOJ8/RN/o4HjMvkQGdoCw7wH+kglNAZYbtbxPHGKKQGRvIOnf7fi
         Bcb+vn3Fo2Dzcloeejoj2VSpPrHFB1dvWz/Ffw9cTXZYIqx3Yb6P/E7lc81dELltcGGr
         hfaEzAB9r8w4gplj6JmwhQIz2R7GPwJR/b5MW+NGa6/mfv8CswNGXd0vAQIIsOeqewBC
         zESQ==
X-Gm-Message-State: ABuFfogQchg3qdm2oWb+Zgr5N4wCGM8oeLlbrJsyAJ00s6ailqClqild
        nZm1nvO8wgSIbmCthLNwxAL9wy6JjQ4F7F3gsXo=
X-Google-Smtp-Source: ACcGV62zGJf1ufRQwiFCd0uY5n62kda0WM2eMNhZmmyDpTCiAfYyG48B+M2JmzzCbFysfu2GEgDD86ZeeYeXJzd8/dI=
X-Received: by 2002:a24:aa41:: with SMTP id y1-v6mr2561955iti.91.1538496999560;
 Tue, 02 Oct 2018 09:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180929191029.13994-1-pclouds@gmail.com>
 <20180929191029.13994-9-pclouds@gmail.com> <CAPig+cQBiXRvzf6skmmyVap-6fLEbmVRGNBQqD4H-HfAPampjA@mail.gmail.com>
In-Reply-To: <CAPig+cQBiXRvzf6skmmyVap-6fLEbmVRGNBQqD4H-HfAPampjA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Oct 2018 18:16:12 +0200
Message-ID: <CACsJy8C1niWzC8GPiKkXmyBwxbctb-vmM51CVts12TMzLFnJVA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] reflog expire: cover reflog from all worktrees
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 30, 2018 at 7:36 AM Eric Sunshine <sunshine@sunshineco.com> wro=
te:
>
> On Sat, Sep 29, 2018 at 3:11 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> > diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.tx=
t
> > @@ -72,6 +72,11 @@ Options for `expire`
> > +--single-worktree::
> > +       By default when `--all` is specified, reflogs from all working
> > +       trees are processed. This option limits the processing to reflo=
gs
> > +       from the current working tree only.
>
> Bikeshedding: I wonder if this should be named "--this-worktree" or
> "--this-worktree-only" or if it should somehow be orthogonal to --all
> rather than modifying it. (Genuine questions. I don't have the
> answers.)

It follows a precedent (made by me :p) which is rev-list
--single-worktree. I doubt that option is widely used though so we
could still rename it if there's a better name. I made
--single-worktree to contrast "all worktrees" by default. Even if it's
"this/current worktree" it still has to somehow say "everything in
this worktree" so I felt modifying --all was a good idea.

> > diff --git a/builtin/reflog.c b/builtin/reflog.c
> > @@ -577,10 +585,18 @@ static int cmd_reflog_expire(int argc, const char=
 **argv, const char *prefix)
> >         if (do_all) {
> >                 struct collect_reflog_cb collected;
> > +               struct worktree **worktrees, **p;
> >                 int i;
> >
> >                 memset(&collected, 0, sizeof(collected));
> > -               for_each_reflog(collect_reflog, &collected);
> > +               worktrees =3D get_worktrees(0);
> > +               for (p =3D worktrees; *p; p++) {
> > +                       if (!all_worktrees && !(*p)->is_current)
> > +                               continue;
> > +                       collected.wt =3D *p;
> > +                       for_each_reflog(collect_reflog, &collected);
> > +               }
> > +               free_worktrees(worktrees);
>
> Should this have a test in the test suite?

Of course. I was partly lazy/tired near the end, and anticipated more
comments anyway so I did not do it :D
--=20
Duy
