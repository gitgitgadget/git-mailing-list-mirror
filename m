Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2C7486
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D41kFoUY"
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2912F
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 07:59:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so1757382a12.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698937174; x=1699541974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zs3ZKvUCeGFnP5VyS7r9fBbXCRx9Ib7TmOYZs1Q48Q=;
        b=D41kFoUYzzylT+zO5JaZc7YiqBkb/B/5E7BQVUFl5MIl3ZXv2RNbxH3DdL1UEr9JXV
         ngwNbGe4kIr5kf9aGhIXsbE4CZWIQbyPXdDe+0zaIXPQEICLSJRnNi3Y27C7usbg8TM3
         nQaCMTKnD5wLN9ZghgZyFejYZyQV37O9pxyBgzPLRrIi+RoSiq1UDnkgmXQQ4BIvIVoA
         Ht9S4kfHb7rkBipWxaStaQikPljrr1bWu50Utot/6ETr9tya/I9C92wN3544FaDf9KMo
         WXcsGsbdSo12AOsrM7ufJzTSiVSm+jugH3XCxXvDKXjQ3KOAEWGnDWOthb7lQYkKpfKW
         /Ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698937174; x=1699541974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zs3ZKvUCeGFnP5VyS7r9fBbXCRx9Ib7TmOYZs1Q48Q=;
        b=Gyc4RsEeq0cXoseR9aIPyWQrjYGkNWg8SYRBa22rUgFLyU7Zhnuv73UaINhgDZa4jC
         1P4IAWEomfXvFq7DpMk4y7FNkp/MinajrKc8dIxVQqLlbG/KwKM/F4VkmqmtQgjnXjNW
         YCi0fG7/f36alNEdPPed71He4cPyXWP1VZmz8w+HNSFoMAKCb/DMr8FackSbzuLcBkkN
         bkmh+r72igukhXR/qpf7SiFbEVis5dk6ZSMm9YbHja63UFAEbCMntaWQJ1JTVqBnmE38
         ChcRaH9kVmyraGFVsA179e1TAvcLfDbT/XHlaXdj0x4FzvKp3K5W4cpT0diWWCYDqWL+
         U8dg==
X-Gm-Message-State: AOJu0YyWtO6P6VlmBSnBGkQZGcz5g1SXcDzx0j7WOKQWu7G7uBpSMEIP
	yvze5HTIheTryzkR2tJ5tgIqwWihK5XJ2NIyeUM=
X-Google-Smtp-Source: AGHT+IEVzoCqIQE1q8JOi20bqY1UqYKSQOsuD4ca8UXMsNWEZP856tl1mI44TXgijCHmaWAqcxqyjwQIoQNl8MpNzPw=
X-Received: by 2002:a50:fc15:0:b0:540:2c48:7913 with SMTP id
 i21-20020a50fc15000000b005402c487913mr15912249edr.38.1698937173705; Thu, 02
 Nov 2023 07:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
 <CABPp-BFrVfGHOrBk7g=4TkGxDv=oSqF1FOkhp6WVbxUV-2yveQ@mail.gmail.com>
In-Reply-To: <CABPp-BFrVfGHOrBk7g=4TkGxDv=oSqF1FOkhp6WVbxUV-2yveQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Nov 2023 15:59:21 +0100
Message-ID: <CAP8UFD04PbOLgep3-s-_4_fMbqtrWMR87K1cG-DsKnbyHEBT_w@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 7:02=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:

> On Thu, Oct 26, 2023 at 6:44=E2=80=AFAM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 10 Oct 2023, Christian Couder wrote:
> >
> [...]
> > >      +  /* requirements/overrides for revs */
> > >     -+  revs.reverse =3D 1;
> > >     ++  revs.reverse =3D !revs.reverse;
> > >      +  revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
> > >      +  revs.topo_order =3D 1;
> > >      +  revs.simplify_history =3D 0;
> >
> > This still overrides a couple of command-line options, _silently_. I wo=
uld
> > prefer those three assignments to be moved just before the
> > `setup_revisions()` call.
> >
> > Letting users override these settings may not make much sense, but it
> > makes even less sense to pretend to let them override the settings and
> > then just ignore them without warning. (See also
> > https://en.wikipedia.org/wiki/Principle_of_least_astonishment.)
> >
> > Moving these three assignments before the `setup_revisions()` call woul=
d
> > neatly remedy that.
>
> I agree that warnings or error messages would be better.

Ok, a warning() is emitted now in case an command-line option will be
overridden.

> But if we're talking about something short of that, I'd actually argue
> the opposite of what you do here.  I intentionally moved these
> assignments after setup_revisions(), and in my mind, the purpose in
> doing so was to satisfy the Principle of Least Astonishment.  My
> experience with git-fast-export, where some settings are made before
> calling setup_revisions() and then can be overridden, and then do
> completely hideous things, was much worse to me than just admitting
> the flags are bad given the various assumptions the tool makes.  I
> have some patches sitting around to fix fast-export that I never got
> around to upstreaming, but when it came time to implement git-replay,
> I made sure to fix what I viewed as the bigger problem.

I hope you will be able to upstream such changes.

> [...]
> > >     @@ Documentation/git-replay.txt (new)
> > >      +
> > >      +NAME
> > >      +----
> > >     -+git-replay - Replay commits on a different base, without touchi=
ng working tree
> > >     ++git-replay - Replay commits on a new base, works on bare repos =
too
> > >      +
> > >      +
> > >      +SYNOPSIS
> >
> > As mentioned in
> > https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx.de=
/,
> > I would like the `EXPERIMENTAL` label to be shown prominently here.
> > Probably not only the `SYNOPSIS` as I had originally suggested but also=
 in
> > the `NAME`.

Ok, I have made changes in the v6 I just sent, so that there is
EXPERIMENTAL both in the NAME and SYNOPSIS.

> > Otherwise we may end up with the same situation as with the (from my
> > perspective, failed) `git switch`/`git restore` experiment, where we
> > wanted to explore a better user experience than the overloaded `git
> > checkout` command, only to now be stuck with having to maintain
> > backward-compatibility for `git switch`/`git restore` command-line opti=
ons
> > that were not meant to be set in stone but to be iterated on, instead. =
A
> > real-life demonstration of [Hyrum's Law](hyrumslaw.com/), if you like. =
Or,
> > from a different angle, we re-enacted https://xkcd.com/927/ in a way.

Nit: Hyrum's Law says:

"With a sufficient number of users of an API,
it does not matter what you promise in the contract:
all observable behaviors of your system
will be depended on by somebody."

The doc is part of the contract, which according to this law doesn't
matter. So I don't see why you use this law to suggest a doc change.

> > I'd like to suggest to learn from history and avoid this by tacking on =
a
> > warning label right at the top of the documentation. We may eventually
> > manage to iterate `git replay` to a point where it is totally capable t=
o
> > supersede `git rebase`, by doing everything the latter does, except
> > better, who knows? But we _do_ need the liberty to make sweeping change=
s
> > to this new builtin if we want to have a prayer of doing that. And I fe=
ar
> > that not even mentioning the EXPERIMENTAL nature right at the top of th=
e
> > manual page would just render us into that undesirable corner.
>
> I fully support this.  Absolutely, 100%.

Ok. Note that as I changed the SYNOPSIS, I also had to change the
usage string, so that it matches the SYNOPSIS, otherwise a test would
fail. So there is "EXPERIMENTAL" in the usage string too.
