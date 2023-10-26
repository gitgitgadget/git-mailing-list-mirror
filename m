Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823762E3F2
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="CBvyYP+j"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E750D5C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1698327887; x=1698932687; i=johannes.schindelin@gmx.de;
	bh=psJf8ZtWBhJi5mtC/AAxAlQyQTv9/cLx6qdWNPoeq4Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=CBvyYP+jxKbmbl8PVgq+nv7RY5/4BgFow22mhmNBKfenMxXm33XF019bdNYiqUFG
	 Gs7uCG6KVXVs3ZBoO9oigongfX+3LowUQBlV5kdZ5kmCCaeyOMmCa1V4o4H1mCqi9
	 T45QymIS5EFvyv703b8bmDfcNilssW6D9q6wVTImd+slEOaR35xcJiJFIYMNVmEq+
	 zeS8XA7MbNiMAG3qwzBqePmOglFdpmD5YYLAqObTO1bQvYiBAVbJ2Y6YFd2IzNCtk
	 XgPQqEW38sHhP0OtRvpIcWRXJj0o2EpFBUgAUdXyvKSNSdOEFohsmqnAUSyDC5YB7
	 NbNcfbUWQwDALyNfdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.28]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYXm-1rKqpf3RYU-00m2L4; Thu, 26
 Oct 2023 15:44:45 +0200
Date: Thu, 26 Oct 2023 15:44:44 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
    John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>, 
    Dragan Simic <dsimic@manjaro.org>, Linus Arver <linusa@google.com>
Subject: Re: [PATCH v5 00/14] Introduce new `git replay` command
In-Reply-To: <20231010123847.2777056-1-christian.couder@gmail.com>
Message-ID: <bd872b81-80a9-5e4e-dcb6-faebc9671848@gmx.de>
References: <20230907092521.733746-1-christian.couder@gmail.com> <20231010123847.2777056-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RfF5P5nrL13rOgGvbCeO05fYs96g3lsjjd7gAGyIcR+uW3CB3Kg
 9SCjbylDQ7asoAJlJZAb0QEt2PYcqqMMfP9K+U4ZygL+U0l7nkj8nb/+IZqcWc8gKacYBI+
 gT1fEbSXw7m/AyT5wffMBlmeoIRwjVBvcHAmqkawrc8i3wObt2d9zne8M71KB3Qmhq+Y0q9
 RglTprnVXikKtESMNbS+Q==
UI-OutboundReport: notjunk:1;M01:P0:Fuv+KBveJZo=;xayg8UxoT6bMyYHSpyr7X9Dy12J
 M0SKpqaIdqQ+JQim62ifFBpTqwm7L+ept7t+ZrhZQmAf6fEJfa3H+7GwVeNNcNYg3OwEg6vLq
 mcfNZm8PS15nw8mOBAIP2G+M2pcDxRfy/O27y4DjHfAO0XfgGhXrzzx9+8F/h5Xor9voGGMS4
 WDoTnrt+3k2dnMieaVv0lxk/uGJTaAaVFBYLy1MFIjUklIoCGGvZUX1kQflbomK+GWLe1bJxx
 kgG0dmOXQAPLt9k0pbg90GdKbwuivQBsOhP3810/u/aMLVVERMGUXhzaoMotL5UhwbVre78qr
 3e0EiZW4qAZhDFDVvC10n6dZ2/kAY701gWdEil6U8Tq14TWUPUFJX8EQZ+ShLj+SAtzGWFcOg
 fV/t0EvTsl8gHfwswQqSP9VJjXTIOsSXzrWaTz/jEDKRFu5xzl3J47hvijqF6HtnBhvrbD5MI
 4ucDoRFK2+1yEKPc3RN0NfrE/udKPcrzUnVC+7z/31wHsmwe4LhUm3fTRS3ckdESoJP0u3TlE
 6kcaGmUmbC4YfVsgsmGDce1JMBFB/zQriPVO/PXgRL+jKmyWOxA5itP6QpCr9LumB3tfZlGLf
 a2kLXLegHOWSg6QWZFrceQznWAyR7tRxFqCNZi0JmOMoJXhBSWYbiwJ5wneKCNeStc3OeWWD+
 ZBpPTXc2Ik/4QJKZho09qPpi89VOfkSbSA4NH33K4b4INaVWbXpVnltGdASgJKzhoaAuzkF0y
 t3DXb/z/cK61s5LwrKCPq0sKrWteWXTcEAhWA2wEIMhAGmS2sSYYzAWwJR+yaLtaMH2IpVmnz
 hX
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, 10 Oct 2023, Christian Couder wrote:

