Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D6B1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeJCD0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:26:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:48663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeJCD0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:26:50 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2FhY-1fqk572dc4-00s8Ln; Tue, 02
 Oct 2018 22:41:37 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2FhY-1fqk572dc4-00s8Ln; Tue, 02
 Oct 2018 22:41:37 +0200
Date:   Tue, 2 Oct 2018 22:41:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working
 tree the same way as the current branch is colorized
In-Reply-To: <87sh1uizxp.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810022234350.2034@tvgsbejvaqbjf.bet>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com> <87y3bnhs5a.fsf@evledraar.gmail.com> <CAC05387S9P+w8yqqcjkQDnURYSgQmqtukxS4KvqJu-kDA+_o0g@mail.gmail.com> <87sh1uizxp.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-336090280-1538512900=:2034"
X-Provags-ID: V03:K1:gZ5z4016MsLvWnpgx99Ok/Fo8y+94OoGDW4Bq/O1bbs0HvRzmbP
 y0GHkZUnxxA8AkW85m5Hjcn5d8+OLkxY1Q8beNM7ZwqRWRp6Z6EMZb8kN8CNuQU6tbCkMkM
 RNcfcsf/jETpP1Y6mbiaUUel4UH+m7a+ZqpaiUN43sM40zu/Bs+d8teSsMLoS4YM1+xm3FR
 ookuJ8DVpowfQDup0NhGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y/VBbzvlrSM=:PmvqsOK6ZHzu+A+A2HY81I
 8xZ5N2Pupket7gn/t1QDR+QZcijsXtZm4M0rPvAaO46rw/5WVTRURg7QDGjKANQfvN/emTk7F
 ROPrOPscFMTpI4FdXjqsI1xyqe0gPGeub+9GmnquRvKVtZt1Y9uH4OJ4rkBG9iGg7dqaIGf/I
 iySV0jhrWTn6O0v7BZAh5W8oJJkQAYa/FpXbaWX8/kKhaIrT0Ge1Ytk129bQJGK7iBSmXVe9v
 yYjcS9aoDjCXB/1oHt9lAbJYPon4slFHVICYo5wNBK0TFQyfaMUjGhmFDgLhk7So6/BhMwgW3
 KIkwtkEdRi7sqPVIHS61BIiMqN9Cc3eI2ausareg7NmRjial+JEpbQLr+lhc828WhF7zSi5zD
 KA6dMEV8S3pLIPXL7CYorSe/WwYaQbpviU6NvS9Mdg4CjcMoX0h9Aq4pABT8ENEhaxOk80SxK
 e/gu8J8vSMrgWGJPzwy//jmGhgm/INo4NG3JX7IpvIljP1mlC+fc5kZSy+TZyS9X7qtZDMQlg
 s8X/D5AVInjCf5lUZaQaIRyhM66MwBW1382M28j2VZa29xw2T2MdX1588gJAxxlL0evGCC3rx
 VBqZL+cdG0WfQEqldoH19PALZCZmIvASGKn/ZjC3TGcyMQaMlQ50yR5tAy/A5vKXLrIgRUTTH
 QVPcfZYl/hNwIm5LRsVT8z8tk5H1DBaX5ODm6rZKBjGGMLB9n5sAeQpJ2ifi8MojjAn61z7YF
 T28z3veAYPr1oUA23rt500zWeU3ISByklqbv28H6Wq+47IBzeW0cOArKxD9kwScuQCqSazv77
 BatJQgj1ATZQUByc44O/0xty/mq99FrdLImL3Utyi5W3GK5ldo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-336090280-1538512900=:2034
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Thu, 27 Sep 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Sep 27 2018, Nickolai Belakovski wrote:
>=20
> > Will do re: screenshot when I get home, although it's pretty easy to
> > imagine, the git branch output will have one other branch colored in gr=
een,
> > bit without the asterisk (for one linked worktree) :)
> >
> > Also will do re: changing comments to /**/ (didn't know // was from C++=
,
> > TIL) and I'll clean up the comments to remove some of the more obvious
> > ones, but I'll try to keep a comment explaining the basic flow of creat=
ing
> > a nest if statement to evaluate worktree refs for color.
> >
> > And yes, I copy/pasted into gmail. I was having trouble setting up
> > send-email, but I think I may have it figured out now. Should I create =
a
> > new thread with send-email? Or maybe reply to this one (I can do that b=
y
> > specifying the Message-ID to reply to right?
>=20
> You'd run git format-patch master..your-topic with
> --subject-prefix=3D"PATCH v2" and
> --in-reply-to=3D"<CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mai=
l.gmail.com>". Then
> it'll show up in reply to your v1.

There is also a nice tutorial in
https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md#submit-y=
our-patch
(which, contrary to the location, is useful for non-Windows developers,
too.)

> You can also for an easier experience do this via GitGitGadget, see
> https://github.com/gitgitgadget/gitgitgadget looking at its code it
> seems to have some way to reference a Message-ID, but I don't know how
> to trigger that.

IIRC GitGitGadget has no facility yet to reply to any mail it did not
generate itself (i.e. if you did not generate v1 using GitGitGadget, then
it cannot generate a v2 that replies to the previous iteration).

This might change at some stage, but I have other priorities for now.
(Which should not stop any contributor from opening a PR to scratch their
own favorite itch.)

Ciao,
Johannes

>=20
> > This is my first time using this workflow, so I appreciate your
> > patience :) )?
>=20
> No worries, happy to help.
>=20
> > On Thu, Sep 27, 2018 at 8:33 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com>
> > wrote:
> >
> >>
> >> On Thu, Sep 27 2018, Nickolai Belakovski wrote:
> >>
> >> > In order to more clearly display which branches are active, the outp=
ut
> >> > of git branch is modified to colorize branches checked out in any li=
nked
> >> > worktrees with the same color as the current branch.
> >> >
> >> > This is meant to simplify workflows related to worktree, particularl=
y
> >> > due to the limitations of not being able to check out the same branc=
h in
> >> > two worktrees and the inability to delete a branch checked out in a
> >> > worktree. When performing branch operations like checkout and delete=
, it
> >> > would be useful to know more readily if the branches in which the us=
er
> >> > is interested are already checked out in a worktree.
> >> >
> >> > The git worktree list command contains the relevant information, how=
ever
> >> > this is a much less frquently used command than git branch.
> >> >
> >> > Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> >>
> >> Sounds cool, b.t.w. would be neat-o to have some screenshot uploaded t=
o
> >> imgur or whatever just to skim what it looks like before/after.
> >>
> >> > diff --git a/builtin/branch.c b/builtin/branch.c
> >> > index 4fc55c350..65b58ff7c 100644
> >> > --- a/builtin/branch.c
> >> > +++ b/builtin/branch.c
> >> > @@ -334,11 +334,36 @@ static char *build_format(struct ref_filter
> >> > *filter, int maxwidth, const char *r
> >> >         struct strbuf local =3D STRBUF_INIT;
> >> >         struct strbuf remote =3D STRBUF_INIT;
> >> >
> >> > -       strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)
> >> %s%%(end)",
> >> > -                   branch_get_color(BRANCH_COLOR_CURRENT),
> >> > -                   branch_get_color(BRANCH_COLOR_LOCAL));
> >> > -       strbuf_addf(&remote, "  %s",
> >> > -                   branch_get_color(BRANCH_COLOR_REMOTE));
> >> > +       // Prepend the current branch of this worktree with "* " and
> >> > all other branches with "  "
> >>
> >>
> >> We use /* ... */ C comments, not C++-style // (well, it's in C now, bu=
t
> >> not the ancient versions we need to support).
> >>
> >> It also seems all of this patch was copy/pasted into GMail or somethin=
g,
> >> it has wrapping and doesn't apply with "git am".
> >>
> >> Also most/all of these comments I'd say we could better do without,
> >> i.e. the ones explaining basic code flow that's easy to see from the
> >> code itself.
> >>
>=20
--8323328-336090280-1538512900=:2034--
