Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEF21F404
	for <e@80x24.org>; Thu, 15 Feb 2018 13:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031308AbeBONCx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 08:02:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:37345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031104AbeBONCw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 08:02:52 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0Mgc0l-1f7ZC228sp-00Nzck; Thu, 15 Feb 2018 14:02:49 +0100
Date:   Thu, 15 Feb 2018 14:02:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Psidium Guajava <psiidium@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git-rebase --undo-skip proposal
In-Reply-To: <CA+P7+xrNPe5106qSjs1BiGJ5RbVxmR=MiGNVeCAUbT3gR0cdLw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802151308501.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAEWZXo7KiRWK7ddyZgQKs=F+sHY7TtFsXTMXyE-57=FRr6kf6w@mail.gmail.com> <CAGZ79kZf1UKsBEJXuwAH+EWr+ZKj-FE8DuBvcM2nJeNhLEA4CQ@mail.gmail.com> <CAEWZXo6ws5q-73AP6+Ru39a+drO88fRO49_QGJbQXfOYRpqKwg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802150148040.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xrNPe5106qSjs1BiGJ5RbVxmR=MiGNVeCAUbT3gR0cdLw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BK57Kq9mAGGRZLZ6oeyhCGHIVL44BFkEYfxuMNTyL7HH06m1CPl
 J2ViqMs9Ghur/sk5WAJXJpNNDKmEs3OGO8XaJOLGIbaqiy30vAWBcm08cnS9KQLlo2IjXfM
 mwG4Sg5jpQ8m1UilmC5b1MJTEIItSVLyqxJ55yzJ1e+kugLQC7aVvfMrHBPHPtwMc92CfRa
 0lUBfusGu2HyB4NSWRMfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CcKvr8wFXds=:3oFsdyR6ZHa75HOCQDpW0P
 WOHSjcVG6WgfbTfFxxb3ZM9+HBGdYuUJ1HRG3AHqFwgUrhFLxNZHrqzXgj3sWYwwf+aMiF109
 TvAldnoX0a+d1kij/Ef2gXHlt0spNR1yk4FAkoW0WFTLiUnPyhMed4292/jmc9MR/V6gUQiwm
 nJ8eMPyrTJrlj7GC90jTFshF9KwDC29wiJDbUa5qPq+n0gJezQJlE0LSjR008s1I+2n0Uxnn2
 k7eMLax8yNhC9VF7AeE6ygrK7vxW3YJuf2HKv1JAYLlqtELXP4Uru5DkrsXVlNhbfmnlhVj3s
 KhZLeB37yEmHXqRbNZttYGj8ip4siPUc+z4cfHqN3KIgZzWCQFiY7CKinGce8+kOR9uzyLvgx
 AfLfw1M/5IHJa6Pl3oUIfBKErlqW0H4T1wAPcbscBWrQRGzjiiYig8zATyHSaHOy6FVZPMfmz
 4WVA4iblleJQeK3ty2DqhAtU3sn1vasDb9Zw0n7ze4Uy6qhHa4IR2KtqL1oIxMT6qj/2fqpDs
 CYJIBjK/m2ipNX+FAEir0hFKOTwXv87IR+JrR/Tv+odty29cvBiThRBWLVXL4V8JUyX6D6QK2
 ifUBb6Vh8TjRH935l+uVq4qwfyaDGZIC4YutaGZcvRs6D+pTHiWp2bYDya1sY0X0kCXVw8kPI
 75sCKRwQQx1QeEVa6pa9Qh7vgKPh66FzKd5ChcyBD25t9hMJxB/djaOmq3FGkrLSRKF1phugN
 vXyJ0DhxNVxrlKVcnb5+tB1vI0yHbwGn88mvh+8CbAe40T1ffsNH3MCmuy6cu93eaeu2baiNB
 PKDcMrWM9I/6Z021XT9L/1Klc4jEmI5/3pJwUoV1J5ribFtr8U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 14 Feb 2018, Jacob Keller wrote:

