Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278561F404
	for <e@80x24.org>; Tue, 27 Feb 2018 23:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeB0X11 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 18:27:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:59957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751791AbeB0X10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 18:27:26 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lg1QN-1eOKax1yFn-00pZHG; Wed, 28
 Feb 2018 00:27:20 +0100
Date:   Wed, 28 Feb 2018 00:27:19 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
In-Reply-To: <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1047807922-1519774040=:56"
X-Provags-ID: V03:K0:+wyr9PuOLRBPD8spiopzUSF/+jaduUp68cnVZwbJJIK/dnGmgPy
 537WfUb3Jn1FkCUfmonw7NrXXpVC0i5Vn2ztn6TF0ZME42X0wnlJIHM8w0lADywKCA+ZyNQ
 YpWa/0OgNPqACcAK71opWEoUFUZ2KDSGZmeGhNlhcX6Bpxt4KS8b+GQ5ixXj3O+HTgYQoxJ
 Xokif/gsP90N7Vggq9D2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FEvvq+n44L8=:DlvGCij+DPGsIenjrftz86
 EafKW57jWfnEdQKmEVmVf5QKKUyCYK6qL0Ozg2hq4F4X2y98QBrM0eHESDgGjfE9AzPD647bv
 MjRqIP0qxjWMhm9/V8Odf1Yw2K4WglkiBT6qnWamEFgJEjUq+pllOhvV3JR60oCmil+RRmjux
 6l/gwIvONM4iUuZ/JdX29i09DG2NlDBofYHPoRKuVC9UUug2ZrQjUiQGWnolFG1bjj36t2QZV
 EtvNtCXN9tE/tFZ1dr3znsOEaS2FmVPkAnqzMEoB1DzIHk72dV87cU0zE5pqPXjE5sHjwdQh0
 7PgFcuhRhs9Cmzq44vyyG48LZpBbUe0RpP6ojNU03A/f6HwNY3ZkP10tda3gdDpAGN0DMtioW
 8KbkIMiQgPWjSmGccFs232gqMggMOSdfHbezd5hyMXweeVIQ9XfW1ma921ijH7R5vCKGoduP6
 ecU4EzHz7mAOoWGCHDYrWZwQa9gmEWAulkBvihlgw58H9Jp33B3WJ9cdmmMeqAxqHInOvqAFt
 ESGJgNeK8o1Ntdm5j6LWkSrQxy18lCmYc2zw0CDrMl2OjwObD7DIU5NVC12gZRuf+4TS/x43c
 3a8Tutto5oCYvxbAEnuIU8fn2z04LQBmpfgJTCYd3V0nI2LIFoQD2g349aVQXzccJBtaNoyr/
 0uHOvvrO26htn2fDDGdgpdyET2pAy9W8jSG7pGLo5xyJczwxgiby/PXV2BtSJgQeUJA3W5OQy
 PFFSnYpEolFsXwsa6j0nXdabfwralB/2MiAQAfjNGDC8luNjU8ZHJcfJ7fJ693DRCzJClLLbq
 kK7CDlnH7pnNzLbGVLmJVE1YRphPzmVuyS79L5uPeWpy8pczbErp0Y2L3t6xxM0rjqjDgzr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1047807922-1519774040=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Buga,

thank you for making this a lot more understandable to this thick
developer.

On Tue, 27 Feb 2018, Igor Djordjevic wrote:

