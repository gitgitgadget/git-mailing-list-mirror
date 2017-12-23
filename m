Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B121F404
	for <e@80x24.org>; Sat, 23 Dec 2017 22:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdLWWai (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 17:30:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:52124 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdLWWah (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 17:30:37 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.73]) by
 mail.gmx.com (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M3zT0-1fIv043I6U-00rVeR; Sat, 23 Dec 2017 23:30:34 +0100
Date:   Sat, 23 Dec 2017 23:30:33 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Carl Baldwin <carl@ecbaldwin.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
In-Reply-To: <877etds220.fsf@evledraar.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1712232248410.406@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com> <877etds220.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1530575971-1514068234=:406"
X-Provags-ID: V03:K0:uusOQodZANjqDPUWFOH1ghJVkYjsLk14qw0FGcWYSVrUOry5MMC
 Tqw6nBiqdezRXmBEKKWya3kJihO5BNB1BdMvcV449ZdsYNZRGiUnGSkkn4pOh+LUer7yew0
 vHBz2fFLoXdyNTnShvUm2mYkaJ+etc6gegWTDV5K6X0AmQZUxVoaiUWa9NSjzOiHzXZhZ/Q
 nFvs41xWdn8EQGH4JQ0nA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oViZG2tiPkk=:srlleKBrSfoxosecyzYp9U
 7Z6FeQ/B81ONDUBVKdrXKyNW2tfSO8zc52G52wiyDzdrXtiXCglpoRfLsui8cOuv2sPd1ugL2
 4wz0bR618HDNPEZZnw/atsAV+/12KJazMKh4/15kt4uz1Tr4lYSGvWqN7Azrvvi8xPtaAuUUA
 ju57YTYPDDYFPVfk7DWhBA8jtSU+NdXtuyZrd1AHKpz34Qw65gZlr9HWoAKNQe5nce1/NebU+
 bphTp97p8IKofE0wIJ9Kcjmg21Gh3sNKogpR3MyFAWaiAdJaH/d6RCBuJSEGRB0tySIlbPgj/
 j1sA8oZHNl/scQOdw/SEFqGaxlRTgKt84AsQcky3zwRaugrNNkqyTOnifD+VR6Fyz8mYzMjNH
 zy6lUBto86Y2Wz7OAZlALHqEMdgJVXaocpt5uNFQ4fCKOt7ZvS5J2wKi43rd2iD3jOjZrhlMD
 DYpeD+K1cIxxuoyUHTLfr9DLj2LP3oKOZzzSLiStbZm1zrTopeCKs8pR60Enj/zOuNuYH7OkU
 8qh4i7Fsy2PIUKGkcznrM8Zx+rShzZEsMWZ1C0vQi5q5E8R33EXvkjjxZ+KsP03lh0KEw2YSG
 wXPmhT1JoT/Ua87lu/oGoj8xtKC52xLKcPdySYkiIaHQJjMhWKXu8AKOr/zckJhFC+WhIQE8x
 kh4VOjCV1zr/M3bbq1NkWqe6q5PIuP3N8CPTja9cWPRAT8SbHv8JT6z23HCpsHZVnizaFalRY
 1NPGANn2XQY/+wv1mDfPxX5wAlbXAJp82IZYEcFhJyH+IzsWixMl/MsvpvdH0kYjfO0afNhPS
 votwlR/pTThtmm0I3c/6o+3xzRBAnf0OMRv18PA9FqojhW9JAQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1530575971-1514068234=:406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Sat, 23 Dec 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sat, Dec 23 2017, Carl Baldwin jotted:
>=20
> > The big contention among git users is whether to rebase or to merge
> > changes [2][3] while iterating. I used to firmly believe that merging
> > was the way to go and rebase was harmful. More recently, I have worked
> > in some environments where I saw rebase used very effectively while
> > iterating on changes and I relaxed my stance a lot. Now, I'm on the
> > fence. I appreciate the strengths and weaknesses of both approaches. I
> > waffle between the two depending on the situation, the tools being
> > used, and I guess, to some extent, my mood.
> >
> > I think what git needs is something brand new that brings the two
> > together and has all of the advantages of both approaches. Let me
> > explain what I've got in mind...
> >
> > I've been calling this proposal `git replay` or `git replace` but I'd
> > like to hear other suggestions for what to name it. It works like
> > rebase except with one very important difference. Instead of orphaning
> > the original commit, it keeps a pointer to it in the commit just like
> > a `parent` entry but calls it `replaces` instead to distinguish it
> > from regular history. In the resulting commit history, following
> > `parent` pointers shows exactly the same history as if the commit had
> > been rebased. Meanwhile, the history of iterating on the change itself
> > is available by following `replaces` pointers. The new commit replaces
> > the old one but keeps it around to record how the change evolved.
> >
> > The git history now has two dimensions. The first shows a cleaned up
> > history where fix ups and code review feedback have been rolled into
> > the original changes and changes can possibly be ordered in a nice
> > linear progression that is much easier to understand. The second
> > drills into the history of a change. There is no loss and you don't
> > change history in a way that will cause problems for others who have
> > the older commits.
> >
> > Replay handles collaboration between multiple authors on a single
> > change. This is difficult and prone to accidental loss when using
> > rebase and it results in a complex history when done with merge. With
> > replay, collaborators could merge while collaborating on a single
> > change and a record of each one's contributions can be preserved.
> > Attempting this level of collaboration caused me many headaches when I
> > worked with the gerrit workflow (which in many ways, I like a lot).
> >
> > I blogged about this proposal earlier this year when I first thought
> > of it [1]. I got busy and didn't think about it for a while. Now with
> > a little time off of work, I've come back to revisit it. The blog
> > entry has a few examples showing how it works and how the history will
> > look in a few examples. Take a look.
> >
> > Various git commands will have to learn how to handle this kind of
> > history. For example, things like fetch, push, gc, and others that
> > move history around and clean out orphaned history should treat
> > anything reachable through `replaces` pointers as precious. Log and
> > related history commands may need new switches to traverse the history
> > differently in different situations. Bisect is a interesting one. I
> > tend to think that bisect should prefer the regular commit history but
> > have the ability to drill into the change history if necessary.
> >
> > In my opinion, this proposal would bring together rebase and merge in
> > a powerful way and could end the contention. Thanks for your
> > consideration.
> >
> > Carl Baldwin
> >
> > [1] http://blog.episodicgenius.com/post/merge-or-rebase--neither/ [2]
> > https://git-scm.com/book/en/v2/Git-Branching-Rebasing [3]
> > http://changelog.complete.org/archives/586-rebase-considered-harmful
>=20
> I think this is a worthwhile thing to implement, there are certainly
> use-cases where you'd like to have your cake & eat it too as it were,
> i.e. have a nice rebased history in "git log", but also have the "raw"
> history for all the reasons the fossil people like to talk about, or for
> some compliance reasons.
>=20
> But I don't see why you think this needs a new "replaces" parent pointer
> orthagonal to parent pointers, i.e. something that would need to be a
> new field in the commit object (I may have misread the proposal, it's
> not heavy on technical details).
>=20
> Consider a merge use case like this:
>=20
>           A---B---C topic
>          /         \
>     D---E---F---G---H master
>=20
> Here we worked on a topic with commits A,B & C, maybe we regret not
> squashing B into A, but it gives us the "raw" history. Instead we might
> rebase it like this:
>=20
>           A+B---C topic
>          /
>     G---H master
>=20
> Now we can push "topic" to master, but as you've noted this loses the
> raw history, but now consider doing this instead:
>=20
>           A---B---C   A2+B2---C2 topic
>          /         \ /
>     D---E---F---G---G master
>=20
> I.e. you could have started working on commit A/B/C, now you "git
> replace" them (which would be some fancy rebase alias), and what it'll
> do is create a merge commit that entirely resolves the conflict so that
> hte tree is equivalent to what "master" was already at. Then you rewrite
> them and re-apply them on top.

1) you just described the "merging rebase" I use in Git for Windows for
*quite* a while (five years or so):