> On Wed, Feb 14, 2018 at 4:53 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 14 Feb 2018, Psidium Guajava wrote:
> >
> >> On 2018-02-13 18:42 GMT-02:00 Stefan Beller <sbeller@google.com> wrote:
> >> > On Tue, Feb 13, 2018 at 12:22 PM, Psidium Guajava
> >> > <psiidium@gmail.com> wrote: I think this could also be done with
> >> > "git rebase --edit-todo", which brings up the right file in your
> >> > editor.
> >>
> >> Yeah that'd would only work if one started a rebase as a interactive
> >> one, not am or merge.
> >
> > I agree that the original proposal was clearly for the non-interactive
> > rebase (it talked about .git/rebase-apply/).
> >
> > The biggest problem with the feature request is not how useful it
> > would be: I agree it would be useful. The biggest problem is that it
> > is a little bit of an ill-defined problem.
> >
> > Imagine that you are rebasing 30 patches. Now, let's assume that patch
> > #7 causes a merge conflict, and you mistakenly call `git rebase
> > --skip`.
> >
> > Now, when is the next possible time you can call `git rebase
> > --undo-skip`?  It could be after a merge conflict in #8. Or in
> > interactive rebase, after a `pick` that was turned into an `edit`. Or,
> > and this is also entirely possible, after the rebase finished with #30
> > without problems and the rebase is actually no longer in progress.
> >
> > So I do not think that there is a way, in general, to implement this
> > feature. Even if you try to remember the state where a `--skip` was
> > called, you would remember it in the .git/rebase-apply/ (or
> > .git/rebase-merge/) directory, which is cleaned up after the rebase
> > concluded successfully. So even then the information required to
> > implement the feature would not necessarily be there, still, when it
> > would be needed.
> 
> Instead of an "--undo-skip", what if we ask the question of what the
> user actually wants?

Heh, I thought in this instance, --undo-skip was what the user wanted ;-)

> Generally I'd assume that the user wishes to go back to the rebase and
> "pick" the commit back in.

Right, and then replay whatever series of commits was picked since the one
that was skipped.

What *could* be done is to save a copy of the current todo list (with the
skipped commit put back in, before the current first line) and save that
together with `git rev-parse HEAD`.

This should make it possible to implement `--undo-skip` for as long as
the rebase did not finish.

Theoretically, you could even save the commit name of the skipped commit
somewhere else than $GIT_DIR/rebase-apply/ (or $GIT_DIR/rebase-merge/),
say, as worktree-local `refs/rebase/skipped`, and then a `git rebase
--undo-skip` could detect the absence of $GIT_DIR/rebase-*/ and fall back
to `git cherry-pick refs/rebase/skipped`.

You'd have to take pains to handle that ref in gc, and to record when the
user edited the todo list via `git rebase --edit-todo` after skipping that
commit (and warn loudly upon/prevent --undo-skip) because those todo list
changes would then be lost.

That's just one way how this feature could be implemented.

It does strike me as awfully specific, though. And it would still only
extend to the latest `git rebase --skip`.

So I am not sure whether we really would want to go this direction, or
whether we can maybe come up with something (probably based on your
suggestion to give the user enough information) that would allow many more
scenarios than just --undo-skip.

> So what if we just make "git rebase --skip" more verbose so that it
> more clearly spells out which commit is being skipped? Possibly even
> as extra lines of "the following patches were skipped during the
> rebase" after it completes?
> 
> Then it's up to the user to determine what to do with those commits,
> and there are many tools they could use to solve it, "git rebase -i,
> git cherry-pick, git reflog to restore to a previous and re-run the
> rebase, etc".

I think this is a saner direction, as it will probably allow more
scenarios to be addressed than just undoing the latest `git rebase
--skip`.

Ciao,
Dscho