> On 27/02/2018 19:55, Igor Djordjevic wrote:
> >=20
> > It would be more along the lines of "(1) rebase old merge commit parent=
s,=20
> > (2) generate separate diff between old merge commit and each of its=20
> > parents, (3) apply each diff to their corresponding newly rebased=20
> > parent respectively (as a temporary commit, one per rebased parent),=20
> > (4) merge these temporary commits to generate 'rebased' merge commit,=
=20
> > (5) drop temporary commits, recording their parents as parents of=20
> > 'rebased' merge commit (instead of dropped temporary commits)".
> >=20
> > Implementation wise, steps (2) and (3) could also be done by simply=20
> > copying old merge commit _snapshot_ on top of each of its parents as=20
> > a temporary, non-merge commit, then rebasing (cherry-picking) these=20
> > temporary commits on top of their rebased parent commits to produce=20
> > rebased temporary commits (to be merged for generating 'rebased'=20
> > merge commit in step (4)).
>=20
> For those still tagging along (and still confused), here are some=20
> diagrams (following what Sergey originally described). Note that=20
> actual implementation might be even simpler, but I believe it`s a bit=20
> easier to understand like this, using some "temporary" commits approach.
>=20
> Here`s our starting position:
>=20
> (0) ---X1---o---o---o---o---o---X2 (master)
>        |\
>        | A1---A2---A3
>        |             \
>        |              M (topic)
>        |             /
>        \-B1---B2---B3
>=20
>=20
> Now, we want to rebase merge commit M from X1 onto X2. First, rebase
> merge commit parents as usual:
>=20
> (1) ---X1---o---o---o---o---o---X2
>        |\                       |\
>        | A1---A2---A3           | A1'--A2'--A3'
>        |             \          |
>        |              M         |
>        |             /          |
>        \-B1---B2---B3           \-B1'--B2'--B3'
>=20
>=20
> That was commonly understandable part.

Good. Let's assume that I want to do this interactively (because let's
face it, rebase is boring unless we shake up things a little). And let's
assume that A1 is my only change to the README, and that I realized that
it was incorrect and I do not want the world to see it, so I drop A1'.

Let's see how things go from here:

> Now, for "rebasing" the merge commit (keeping possible amendments), we
> do some extra work. First, we make two temporary commits on top of old
> merge parents, by using exact tree (snapshot) of commit M:
>=20
> (2) ---X1---o---o---o---o---o---X2
>        |\                       |\
>        | A1---A2---A3---U1      | A1'--A2'--A3'
>        |             \          |
>        |              M         |
>        |             /          |
>        \-B1---B2---B3---U2      \-B1'--B2'--B3'

Okay, everything would still be the same except that I still have dropped
A1'.

> So here, in terms of _snapshots_ (trees, not diffs), U1 =3D U2 =3D M.
>=20
> Now, we rebase these temporary commits, too:
>=20
> (3) ---X1---o---o---o---o---o---X2
>        |\                       |\
>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>        |             \          |
>        |              M         |
>        |             /          |
>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'

I still want to drop A1 in this rebase, so A1' is still missing.

And now it starts to get interesting.

The diff between A3 and U1 does not touch the README, of course, as I said
that only A1 changed the README.  But the diff between B3 and U2 does
change the README, thanks to M containing A1 change.

Therefore, the diff between B3' and U2' will also have this change to the
README. That change that I wanted to drop.

> As a next step, we merge these temporary commits to produce our
> "rebased" merged commit M:
>=20
> (4) ---X1---o---o---o---o---o---X2
>        |\                       |\
>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>        |             \          |                  \
>        |              M         |                   M'
>        |             /          |                  /
>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'

And here, thanks to B3'..U2' changing the README, M' will also have that
change that I wanted to see dropped.

Note that A1' is still dropped in my example.

> Finally, we drop temporary commits, and record rebased commits A3'=20
> and B3' as our "rebased" merge commit parents instead (merge commit=20
> M' keeps its same tree/snapshot state, just gets parents replaced):
>=20
> (5) ---X1---o---o---o---o---o---X2
>        |\                       |\
>        | A1---A2---A3---U1      | A1'--A2'--A3'
>        |             \          |             \
>        |              M         |              M'
>        |             /          |             /
>        \-B1---B2---B3---U2      \-B1'--B2'--B3'

Now, thanks to U2' being dropped (and A1' *still* being dropped), the
change in the README that is still in M' is really only in M'. No other
rebased commit has it. That makes it look as if M' introduced this change
in addition to the changes that were merged between the merge parents.

This is what an "evil merge" is: it does more than just combine the
previously diverging branches. It introduces another change that was not
in any non-merge commits before it.

Sometimes, such an "evil merge" is necessary. For example, when master
converted a couple more `hash` references to `oid` including, say, in a
function signature, and the merged branch contains a new caller using that
old function signature: in this case, the merge commit must convert those
`hash` references to `oid` references, or the code won't compile.