https://github.com/git-for-windows/build-extra/blob/af9cff5005/shears.sh#L1=
2-L18

Just look for commits in https://github.com/git-for-windows/git/commits
whose oneline begins with "Start the merging-rebase".

2) you do not resolve merge conflicts here, as there may not be any.
Instead, you use the "ours" merge strategy.

> If you run "git log" it will already ignore A,B,C unless you specify
> --full-history, so git already knows to ignore these sort of side
> histories that result in no changes on the branch they got merged
> into. I don't know about bisect, but if it's not doing something similar
> already it would be easy to make it do so.

Sadly, it is not as easy as that. When you call "git log", you often want
to know *when* a change was introduced originally. In this case, you would
*not* want A, B nor C ignored, but you would really want to dig into that
history that is ignored by default.

In general, the technique you described (and that I described years before
you, and employ for years, too, so I actually already have experience with
its pros and cons) works, but leaves quite a bit to be desired.

For example, when anybody asks me "when was XYZ fixed in Git for Windows?"
it is not enough to run `git blame` and then `git name-rev` on the commit
identified by `git blame`: this would be your A2, and there could be any
number of previous iterations *of the same patch*. What I do in this case
is to search for the matching oneline in the full history, from the end.
This is a costly, and not very automatable operation (as there have been
rewordings at times, in particular when the oneline contained a typo).

