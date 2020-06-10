Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36D4C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C03206F7
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QvCQdUD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFJVan (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:30:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:39947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJVam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591824632;
        bh=ICrM9iSczaE5PIu9eck8LWGamcFEJBiGiucKOMAr1+4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QvCQdUD0EuuMfQ/8r5VAQNiwPZJNddso3M0kK/BEypLmpzurf2i5Ze58NbeN3ETig
         6R2p3GfubFgUoVURoU9vHV0gAO7VvZRUb9nd+6MZARsnd46jH2sFuadE/ySXm3V+A8
         0dBGg2/gMpJu+xh7q50N/QMkQQGUNLK6kJ7MQCwc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([213.196.213.108]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1ilqbY1IuO-011zgY; Wed, 10
 Jun 2020 23:30:32 +0200
Date:   Wed, 10 Jun 2020 23:30:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <20200505231641.GH6530@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com> <20200505231641.GH6530@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7g5Oia+7KR1mCztY9Neo9dwWIqYSLXPRf7SA05tpFDeAnulrQG0
 xEM5HdJ6wXqCtS7d9Pjc271F+GtyC8gq8b1QdxOpEGObucDroD7mnDMs14YjK2ZjmK7iK55
 8uEkIA/syJ4VybRj+kv+AhXBehnOHuuNTQBIBZEaclwNDRicAEiNtHmlPFxtnlr4UdQvigy
 xZ6BtNPi/7vDO0lBY0KEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FkzTvVFrCuw=:QYE44uc26XoZ+1R/nKwQ89
 e5BadNTdZNovcl7seSNTAsKKVH5t42LYaR1b8zyz14dWRTyC6Wy2LJXEzcx50ykMIr28erbHl
 MO1Iny39k6kGM7dY9AgZeJzJ5H8wJ9eTDUuvN/iMNcC7+0qgwnC2xa4ENuXG9doCKsTitdFjt
 wr73wk4jrkHPX/XtUMoZzaEOu21s72qpuWMuha3hUdocQaG17r9/Ch8qQY7ornViWvxx4SkD9
 bqD4xuEYFMrGd04QQYf1v2ZLZ9fYb7cyvNDmmx/4yF7e62bPEtP7lwniCrvz2WZT7jpTPbRpM
 RiP7UtlITkJz5aq8b9eJoAUQyR4OgzOX+CSMgr9RtrR92Jfu9DmCXMfCdnAylK+k3DgSAeBeF
 NpvRPIGnaKBTQBEYQ3jIPMlAbVdeLAvG79hVNGkmUaIVWbn8jLcNQMl2UVLQQPlcTVNfAxHt2
 E+j9T+IjDFZTfu+ZeA2vWoMn/WElKUqC4yZVZ6COfVog+3M47LAAWSJfrNEQbpnnNX3NnnmhC
 acBWYZ8TaaWH0570WTAeA7watR/LKEgf4FDH7zMZvcrAhlg9PEqplNJLek4QBOHk+c5dL0w7Z
 pnbtoaIcYGR/zxGD3D/SNMm2tbInQXjn6W/GMHebFB6ND+yic+xbQv5cEMUnHQ7CeDBAofZS2
 ZhbqBY3T0nVSDKViFiq3wYBKx7jtu44bcQIrJYisW1jSy57Mwe1V8npKg/598lVUWgAtyqhPV
 J5K8MxetS3HLtlceWB1nNKz1jB7pWx1LwP4fZZw1CR/nUdPH6JZmXJ6+Qlp3kImOQuxo1EPyP
 wgla4KvbV3Taz0FufBtimYl315rr5h/3hxDXXu6x0KYkML5fLyAaPg3RMDbNSmdFP5NwGqJZF
 gQw03UnqSJVt8LB68JdL+AdBq+UJhD2eDeUYVBF2K46xRc63zV8gjA9SRmpZdb1yweZAkBfSV
 g1/Q5CqEqKyzUWDl2paIwGY/sy6DuvwM+aNnBC3Av0PSCYYJZ39xVbfWueARLZVqfgdIJNBj7
 DlP/bzLG4odnFLIvCwkRtGHgZnJnCrcogOoFmB/yeXH/MDD9zMVpqEFZx6tk0PYyH0u4FU/DK
 7MEe0HTY13Tiz8ntNEYWqlEHBlkbHsxYiENd1ONrIAm2LIMUtE8ZZyoJKE0rU8rmcwmm11RaK
 LfcCpFq4dDmNGnjNKo9FeRQdAS/9D9CJlBxXbHJ6KlBqOJP8igic42O6t6tXFkFRco3yQjg/S
 7YCFC5o55wWGM698R
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Tue, 5 May 2020, brian m. carlson wrote:

> On 2020-05-04 at 17:20:33, Simon Pieters wrote:
> > "master" is an offensive term, as it can be interpreted as being
> > slavery-origin terminology. See
> > https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_co=
ncerns
> >
> > The Python programming language, and various other projects, have
> > taken a stance and moved away from offensive terminology including
> > "master". See https://bugs.python.org/issue34605
> >
> > When different projects using git decide to move away from "master" as
> > the name of their main branch, inconsistency ensues between projects.
> > See https://github.com/desktop/desktop/issues/6478 (and "Related
> > Issues and Projects").
> >
> > To avoid offensive terminology and to avoid further inconsistency, I
> > think git should use a different branch name than "master" when
> > initiating a repo. I don't have a strong opinion, but I like "main"
> > since it shares the first two characters and it's shorter.
>
> I've been busy and haven't had much time to respond to this, but I've
> gotten some feedback from other people on this issue and so I'll share a
> few thoughts.
>
> Others have pointed out that "master" meaning a canonical source may not
> share the problematic origins mentioned above.  From feedback I've
> received, I get the impression that "master", even though from a
> different origin, brings the idea of human bondage and suffering to mind
> for a non-trivial number of people, which of course was not the
> intention and is undesirable.  I suspect if we were making the decision
> today, we'd pick another name, since that's not what we want people to
> think of when they use Git.

Indeed.

I have to admit that I did not understand the breadth of how problematic
such a term is. I am a Caucasian male, and in the society in which I grew
up, that comes with a lot of privilege that I am only beginning to
understand in its entirety. One of the consequences was that I was
unaware, even oblivious, to the emotional response certain terms can
elicit. Just because those terms do not affect me very much, personally,
does not imply that I don't care. So I will try to do my share in helping
with this topic. It might not be much, in the bigger picture, yet together
with other, equally small steps, we might be able to do some good.

A growing number of projects does indeed rename their default branches,
and I want to do the same with Git for Windows' repositories.

I have reached out to Billy Griffin (the PM of GitHub Desktop) to learn
what might be good candidates for the default branch name, as GitHub
Desktop changed their repository's main branch name recently. This is what
he told me:

	[W]e did some research looking at the data at GitHub of the most
	commonly used default branch names other than `master`. Most of them
	were things like develop, release, staging, stable, production, etc.
	that denoted some stage of the software lifecycle. We thought that
	none of these are good options because a universally applicable
	default name should allow for teams and projects to work in
	different ways (and obviously if teams want to change it to reflect
	their workflows, they're free to do so just like they do today - we
	use `development` as the default branch in desktop/desktop, for
	example).

	The three most common names that *weren't* in that category were
	main, trunk, and source. "Trunk" has roots in SVN so there's some
	precedent for it, but we've heard feedback that it's not
	particularly intuitive for non-native English speakers, and "source"
	in my opinion isn't accurate because it's only a single branch, not
	the entire source. We've also seen "default" floated and it exists
	in mercurial, but we've also heard feedback that it's potentially
	sensitive due to financial default, so we might as well choose
	something else if there's another good option.

	For that reason, we're thinking that `main` would likely be a good
	choice because the name corresponds nicely to its purpose as the
	default branch of a repo. It's also conveniently short to type,
	and tab complete would continue to *just work* for those concerned
	about muscle memory because the first two letters are the same as
	`master`.

So I plan on using `main` for the repositories in the
https://github.com/git-for-windows org.

Billy then shared this information with James Ramsay of GitLab to
discuss how GitHub and GitLab can coordinate on changing the default
branch name in new repositories. Here is the GitLab ticket to track
their progress: https://gitlab.com/gitlab-org/gitlab/-/issues/220906

> Clearly we have compatibility concerns to consider though, so if we
> decided to make a change, we'd probably want to make it in a 3.0, which
> as far as I'm aware hasn't been discussed yet.  I also wondered what
> such a change would involve, so I did some research.
>
> It appears that if we made the obvious one-line change to
> builtin/init-db.c, we'd have 304 tests that fail, which is about a third
> of our test suite.  I haven't examined any of these tests, so I don't
> know what would be involved in changing them.  I imagine a project to do
> so would involve setting an environment variable in the test setup code
> (e.g., MAIN_BRANCH) and replacing instances of "master" with that until
> everything works with an alternate value of that variable.  Picking the
> new name itself could be deferred until later, and we could choose from
> some popular alternatives.

As mentioned elsewhere in this thread, Don (Cc:ed) and I started working
on this, and I just submitted it:
https://lore.kernel.org/git/pull.656.git.1591823971.gitgitgadget@gmail.com=
/
That patch series adds a config variable allowing to override the default
name of the default branch.

I hope to see this finalized and sent off to the Git mailing list
relatively soon: being strictly opt-in, it should be really
uncontroversial and obviously helpful.

> There's also the documentation, which at first glance seems mostly to be
> examples, many of which could be changed to any suitable branch name.
> There are a large number of those cases and someone would have to audit
> them all.

Indeed.

The good news is that this audit can be split between multiple volunteers.

> So it looks like this would be a reasonable amount of work for someone
> if they decided to pick it up as a project.  Since I have limited free
> time and am working on the SHA-256 transition, I won't be doing this,
> but if someone did pick it up, I would be happy to do some reviews,
> provide feedback, and include a few patches while doing other work in
> the area.

Based on the above-mentioned patch series, I have an end-to-end
proof-of-concept (with one or two monster patches that still need to be
split up) to change the default branch name to `main`. It is complete in
the sense that it passes the test suite (also in SHA-256 mode when merging
the `bk/transition-stage-4` branch), but it has a couple of too-large
commits that still need to be split up:
https://github.com/gitgitgadget/git/pull/655

I agree with brian that it was _quite_ a decent amount of work, and that
it will still require a decent amount of work going forward.

My current plan is to split this up into several patch series:

- above-mentioned patch series was already split out, and submitted for
  review, introducing `core.defaultBranchName` (and
  `GIT_TEST_DEFAULT_BRANCH_NAME`).

  From my point of view, this would be safe to have even as early as
  in Git v2.28.0.

- a patch series that tackles the hard parts of the test suite: one by
  one, the test scripts will be patched to include

	GIT_TEST_DEFAULT_BRANCH_NAME=3Dmain
	export GIT_TEST_DEFAULT_BRANCH_NAME

  at the beginning, and they will be patched to pass.

  This patch series should only be accepted once there is consensus (see
  below for more on that).

- a patch series to tackle the easy parts of the test suite, i.e. the
  scripts that needed only automated patching (`sed` magic).

  This patch series should only be accepted once (if!) the previous one
  was accepted.

- a patch that moves the GIT_TEST_DEFAULT_BRANCH_NAME assignment to
  `t/test-lib.sh` to ensure that the entire test suite passes with the
  designated new default branch name.

  This patch really only makes sense once consensus is reached not only
  that we want to change the default branch name, but also to what name
  it should be changed.

  The main intention of this patch is to ensure that the test suite keeps
  working with the new default branch name during the (probably quite
  long) time when Git holds off from "flipping the switch", i.e. until the
  above-proposed Git v3.0.

- a patch series that changes the default, and then addresses all of the
  documentation and the error messages mentioning the default branch name.

  This would conclude that effort.

Or maybe there are a couple more natural seams at which to partition
those patches better, to improve reviewability (and to reduce
reviewer fatigue).

> I realize there isn't agreement on a direction forward or whether this
> is worth doing at all, but since Git usually operates by providing
> feedback on an initial set of patches, I thought I'd sketch out what
> that might look like for folks who were interested.

Thank you for doing this.

As you hint, there are the technical challenges, but also the cultural
challenges. I think I outlined a sensible path forward to address the
technical challenges above, and now I would like to talk about a path
forward to address the social/cultural ones.

I do realize, of course, that as a white person identifying as male, there
is a real big risk that my efforts look as if I want to force everybody to
accept a new default branch name, to adjust their tools and scripts, their
workflows, for maybe not a big enough gain to be worth all that work.

So let me make my intentions clear: I do care about inclusive language,
and even more so about inclusive culture, and I would like Git to be
changed accordingly.

And as I learned from personal conversations with friends and colleagues,
as well as from stories and books, Git's current default branch name is
eliciting emotional distress.

Encouraged by Emily in #git-devel (who pointed out that a subject like
this is much better discussed seeing each others faces and hearing each
others voices), I would like to organize another Virtual Contributor
Summit, this time focused on inclusive language in Git, what we can do
about it, and what we should do about it (or not).

Tentatively, I would like to propose having this meeting in the coming
week, via Zoom, just like we did the Virtual Contributor Summit last
September.

Could I ask all interested parties to reply to this email?

> I should point out that it's also possible for users who dislike the
> current name to use a template to change the default branch name like
> so (using the proposed "main"):
>
>   mkdir -p ~/Templates/git
>   cp -a /usr/share/git-core/templates/* ~/Templates/git
>   echo 'ref: refs/heads/main' > ~/Templates/git/HEAD
>   git config --global init.templateDir ~/Templates/git
>
> Then "git init" will set your default branch to "main" instead of
> "master".  This does have the weirdness that it claims it's
> reinitializing your repository, but otherwise appears to work.  That is
> of course orthogonal to changing Git itself, but is an option for folks
> who'd like to make a change now.

That's a pretty good workaround in the meantime.

I would like to point out that there are two slight issues with this
workaround, in addition to the "re-initializing" message:

- copies of Git's templates can become stale during upgrades, as newer
  versions of Git might come with modified template files.

- Git's template files are sometimes used to install a set of hooks that
  was aggregated by the administrator(s). This workaround would interfere
  with that, at least if the set of pre-configured hooks gets modified.

For those reasons, I hope that the `core.defaultBranchName` patch will be
on its way into git/git soon.

Thank you,
Johannes

> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
>
