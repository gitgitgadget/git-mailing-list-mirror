Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2801F404
	for <e@80x24.org>; Tue, 24 Apr 2018 08:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeDXIkz (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 04:40:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:35225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932850AbeDXIkw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 04:40:52 -0400
Received: from [10.49.234.97] ([95.208.59.141]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWhRH-1ev7wp1aCB-00XqTw; Tue, 24
 Apr 2018 10:40:40 +0200
Date:   Tue, 24 Apr 2018 10:40:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 09/16] rebase: introduce the --rebase-merges option
In-Reply-To: <E8BADD438B3F4D20B33BCC2CD92BC004@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804241037300.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <0c92bdd1829328544269722cbbd3edcd169bb148.1524306547.git.johannes.schindelin@gmx.de> <E8BADD438B3F4D20B33BCC2CD92BC004@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:W3+xHt2NWzIWbOX4IVnzUAlCvkSyaanW+cxjLc9V9TIW4EL3bPq
 5tYV9ZUmdCVjFtze1bI9AGfmCMUMa0tF5aEWPGKJhn32DbeSYgkB+srJhG83Qf+lR1rf7Ts
 o7RUksLJDYMrS6FyNzYwiaQrAYwfJHOGcgKWar9Uy+DNwGsDZAJ9aPm1Q9RvAUqlHZpZoP7
 mKbZkGfelEgCNKERGVL4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v930RhtIk50=:6vECMWrUOOwIWgs8QQH4uh
 KFMwR+quWV/b2sbIpsfeceK3ByZAcHhqDssHBUu3NIYPUCjrw+XvEIdBzfN6ZW6jQgpX4uvlO
 lIrU8+73GFSaK5R+TfcaGACftN8R2iuIRrqJ104c9myGIzFsVRINxf9IXFeSAdinnUOv/5NPS
 +ed4HYvPr8arQv/3lgLfdyC73GaNFNatR91KyBXjk/dOGqFM6eJNRJ0UVzWRpgtA8fxMajsSs
 vR6LADl22Gzh7sKylhMVniGoYyqb2J8rYpakrfv//QE7/8KCelwzYstLAJrVgCCNnSDVnLc2q
 IEGEaaYI34YwpnR4XtT1FJbO7t3/3pe53YEGWtqGHLVktlqlPVP0rmDSK+6ufS2jwqLVpbt2O
 B/po6TIyvgDh+2LJU9d8Gomr7suEE+o3g9j2LsDRFUaxgF6PdPRFWmDytF37PYrLom9n0Td0+
 HZajJjxWAeR2gnCn4l2faYaO/F119Tcisk7zwBF+oQK+odguc3dsF8U9jUT/UviJ813yPHBim
 MjVIzpuWyg4VTt6IMd31Rj+JE+i/JP8+0HOQ7Gs7v9Qtcroa3WF3NPF6HN8ZzBOlLA9mRKAyd
 8CSRi1VBCn4laZSKx7Mh6t6A05RpjlIlSKkjvQmT6ha3knJzew3H/xP/vFBKwa7aPv8EsYaVz
 WUX/aRAuhWKlSb58OBx03GEoa75zrScdXrtEzH8Ke5lEkGT4SKxMRz1v1C8Hpw6QfW3TcZ0YF
 PmE6v26bZ12B1HtJXYFbWa4ahiGwkhfJK9QL1e2EHCM6cwoupLzLEfvJBF3RdmIXtXXuFJDfx
 hAmlWWGCrx3UbFG0y2UYtlrMVwyo25vUWz27XyJBHNiew2bn8g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 22 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> > Once upon a time, this here developer thought: wouldn't it be nice if,
> > say, Git for Windows' patches on top of core Git could be represented as
> > a thicket of branches, and be rebased on top of core Git in order to
> > maintain a cherry-pick'able set of patch series?
> >
> > The original attempt to answer this was: git rebase --preserve-merges.
> >
> > However, that experiment was never intended as an interactive option,
> > and it only piggy-backed on git rebase --interactive because that
> > command's implementation looked already very, very familiar: it was
> > designed by the same person who designed --preserve-merges: yours truly.
> >
> > Some time later, some other developer (I am looking at you, Andreas!
> > ;-)) decided that it would be a good idea to allow --preserve-merges to
> > be combined with --interactive (with caveats!) and the Git maintainer
> > (well, the interim Git maintainer during Junio's absence, that is)
> > agreed, and that is when the glamor of the --preserve-merges design
> > started to fall apart rather quickly and unglamorously.
> >
> > The reason? In --preserve-merges mode, the parents of a merge commit (or
> > for that matter, of *any* commit) were not stated explicitly, but were
> > *implied* by the commit name passed to the `pick` command.
> >
> > This made it impossible, for example, to reorder commits. Not to mention
> > to flatten the branch topology or, deity forbid, to split topic branches
> 
> Aside: The idea of a "flattened" topology is, to my mind, not actually
> defined though may be understood by devs working in the area. Hopefully it's
> going away as a term, though the new 'cousins' will need clarification
> (there's no dot notation for that area of topology).

Right. The point is not actually to talk about "flattening" branches. The
point is to talk about the flexibility one might expect in an
*interactive* rebase, a flexibility notably lacking from the
--preserve-merges mode.

So I changed it to

    This made it impossible, for example, to reorder commits. Not to mention
    to move commits between branches or, deity forbid, to split topic branches
    into two.

> > into two.
> >
> > Alas, these shortcomings also prevented that mode (whose original
> > purpose was to serve Git for Windows' needs, with the additional hope
> > that it may be useful to others, too) from serving Git for Windows'
> > needs.
>
> [... please feel free to save readers time by culling quoted text that
> is irrelevant to your reply...]
>
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 3277ca14327..34e0f6a69c1 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -378,6 +378,23 @@ The commit list format can be changed by setting the
> > configuration option
> > rebase.instructionFormat.  A customized instruction format will
> > automatically
> > have the long commit hash prepended to the format.
> >
> > +-r::
> > +--rebase-merges::
> > + By default, a rebase will simply drop merge commits and only rebase
> > + the non-merge commits. With this option, it will try to preserve
> > + the branching structure within the commits that are to be rebased,
> > + by recreating the merge commits. If a merge commit resolved any merge
> > + or contained manual amendments, then they will have to be re-applied
> > + manually.
> > ++
> > +This mode is similar in spirit to `--preserve-merges`, but in contrast to
> > +that option works well in interactive rebases: commits can be reordered,
> > +inserted and dropped at will.
> > ++
> > +It is currently only possible to recreate the merge commits using the
> > +`recursive` merge strategy; Different merge strategies can be used only
> > via
> > +explicit `exec git merge -s <strategy> [...]` commands.
> > +
> > -p::
> > --preserve-merges::
> >  Recreate merge commits instead of flattening the history by replaying
> 
> Flatten is here in the context lines but its just a blunt statement that 'it
> is what it is'...

Correct. This is where that way of expressing things came from.

I will *not* fix the documentation of `--preserve-merges`, though, as I
hope it can be instead retired soon enough.

Ciao,
Dscho
