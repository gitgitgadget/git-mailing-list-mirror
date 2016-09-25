Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED841F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034332AbcIYSQo (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 14:16:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:58359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965935AbcIYSQn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 14:16:43 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mb7pT-1bVKcC3N4F-00Kgb0; Sun, 25 Sep 2016 20:16:36
 +0200
Date:   Sun, 25 Sep 2016 20:16:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Haller <lists@haller-berlin.de>
Subject: Re: Git garden shears, was Re: [PATCH 13/22] sequencer: remember
 the onelines when parsing the todo file
In-Reply-To: <f7fe3f15-664e-61a5-6101-30ed4946c107@gmail.com>
Message-ID: <alpine.DEB.2.20.1609251950300.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de> <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com> <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609011052260.129229@virtualbox> <xmqqeg53wj7a.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1609091708480.129229@virtualbox> <5b707a0d-6c10-abb5-3213-d13490e9b9de@gmail.com> <alpine.DEB.2.20.1609111027330.129229@virtualbox>
 <f7fe3f15-664e-61a5-6101-30ed4946c107@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-55965509-1474827396=:129229"
X-Provags-ID: V03:K0:CPLKxHozS0lDc1qOw3OlSkMXVb9FCjKSQWPldI0EhZv8tY1JR0X
 x5oBh8UVE9z8gJdwRC3fjhGnO7OA1/r6RXFPqAVuV8dz59H0jIGWcMXdOjSzB1dx7BNcX6Z
 xH+0R0lE5wxZfyQjsDIQBUlSD4rzoa78eUCOOIhOE88Zk4WdBZzThkSp1aDRJU4JPoB9hdO
 5sPNJz8DN4XRkPa3d23Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GA2nJtMXOSc=:5AP6rFTxbqDop3R0H2s45p
 OG7T4ReSRrTbEfzlDKiaYqiOK0+Ht4axM0uvpKB61E4/tsK2248vgPFhdD3cMOJYJmcUOlFN1
 mw+Yl7ohr9Mh9UxLgGTujbxJfxFWtlgZm1GKzNuqoz+WfqhUuAdOli/sWBVYfvGTH9GbowIG4
 oSRRH756HLOFfchvGwCsRnYBBo3CJXu0e17uJjkFG9ikmwnYyfZIWI3Li8CvSgfxmqWQR2V8a
 X7DncTBY9qfRdqTxLvPHLtU80cN9zWfn/MfLrt2Kg5F+cBgIL8wliXPcuycRa3PEgXy/go1rj
 hCYj6vB9pSZSXnBK5YLVRP38Yir8HEE9f9xqdXU3S7vUusXXPkSUyNQtPwUJANfBF7v4nzDjV
 6uNBW7AzZM2Zo/62wYyKJ1xvpVh/TFdPR4cGse/fg2PJXW4Qvc5ADOuZAgFrzp89uZ9j0LWSP
 pq4/z9+NYUYFguVkq5OiqjvbUgJosXmU4jvyTwiZemzo98kuf9NBcygGjQo16mCtTB+nsrvCW
 +fFdoXN5xbit/bfCdncOjNdxw/OS4RKp5/mo7J14UYW0rRMDHaAmBRcqO0Syq/ngPLDXgjctu
 KgquBICC7xQ99xaOKbQ2KpCTXDGbSx52abaMu1gLWS7s0UZPtV6yEmEM4rWwDE4Augboyc7D7
 OTSu652z0EArOBMaqQh79TAYfrMNp4b2oD4aYhgs72bxXe0n6OPBQN9kW35YQZCJaVFIfquur
 LGHahAuTUNLlE9ULgzRil2fhoSif6fYFuG5P9Imz2EKkuN68RXOvwjM3V3gpDFQ8GDX1PkB8H
 mIz4UQ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-55965509-1474827396=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 21 Sep 2016, Jakub Nar=C4=99bski wrote:

> W dniu 11.09.2016 o 10:33, Johannes Schindelin napisa=C5=82:=20
> > On Fri, 9 Sep 2016, Jakub Nar=C4=99bski wrote:
> [...]
>=20
> >> When preserving merges, there are (as far as I understand it), two
> >> problems:
> >>  - what it means to preserve changes (which change to pick,
> >>    that is what is the mainline changes rebase is re-applying)
> >>  - what are parents of the merge commit (at least one parent
> >>    would be usually rewritten)
> >>
> >> Maybe the internal (and perhaps also user-visible) representation
> >> of merge in instruction sheet could use the notation of filter-branch,
> >> that is 'map(<sha-1>)'... it could also imply the mainline.
> >>
> >> That is the instruction in the internal instruction sheet could
> >> look like this:
> >>
> >>   merge -m 1 map(2fd4e1c6...) da39a3ee... \t Merge 'foo' into master =
=20
> >>
> >>
> >> Note that it has nothing to do with this series!
> >=20
> > Right. But I did solve that already. In the Git garden shears [*1*]
> > (essentially my New And Improved attempt at recreating branch structure=
s
> > while rebasing), I generate and process scripts like this:
> >=20
> > =09mark onto
> >=20
> > =09# Branch: super-cool-feature
> > =09rewind onto
> > =09pick 00001 feature
> > =09pick 00002 documentation
> > =09mark super-cool-feature
> >=20
> > =09# Branch: typo-fix
> > =09rewind onto
> > =09pick 0000a fix a tyop
>=20
> There probably should be there
>=20
>  =09mark typo-fix

Correct. Sorry for the omission.

> > =09rewind onto
> > =09merge -C cafebabe super-cool-feature
> > =09merge -C babecafe typo-fix
> >=20
> > =09cleanup super-cool-feature typo-fix
> >=20
> > Of course this will change a little, still, once I get around to implem=
ent
> > this on top of the rebase--helper.
>=20
> Do I understand it correctly that it is user-visible instruction sheet, a=
nd
> not the internal instruction sheet for sequencer?  This looks very nice
> and is well readable.

It is intended as that.

Currently I need a little trickery to make this work, as rebase -i does
not understand rewind nor merge. The trick is to re-use the shears.sh
script as editor that then populates the edit script, calls the real
editor, and then installs a temporary alias that gets called for all
custom commands via exec (turning e.g. "rewind abc" into "exec git .r
rewind abc").

The temporary alias point back to the shears script, too, of course.

In the end, I hope to teach the sequencer a variant of this dialect, as
well as the trick to generate such edit scripts.

> I guess that it needs to be pre-populated by Git based on topology of the
> branch being rebased.

Yes. The shears.sh script is in charge of that, and it has to perform a
couple of Git calls to do so.

> As I see, there are three basic topologies of non-linear branch to be
> rebased; all else is combination of thereof, or derivative:
>=20
> 1. Merge commit without branching point, that is we need to go
>    from the following situation
>=20
>    *---*---*---#---o---o---o        <-- old base
>                \\
>                 \\=3Da=3D=3D=3Db=3D=3D=3DM=3D=3D=3Dc    <-- branch being =
rebased
>                           /
>          ...---x---x---x-/          <-- side branch
>=20
>   to the following:
>=20
>    *---*---*---#---o---o---o       =20
>                             \
>                              \-a'--b'--M'--c'=20
>                                       /
>          ...---x---x---x-------------/         =20

In other words: rebasing a merge commit merging non-rebased commits.

This is not yet supported by the shears script, as it would require logic
that is not only slow in shell script, but also convoluted. IOW this
feature waits for the sequencer to know how to run regular rebase -i
already.

> I think this case is the only one supported by `--preserve-merges`,
> but I may be mistaken - I never had the need to use this feature IRL.

No, -p would handle merges of non-rebased commits as well as merges of
to-be-rebased commits.

> 2. Branching point without accompanying merge commit, or in other words
>    rebasing many branches tied together; a shrub if you will.  That is,
>    we want to go from the following situation:
>=20
>    *---*---*---#---o---o---o           <-- old base
>                \
>                 \--a---b---c           <-- branch being rebased
>                         \
>                          \-1           <-- dependent branch
>=20
>    to the following one:
>=20
>    *---*---*---#---o---o---o
>                             \
>                              \--a'--b'--c'
>                                      \
>                                       \-1'

This is outside the scope of rebase -i (and of the shears), as you are
talking about *parallel* rebases. I don't do that, nor does rebase -i,
rebase -p nor the shears.

> I don't think Git supports something like that out of the box, but it
> is not hard to create something like that "by hand". It is not much
> of a problem... unless you forget to rebase the second dependent branch.

The safer thing to do, of course, is to merge all those tips back into the
branch you then rebase in one go.

> 3. Branching point with merge point, that is subbranch created and
>    merged - an "eye" (it is not a loop in DAG):
>=20
>    *---*---*---#---o---o---o             <-- old base
>                \
>                 \--a---b---c---M---d     <-- branch being rebased
>                     \         /
>                      \-1---2-/         [ <-- possibly a branch ]
>=20
>    All edges are directed edges, with arrows pointing from right to
>    left; that is  *---*  is really  *<---*
>=20
>    The expected result is:
>=20
>    *---*---*---#---o---o---o
>                             \
>                              \--a'--b'--c'--M'--d'
>                                  \         /
>                                   \-1'--2'/
>=20
> I guess that is the main purpose of your git-garden-shears script,
> isn't it?

Yes.

> > For example, I am not so hot about the "merge -C ..." syntax. I'll
> > probably split that into a "remerge <SHA-1> <mark>" and a new "merge
> > <mark>" command (the latter asking interactively for the merge commit
> > message).
>=20
> There is also an additional complication in that merge commit message
> may be *partially* automatically generated. First there is the subject
> generated by 'git merge' ("Merge branch 'foo'") or 'git pull <URL>'.
> It might have been translated, or extended.  Second there is a place
> for branch cover letter. Third, subject to merge.log / merge.summary
> there is a shortlog.

True. The current shears will simply use the original commit message
verbatim. And I think it would be wise to keep this behaviour until the
sequencer knows how to recreate merges.

Once that happens, I cordially invite you to implement any merge commit
message munging mode your heart desires, on top of the straight port of
the shears.

> From those shortlog should be surely updated to correspond to the
> post-rebase state.  The first line could be used to pre-populate
> mark lines, but during merge it should be, I think, updated to the
> new name of internal branch if it was changed.

Surely. Or not so surely. Too unsurely, for sure, to be discussed without
a dedicated patch series submitted by a dedicated person requiring that
feature.

> As to 'merge -C <sha1> <marker>' vs 'remerge <sha1> <marker>',
> I don't have specified opinion.  It would be nice to have one
> character shortcuts for insn sheet instructions, to which
> 'm -C <sha1> <marker>' is more amendable...=20

I am pretty certain that you will find yourself disagreeing with that
statement once you used the shears for a while.

I use it for over a year now, and I *never* had to type any "merge -C"
command (i.e. the command I would call "remerge"). The reason is that you
simply move those generated lines, and that there is no scenario I
encountered where you will want to insert a merge manually: you simply
merge all you want *before* or *after* rebasing.

As to "merge <marker>": those are quite common, in particular when
splitting patch series into parts.

> > No :1 or some such. That's machine readable. But it's utter nonsense fo=
r
> > user-facing UIs.
>=20
> Of course. It's all right for machine-facing instructions, like the
> 'todo' file for the sequencer, or for git-fast-import stream...

The 'todo' file for the sequencer *should* be human-friendly. There is no
reason not to make it so, in particular when you can simply reuse the refs
machinery for marks, and when it facilitates debugging (and I can testify
to that: it does, oh yeah, it does...).

Ciao,
Dscho
--8323329-55965509-1474827396=:129229--