>  6:  ec51351889 !  6:  37d545d5d6 replay: don't simplify history
>     @@ Metadata
>      Author: Elijah Newren <newren@gmail.com>
>
>       ## Commit message ##
>     -    replay: don't simplify history
>     +    replay: change rev walking options
>
>          Let's set the rev walking options we need after calling
>     -    setup_revisions() instead of before. This makes it clearer whic=
h options
>     -    we need.
>     +    setup_revisions() instead of before. This enforces options we a=
lways
>     +    want.
>     +
>     +    We want the command to work from older commits to newer ones by=
 default,
>     +    but we are Ok with letting users reverse that, using --reverse,=
 if that's
>     +    what they really want.
>
>          Also we don't want history simplification, as we want to deal w=
ith all
>          the commits in the affected range.
>
>     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>          Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
>          Signed-off-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, con=
st char *prefix
>         }
>
>      +  /* requirements/overrides for revs */
>     -+  revs.reverse =3D 1;
>     ++  revs.reverse =3D !revs.reverse;
>      +  revs.sort_order =3D REV_SORT_IN_GRAPH_ORDER;
>      +  revs.topo_order =3D 1;
>      +  revs.simplify_history =3D 0;

This still overrides a couple of command-line options, _silently_. I would
prefer those three assignments to be moved just before the
`setup_revisions()` call.

Letting users override these settings may not make much sense, but it
makes even less sense to pretend to let them override the settings and
then just ignore them without warning. (See also
https://en.wikipedia.org/wiki/Principle_of_least_astonishment.)

Moving these three assignments before the `setup_revisions()` call would
neatly remedy that.

>  7:  cd4ed07d2d =3D  7:  2943f08926 replay: add an important FIXME comme=
nt about gpg signing
>  8:  e45a55917c =3D  8:  f81962ba41 replay: remove progress and info out=
put
>  9:  0587a76cbb =3D  9:  236747497e replay: remove HEAD related sanity c=
heck
> 10:  d10368e87a =3D 10:  3374d5be23 replay: make it a minimal server sid=
e command
> 11:  4e09572c43 ! 11:  197d076a93 replay: use standard revision ranges
>     @@ Commit message
>          way as many other Git commands. This makes its interface more
>          standard and more flexible.
>
>     +    This also enables many revision related options accepted and
>     +    eaten by setup_revisions(). If the replay command was a high le=
vel
>     +    one or had a high level mode, it would make sense to restrict s=
ome
>     +    of the possible options, like those generating non-contiguous
>     +    history, as they could be confusing for most users.
>     +
>          Also as the interface of the command is now mostly finalized,
>          we can add some documentation as well as testcases to make sure
>          the command will continue to work as designed in the future.
>
>     +    We only document the rev-list related options among all the
>     +    revision related options that are now accepted, as the rev-list
>     +    related ones are probably the most useful for now.
>     +
>     +    Helped-by: Dragan Simic <dsimic@manjaro.org>
>     +    Helped-by: Linus Arver <linusa@google.com>
>          Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
>          Signed-off-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>     @@ Documentation/git-replay.txt (new)
>      +
>      +NAME
>      +----
>     -+git-replay - Replay commits on a different base, without touching =
working tree
>     ++git-replay - Replay commits on a new base, works on bare repos too
>      +
>      +
>      +SYNOPSIS

As mentioned in
https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx.de/,
I would like the `EXPERIMENTAL` label to be shown prominently here.
Probably not only the `SYNOPSIS` as I had originally suggested but also in
the `NAME`.

Otherwise we may end up with the same situation as with the (from my
perspective, failed) `git switch`/`git restore` experiment, where we
wanted to explore a better user experience than the overloaded `git
checkout` command, only to now be stuck with having to maintain
backward-compatibility for `git switch`/`git restore` command-line options
that were not meant to be set in stone but to be iterated on, instead. A
real-life demonstration of [Hyrum's Law](hyrumslaw.com/), if you like. Or,
from a different angle, we re-enacted https://xkcd.com/927/ in a way.

I'd like to suggest to learn from history and avoid this by tacking on a
warning label right at the top of the documentation. We may eventually
manage to iterate `git replay` to a point where it is totally capable to
supersede `git rebase`, by doing everything the latter does, except
better, who knows? But we _do_ need the liberty to make sweeping changes
to this new builtin if we want to have a prayer of doing that. And I fear
that not even mentioning the EXPERIMENTAL nature right at the top of the
manual page would just render us into that undesirable corner.

In addition, I am still a bit uneasy with introducing both the manual page
and the test script in this commit (see my comments in
https://lore.kernel.org/git/03460733-0219-c648-5757-db1958f8042e@gmx.de/).
It would be better to uphold our high standard and introduce scaffolds for
both files in the first commit, then populate the file contents
incrementally in the same the patches that introduce the corresponding
options/features/changes.

The rest of the interdiff consists mostly of context changes intermixed
with a couple of changes that I like.

Ciao,
Johannes
