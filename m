Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B16C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiAGTym (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:54:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:60071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbiAGTyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641585274;
        bh=QjTHVJasx4JyAi6Gdx/4tgZq7rsCZGhumjYB2sGf9NY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Rvx38UsDPom3cBNzM8F1fZ5m0t/9cpiM0Pn7VedWwohELQoy2bAQPjQ0XBGrEgU27
         3skbGJGspDsi0k/iecrBWET7ncPXKFysBJkiHtxYtwrafQu5z68Cz4uVHkcoHtDq5F
         SxahlMzoe1AcVOjj/1MzkZd9bNuevuoafB5+WVH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.133.218] ([89.1.215.56]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUowb-1mxVEp1j73-00QjnZ; Fri, 07
 Jan 2022 20:54:34 +0100
Date:   Fri, 7 Jan 2022 20:54:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
In-Reply-To: <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201072044120.339@tvgsbejvaqbjf.bet>
References: <20220105163324.73369-1-chriscool@tuxfamily.org> <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com> <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-994332659-1641585272=:339"
X-Provags-ID: V03:K1:lEFlwd5/PIxw6ibi1pjgSoXj8VkVZrOd9Pcq++HU0zJB2rll0XH
 ioe6LcYEgGuNQz23MDcvFsiBQKmWm1WnrzcqgSX1y2ipBEub5JQwNohasEh9TFBIJBUnfNi
 UoGz/Gvz/R0gVJignvWOK+qlXDyicbSyO0MuFEwyw4y+nT3bUTfxCqlvYOPOkBu39JAogC9
 4VSJ/vI8l8O3cPyeDnWJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xRTmZeXVjj8=:FUgocqFKdQUKAbOvM+aD60
 /GWsHcH4sOnosaLeV7j1rYmBcwpF4bTSGeLYAiUFYKzrOY8/gsGy5NzySIevU5iwQ+Pyq68Jl
 p2QK4pDHC5I8PX2w02+jTM8nLLJcsK/gw/mIFjQ+n1DELxUtk5hFtertXi3PdwUQahpy3jT9K
 9oXbvxWJKsBIqY2fWXNOC0j6mC5C8D7X77Bye5GevbZLWYYh2VA2d+nM8xX7roK7je7sLxjGQ
 qf5sL5jklHNyW+rKN3XeYMHgGpofkf2GKz1vQo8iyVEXy+TgflxMpcjOX1XzXHNYeyZftqNxI
 cTRgZ9bz1ve00AIZL37IQiRtanttUMQU3LQDKiwkaArHceaHiZQnW9uolXtiYXPxvpqIP/TwF
 Dilldpwgd/BAPjRF45xcH2uu1aAKjG0V4SuDudzwzLvWJ1pgsBMQJalSSfb5vYLsX4OeUZ6+a
 LIzGvBlrgaMZ3fbnpf+e5MrlUnYPrMuF+1XVhVbhlR+5qht1xMKzr1g99ZHsnicLXAPy+BJC5
 4+hIRsxu+G9m8fCLXSySfIF1rqV7aDRcdsXeu7bYQc2j2G5FsVRcYQrV/1bfE8TPepj44a7nc
 Ut0A9IbnePeJcucqWoRz73gpOeQObe553TcJaODmAyGv4UAQqMHw3yv48wjns4n1+yflV/S+r
 GdUXsvhYlVmQITBBMF2TicaROh9lMN01XP0PD1WTophUXkClyPbg/fOqVtac+ftaU3zgO0uQT
 JZ7Kx2+C+sDmlNcTASmftMlkMQnTsGOLjiIjewEZyV93vf3qBXTDZZSW3QQngf0Pg9cannG83
 WdMVhv+qdAjT8Pg5I6j+eSX/P7CKxGec5ExtmkbgQQZKCvBjPPxwIFkfYaLZTArU53BjCgBr6
 wtgaVhzHf+cR0sDpwDsOaLcctaIuLIsGqdw452m+Mzjza6g7R07dKAigdvGf0NqP1Em85zzhf
 9MPqPvQTGtbN5+1Jh1ehGsNEOoCrHU1jKg+DGTRVNXe8tFZRb6/y70+DXlaGNvV8+h+6WsxZb
 u/U+aamXs1Yd0AwUZlm8+BXKTwnrS4o1QZoR2yqphzvJ3AQVZvgSuUFiWu0VOwGo59l23hgn9
 vLAhc9Y2ghN6hs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-994332659-1641585272=:339
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Fri, 7 Jan 2022, Christian Couder wrote:

> On Wed, Jan 5, 2022 at 5:54 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, Jan 5, 2022 at 8:33 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
>
> > > To move forward on this, this small RFC patch series introduces a
> > > new `git merge-tree-ort` command with the following design:
> >
> > Slightly dislike the command name.
>
> I am ok with changing the command name.

Or just going with `merge-tree`?

That command name has the distinct advantage of _already_ being used by
Git. So there is no chance for users to have a `git-merge-tree` script
lying around that all of a sudden would stop working because a superseding
built-in using the same name is introduced.

That is a distinct advantage of using the existing command for the new
code flow, even if the command name could be interpreted as misleading. Of
course, the name could also be construed to be on point: it merges, and it
produces a tree, hence "merge-tree".

> > >   - the diff API, actually diff_tree_oid() is called 3 times: once f=
or
> > >     the diff versus branch1 ("ours"), once for the diff versus branc=
h2
> > >     ("theirs"), and once for the diff versus the base.
> >
> > Why?  That seems to be a performance penalty for anyone that doesn't
> > want/need the diffs, and since we return a tree, a caller can go and
> > get whatever diffs they like.
>
> I say somewhere else that I am planning to add options to disable this
> or parts of this diff output.

Well, now you got me really curious. Since you are listed as part of
GitLab (https://about.gitlab.com/company/team/#chriscool), I assume that
you are pretty familiar with how merges are done on GitLab's server side,
and plan on experimenting with your own work to use `merge-ort` on
GitLab's servers.

Which makes me wonder where that idea comes from to use the diff API?

What operations does GitLab need from that Git command, which code flows
need to be supported (and what inputs/outputs are there)?

> I think it's still interesting for the command to be able to output
> diffs, especially diffs of conflicting parts. In [2] =C3=86var said:
>
> =3D> I.e. I'm not the first or last to have (not for anything serious)
> =3D> implement a dry-run bare-repo merge with something like:
> =3D>
> =3D>     git merge-tree origin/master git-for-windows/main origin/seen >=
diff
> =3D>     # Better regex needed, but basically this
> =3D>     grep "^\+<<<<<<< \.our$" diff && conflict=3Dt
>
> Also `git merge-tree` currently outputs diffs, so I thought it would
> be sad if the new command couldn't do it.
>
> [2] https://lore.kernel.org/git/211109.861r3qdpt8.gmgdl@evledraar.gmail.=
com/

But `git merge-tree` was only meant as a proof-of-concept, intended to
entice other developers to turn it into something useful. As it took
_this_ long, we can safely assume that the user interface of `merge-tree`
left a bit of a room for improvement. Wouldn't you agree?

> Also I thought that you might not be interested in this anymore as you
> didn't reply to [1] and [2] where =C3=86var and I both said that we were
> interested in your opinion on a git merge-tree on steroids.

Elijah stated at the time that he was scarce on time for Git.

But back to the topic: have you played with using `merge-ort` in GitLab
already? What were the needs you saw that would be required of the Git
command, what flows would it have to support?

Ciao,
Johannes

--8323328-994332659-1641585272=:339--
