Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B7F1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 11:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGBLKJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 07:10:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44327 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBLKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 07:10:09 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so35953053iob.11
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 04:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4/pHoXESEDLfoW2RTIotcR/cs8lfIa5VrsTn/z40T/8=;
        b=qxB393Q4T4Sp5xKvCP9Lpk27iq/vMXa8xv4s0A20/8wMmxJjABxZDluFiZEQZY86Mj
         h40PGIaVr1n0oc8/nU3wRvjG70ur7dfyXq7RQN8io45QBWsEZwNVd/ZWBTDZzNCzXozR
         ps11mUEYaPmNJ34YYlcVy5vV8XHpTpWy+RUzcCVjxopMYpPVO+39QMaKdQ3cUDgjKS7m
         4jc4r8UY5V5Zc9RrNoAjkPFQzkw29lXJhM67GlM1EbEpLF/kx/jWFbzmk1PI/XcDGbm9
         L1/wwelsZErkRr9grXYU4lPWiM9W4Jynk+Qk6/G+5KUZpiu32gjTcGwiICwMKgCXfMtB
         y5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4/pHoXESEDLfoW2RTIotcR/cs8lfIa5VrsTn/z40T/8=;
        b=JpNG3YwxLmYeu3eJgyp9Ln4VVmU7dOfowbqbK/ktImALJ3spuB2KFV2u1Bk/jflvOb
         kQKDyfT57nfp7GxDRcKLeKRkneoUNFirYLzWoD65LyeofUj0/oyKs1A4C0OZx2x4OrpO
         fmvplDnHh/782oWAupCqgnmF3Xo7xvpGSl3AjVWsgRzXbcRFof5Qb0OjMQeEtlcG7Jxo
         3UalLZWyKTjHp32lH5Y/4Dj8MffiabrxYXDYL32fKcvEm0aKEVdsDLbRxHHsC995VU5n
         mqiTazsgsXrpdb1NXNFtzKleN78ioj6arho0jGmIRSG7WqWVLH3pL0HDFQVn6EBCUlkj
         QMkg==
X-Gm-Message-State: APjAAAUzJ+A5Q1tkFqi59mAMyzHxaHnAeoPx4UWuIPocLOhsQYusMMoY
        QRQwoQPR/ZiDFObUnYt4fJmdSEOhOYftslgZBv8=
X-Google-Smtp-Source: APXvYqyQMbxaKgYkl09zVgHhc++tQKAd86GqYR8eJvjUN3MGHKlzrD5nGhGrxNrSu/Tzn81ZekYwVnTeiuppqQrCAmU=
X-Received: by 2002:a02:13c3:: with SMTP id 186mr33952391jaz.30.1562065808159;
 Tue, 02 Jul 2019 04:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.254.git.gitgitgadget@gmail.com> <pull.254.v2.git.gitgitgadget@gmail.com>
 <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
 <87sgro7lxo.fsf@evledraar.gmail.com>
In-Reply-To: <87sgro7lxo.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Jul 2019 18:09:41 +0700
Message-ID: <CACsJy8Aqdb_-5ituTQMNjacHiJbw4abV=HsH9s6PoAGKyuwdJg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 2, 2019 at 5:47 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Wed, Jun 19 2019, Derrick Stolee via GitGitGadget wrote:
>
> >  core.commitGraph::
> >       If true, then git will read the commit-graph file (if it exists)
> > -     to parse the graph structure of commits. Defaults to false. See
> > +     to parse the graph structure of commits. Defaults to false, unles=
s
> > +     `core.featureAdoptionRate` is at least three. See
> >       linkgit:git-commit-graph[1] for more information.
> >
> >  core.useReplaceRefs::
> > @@ -601,3 +602,21 @@ core.abbrev::
> >       in your repository, which hopefully is enough for
> >       abbreviated object names to stay unique for some time.
> >       The minimum length is 4.
> > +
> > +core.featureAdoptionRate::
> > +     Set an integer value on a scale from 0 to 10 describing your
> > +     desire to adopt new performance features. Defaults to 0. As
> > +     the value increases, features are enabled by changing the
> > +     default values of other config settings. If a config variable
> > +     is specified explicitly, the explicit value will override these
> > +     defaults:
> > ++
> > +If the value is at least 3, then the following defaults are modified.
> > +These represent relatively new features that have existed for multiple
> > +major releases, and present significant performance benefits. They do
> > +not modify the user-facing output of porcelain commands.
> > ++
> > +* `core.commitGraph=3Dtrue` enables reading commit-graph files.
> > ++
> > +* `gc.writeCommitGraph=3Dtrue` eneables writing commit-graph files dur=
ing
>
> I barked up a similar tree in
> https://public-inbox.org/git/CACBZZX5SbYo5fVPtK6LW1FF96nR5591RHHC-5wdjW-f=
mg1R0EQ@mail.gmail.com/
>
> I wonder if you've seen that & what you think about that
> approach. I.e. have a core.version=3D2.28 (or core.version=3D+6) or whate=
ver
> to opt-in to features we'd make default in 2.28. Would that be your
> core.featureAdoptionRate=3D6 (28-28 =3D 6)?
>
> I admit that question is partly rhetorical, because I think it suggests
> how hard it would be for users to reason about this.
>
> The "core.version" idea also sucks, but at least it's bound to our
> advertised version number, so it's obvious if you set it to e.g. +2 what
> feature track you're on, and furthermore when we'd commit to making that
> the default for users who don't set core.version (although we could of
> course always change our minds...). It's also something that mirrors how
> e.g. Perl, C compilers (with --std=3D*) treat this sort of thing.
>
> So I'm all for a facility to have a setting to collectively opt-in to
> new things early. But I think for such a thing we really should a) at
> least in principle commit to making those things the default eventually

Some features may be best enabled for certain setups. This is why I
set configuration variables repo size, worktree size.. instead of just
one number.

> (if they don't suck) b) it needs to be obvious to the user how the
> "rate" relates to git releases.

I see this more like gcc =3DO options. And for those options, the
developers decide what to include. If you know what you want already,
you can just turn specific keys on. Otherwise you count on devs to do
the right things.

It would help if we have something like "gcc -Q -O2 --help=3Doptimizers"
so you can see exactly what you need to turn on to achieve the same
thing. Then you can just set those have the same "per release"
settings.

Which makes me think about a slightly different implementation detail
(which I ignored because I didn't think further about per-release
stuff): since these are basically meta config to change defaults, we
can just implement them as a (builtin, or bundled) config file. The
user can see what are included much easier we have several different
config "profiles" (deep history, large worktree, bleeding-edge...) and
the user can include one or all [1].

[1] it also opens up the opportunity to have a standard (but optional)
set of aliases. But that's a touchy topic.
--=20
Duy