In my example, where I dropped A1' specifically so that that embarrasingly
incorrect change to the README would not be seen by the world, though, the
evil merge would be truly evil: it would show said change to the world.
The exact opposite of what I wanted.

> And that`s it, our merge commit M has been "rebased" to M' :)
>=20
> (6) ---X1---o---o---o---o---o---X2 (master)
>                                 |\
>                                 | A1'--A2'--A3'
>                                 |             \
>                                 |              M' (topic)
>                                 |             /
>                                 \-B1'--B2'--B3'
>=20
>=20
> Important thing to note here is that in our step (3) above, still in=20
> terms of trees/snapshots (not diffs), U1' could still be equal to=20
> U2', produced merge commit M' tree thus being equal to both of them=20
> as well (merge commit introducing no changes to either of its=20
> parents, originally described by Sergey as "angel merge").
>=20
> But it doesn`t have to be so - if any of the rebased commits A1 to A3=20
> or B1 to B3 was dropped or modified (or extra commits added, even),=20
> that would influence the trees (snapshots) produced after rebasing U1=20
> and U2 to U1' and U2', final merge M' reflecting all these changes as=20
> well, besides keeping original merge commit M amendments (preserving=20
> "evil merge").

Sadly, it would also introduce evil merges in certain circumstances, as I
demonstrated above.

> Well, that`s some theory, now to hopefully confirm/test/polish all=20
> this... or trash it, if flawed beyond correction :P

It would have been nice to have such a simple solution ;-)

So the most obvious way to try to fix this design would be to recreate the
original merge first, even with merge conflicts, and then trying to use the
diff between that and the actual original merge commit. In your example,
this would look like that:

---X1---o---o---o---o---o---X2
   |\                       |\
   | A1---A2---A3--         | A1'--A2'--A3'
   |             \ \        |
   |              M M=C2=B2      |
   |             / /        |
   \-B1---B2---B3--         \-B1'--B2'--B3'

Note that M=C2=B2 would be generated somewhat like this: `git checkout
A3; git merge -s recursive B3; git add -u; git commit`. If there are merge
conflicts, then the result would include the conflict markers.

Now we would generate something similar to those U1/U2 commits: a
single-parent commit R that reflects the diff between M and M=C2=B2:

---X1---o---o---o---o---o---X2
   |\                       |\
   | A1---A2---A3           | A1'--A2'--A3'
   |             \          |
   |              M---R     |
   |             /          |
   \-B1---B2---B3           \-B1'--B2'--B3'

Note that the tree of R is identical to the tree of M=C2=B2. We can now
proceed to generate the merge between A3' and B3' (possibly with merge
conflicts) and then reverting R on top:

---X1---o---o---o---o---o---X2
   |\                       |\
   | A1---A2---A3           | A1'--A2'--A3'
   |             \          |              \
   |              M---R     |               M'---M=C2=B3
   |             /          |              /
   \-B1---B2---B3           \-B1'--B2'--B3'

Of course, as before, the idea would be to squash the reverted
changes into the final merge commit.

Now, would this work?

I doubt it, for at least two reasons:

- if there are merge conflicts between A3/B3 and between A3'/B3', those
  merge conflicts will very likely look very different, and the conflicts
  when reverting R will contain those nested conflicts: utterly confusing.
  And those conflicts will look even more confusing if a patch (such as
  A1') was dropped during an interactive rebase.

- One of the promises was that the new way would also handle merge
  strategies other than recursive. What would happen, for example, if M
  was generated using `-s ours` (read: dropping the B* patches' changes)
  and if B1 had been cherry-picked into the history between X1..X2?

  Reverting R would obviously revert those B1 changes, even if B1' would
  obviously not even be part of the rebased history!

Yes, I agree that this `-s ours` example is quite concocted, but the point
of this example is not how plausible it is, but how easy it is to come up
with a scenario where this design to "rebase merge commits" results in
very, very unwanted behavior.

But maybe I missed something obvious, and the design can still be fixed
somehow?

Ciao,
Johannes
--8323329-1047807922-1519774040=:56--