> You could even add a new field to the commit object of A2+B2 & C2 which
> would be one or more of "replaces <sha1 of A/B/C>", commit objects
> support adding arbitrary new fields without anything breaking.

This is a very fragile way of doing things because you cannot fix rebases
done in the past. Those commits won't have that header, and you cannot put
it there after the fact, not even manually identifying the mapping.

Besides, there are plenty of scenarios when you do not actually want a
merging-rebase, e.g. when you develop a patch series and have to iterate
it over a dozen times until it is finally accepted into core Git. In this
instance, you may want to retain the iterations' commit histories during
the time of the development, but you probably won't need it any longer
after the patches have been integrated into a released version.

Baking those names into the commit object would kind of cause broken links
in such a scenario.

BTW it gets a lot more complicated when you think about

1) fixups and squashes, and

2) the often much more interesting question: *with what commit* was this
one replaced?

> But most importantly, while I think this gives you the same things from
> a UX level, it doesn't need any changes to fetch, push, gc or whatever,
> since it's all stuff we support today, someone just needs to hack
> "rebase" to create this sort of no-op merge commit to take advantage of
> it.

I already did that. You can use the above-linked shears.sh script to
perform such a merging-rebase.

However, my experience is that the lack of UX in Git's tools do hurt at
times, it is incorrect to say that log or blame already support this use
case (see the discussion above).

The most important part would be to record the mapping between old and new
commits; the `post-rewrite` hook would pose a natural way to implement
this: it gets called after a successful rebase, receiving a stream of
lines via stdin of the form `<old-commit> <new-commit>` (listing multiple
lines for the same <new-commit> if there were fixups and/or squashes).

This points to another command that absolutely would need patching: `git
pull` (or more correctly: `git merge`). Why, you ask? If you use that
technique (and we do, as I pointed out earlier, in Git for Windows),
contributors *will* start to send you contributions *based on previous
iterations*. If you integrate them ("pull"), the merge may very well
succeed. But the next time you rebase, those commits will not be ordered
correctly, as they are considered older than the patches on which they are
based (which have been rebased in the meantime already).

In Git for Windows, I do have these problems, and they are even worse
there because instead of a linearizing rebase, I recreate the branch
structure instead (see https://github.com/git/git/pull/447 for my upcoming
attempt to implement this functionality directly in core Git, in proper,
performant and portable C). So the base commits are *really* important
information. And I had to work harder in the past to find out what the
newer iteration of the base commit really is.

BTW I would *strongly* suggest to use notes instead of a new commit
header. You absolutely do not want to impose this on any user who does not
want it. And notes can be added for already-completed rebases. Even
manually, if need be.

Ciao,
Johannes
--8323329-1530575971-1514068234=:406--
