From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Thu, 10 Mar 2016 14:21:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603101417590.4690@virtualbox>
References: <cover.1457609615.git.johannes.schindelin@gmx.de> <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 14:22:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae0XO-0004Wp-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 14:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbcCJNVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 08:21:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:53328 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750997AbcCJNVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 08:21:52 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnOve-1aDBZP1Fcs-00hbJC; Thu, 10 Mar 2016 14:21:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7iVIOPxMB2pSrXCj+30zBYVtS1IGPmwph1B04o6KWIlRQ0lTU9A
 Dc3lAGQiaM3655IVb8E1zMHHX7mnjTSm9DIcIVm83syLrdyXovz+Mkh0O82970i+mwDXXPs
 2XJx07dwtYFKXdsuYKlnmE5Id+dYrdiMv+OoT14fFMQ3fPD6FvEJB0I5v5irgs+ihaP+NZL
 QOCb1iipXAxUm3a/WQ+Jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wazsHJbzmkw=:jVO7FzJyiaGKf8sSofyUz7
 kyXs98YRSDJzz1eKGnKBL9BlslpI7B8bALnLFl3y5krfFs1eBMFsfWQUi6vkXEJUABF9VmySz
 oVaMHDYxgrF/rsajYL8cKHF+FxqNPxspzUtQNv01yVvXOJXH3f4VN5YMpP84KxiTfBZ1Qm4t0
 g72lVjzMCJYMXZxTPbDlOBdbQZTZ9jpDSQyaYydC6HAr1DHpRrE2n2TmWTqOiA8h8xs7UNbKO
 5Qu3EaNcjDgF0B2ZMVc3joLWQPGuQsn6T5aZdpyTJ/wPsXqrFUqUGIp17OJa2rMjj4v1yvgtv
 ERNrJfbo3cE6gM6gxP1+ZApqohwXhN63VIppGTfTxn/gIPGfXoP5U95WtVGsvzxEIbG+P2UJL
 XGCa8RFLqCpXEcOwZ2h2YpiAEfKxLJjYzvd9C5AXbmTGJ38EtcIPQ0eVVscj4Tx+0fLo1mCy9
 blcEBv6YfXoKNuUUw4mjCNfbIMZrM2r80gZ2RE/oQfNngEqp34fvHqp6sNpgFPcin+8W+fC0+
 h8iFIZgmZ9WSMsMHtDsTWqA5TYGaqS2lpO3efJJDXCldfLBMr5YkuU4o30Xyep82KoaunM65W
 Upu8gN105yVma6UxkfodFJkmV8rWVICcr5zkbUBcgQMZjd3mxN0Zj9nlRjzphHTiNrpknAg+m
 cf6+JD58VVq6CVMemBwtKacj490KLD3Cb4YRGed1fK7ArGtTbmjx/1YfhpK8HlC2W9r30p2j/
 UKUQPe5nlc2Rt+ysXSD4kpMN1QkJog0l6H35rA487qoaTcIyiCfX06l97e6H/1bLusjWisnp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288621>

Hi Duy,

On Thu, 10 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 10, 2016 at 6:34 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The invention of the `git worktree` command changed this developer's
> > working style dramatically. Rather than switching between branches all
> > the time, topic branches are created and checked out in newly-added
> > worktrees, to be reworked and refined until the topic branch is either
> > merged into `master` or abandoned.
> >
> > It gets rather tiresome, and also typo-prone, to call "git branch xyz
> > upstream/master && git worktree add xyz xyz" all the time.
> 
> You can actually do "git worktree -b xyz xyz upstream/master" for the
> same effect. Maybe we can avoid "xyz" duplication with "-b -" or a new
> option name?

My branch names are usually longer, such as pull-rebase-prefix. And I
really like the short 'n sweet "git branch -w pull-rebase-prefix master"
invocation.

> > Hence this
> > proposal: "git branch -w xyz upstream/master" to do the same.
> >
> > The plan is to also support "git branch -d -w xyz" once the `git
> > worktree` command learned a `remove` (or `delete`) subcommand.
> 
> "git worktree remove" is coming (will be resent after -rc period). And
> I agree it's convenient for it to remove the branch as well because
> that happened to (and annoyed) me a few times. I still think it should
> be centered around git-worktree than git-branch though.

Granted, "git worktree remove" should be the work horse. But why not have
two ways to skin the same cat? I, again, would prefer the short 'n sweet
"git branch -d -w pull-rebase-prefix" invocation.

> > One possible improvement would be to add "/xyz/" to the parent
> > repository's .git/info/exclude, but this developer hesitates to
> > introduce that feature without the "delete" counterpart: those exclude
> > entries would likely go stale very quickly. Besides, there might be a
> > plan in the working to exclude worktrees automagically?
> 
> That's needed because you add a worktree inside another worktree? I
> know that feeling, but I've changed my layout from ~/w/git as main
> worktree (and ~/w/git/.git as repo) to ~/w/git as a non-worktree dir
> that contains all worktrees, e.g. ~/w/git/reinclude-dir,
> ~/w/git/worktree-config, ~/w/git/lmdb... My typical worktree add
> command is "git worktree add ../<some-name>" then move there and do
> stuff. No nested worktrees, no need to update exclude file (and no
> messing up emacs' rgrep command, which does not understand .gitignore
> anyway)

This feels to me like it is working around the problem rather than solving
it. My worktrees are inside the corresponding top-level project for a
reason: I work with multiple projects, and having all of their worktrees
in a single $HOME/w/ directory would be rather confusing to me.

I really want to keep my Git worktrees inside /usr/src/git/ (in Git for
Windows' SDK).

Ciao,
Dscho
