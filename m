From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Mon, 14 Mar 2016 14:45:33 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603141445140.4690@virtualbox>
References: <cover.1457609615.git.johannes.schindelin@gmx.de> <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com> <alpine.DEB.2.20.1603101417590.4690@virtualbox> <CAHYJk3Sij4tH0i29Asahjj8KBdQj59jFRTCoYzO_XE_kt3SnDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 14:45:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afSoc-0000hK-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 14:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbcCNNpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 09:45:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:50212 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932102AbcCNNpm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 09:45:42 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MFz0E-1aZTJo2hAk-00EtHO; Mon, 14 Mar 2016 14:45:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAHYJk3Sij4tH0i29Asahjj8KBdQj59jFRTCoYzO_XE_kt3SnDw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:hVjKEwyZF4FDEloRomCnyZWfQ516sj7RMDI4fXLNlHoEBN3K08I
 6fhAQ2liI8CslPyNuF7JGOjIJmKTVaVfOlA5Eg8wXGPdDOyyyE5qBQsahfWLO7xJVw8rJsN
 /rZNJRf9y2+QIV2eKZiZ7bEkTL5Tjlf6nrvX2Hf63+2ijvlf/dT2RggE0TxsAbyzZPoOKAq
 6V8nOkqiM3/rq/ZxzCuow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d+PQL/53h7A=:n/IXWZSIDFbBm+jBN6SHcR
 sxlu995cfnepU5TbEz2pQ4ZenKFBKdCmdR3VvUCMI7Q0SHGiQUFR2A+qcxgG+QqepiGopYO6J
 P+jiAOMp8IKp6YwzcRAQFRbrfGK1BvNlHGGPFDu/CLmEW6GOvMwovkppa1evKr4flSix9fwrr
 IPjIcZYrVz3HtSvhS7fdQD2iidtguR2dO1jPTV0IUzN/97beFZTT0HqOn9IzS1V3qix+8EZHa
 9Dblk+aOIcgcmWCytYsBD2bCgwj2EqYJkliANjNTDBwQZ7xCtVZB8ivoO4D+uLvqgFXSfkFm4
 pH1qLY6nGnhrLUK0/FnGkftuaKgg+36wqed8+EIwHvCbWFrBmuoDPUYp7nOTsOJZQxfEoPYAr
 6Q5D4hmic/6k9ENocj0wc3YUmFj2xJe96ghDN+0aHaopMZg5mT16p50SLoITd7cCNl5i8lF+n
 KiRyf0DkHBVDFIMhQUsKyCAh82RrQYOKmlrggKZSprd2+9gEVKXDXkPwOlLDoeCu/gFvm4uVi
 62O9kV/1MxnEFG5UUibQrmtkZeENaOX+zNd1PhlRjb92LQJocB9R2Vam/37J6v66VlDXQFKD1
 c6ivV6SutvYr7xoCOZAlfZClZ1TE/RghCQY266brmSOeUIdnFfl+FriEnGaLprk4c3cA30Y7f
 vxohAWIwOgodJu1h5X7rWzKQMZEgNyrSU0hyZ5uOJ2DzkG4gk6thbOJNsgY5UO4ZYR0avC3h7
 bsmRj55WQjIwzzp157XYUvV3VOL+eIsa75e//JTRe1g726BgqAPUIblIgJOQMtrUXlr3iqcb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288779>

Hi Mikael,

On Fri, 11 Mar 2016, Mikael Magnusson wrote:

> On Thu, Mar 10, 2016 at 2:21 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Duy,
> >
> > On Thu, 10 Mar 2016, Duy Nguyen wrote:
> >
> >> On Thu, Mar 10, 2016 at 6:34 PM, Johannes Schindelin
> >> <johannes.schindelin@gmx.de> wrote:
> >> > One possible improvement would be to add "/xyz/" to the parent
> >> > repository's .git/info/exclude, but this developer hesitates to
> >> > introduce that feature without the "delete" counterpart: those exclude
> >> > entries would likely go stale very quickly. Besides, there might be a
> >> > plan in the working to exclude worktrees automagically?
> >>
> >> That's needed because you add a worktree inside another worktree? I
> >> know that feeling, but I've changed my layout from ~/w/git as main
> >> worktree (and ~/w/git/.git as repo) to ~/w/git as a non-worktree dir
> >> that contains all worktrees, e.g. ~/w/git/reinclude-dir,
> >> ~/w/git/worktree-config, ~/w/git/lmdb... My typical worktree add
> >> command is "git worktree add ../<some-name>" then move there and do
> >> stuff. No nested worktrees, no need to update exclude file (and no
> >> messing up emacs' rgrep command, which does not understand .gitignore
> >> anyway)
> >
> > This feels to me like it is working around the problem rather than solving
> > it. My worktrees are inside the corresponding top-level project for a
> > reason: I work with multiple projects, and having all of their worktrees
> > in a single $HOME/w/ directory would be rather confusing to me.
> >
> > I really want to keep my Git worktrees inside /usr/src/git/ (in Git for
> > Windows' SDK).
> 
> You can have /usr/src/git/master, /usr/src/git/some-work-tree, etc,
> and /usr/src/git itself is not a git repository at all. That way
> /usr/src only has one git-related directory and no worktrees are
> nested. The only downside is if you work in master most of the time,
> you have to type "/master" more. I think this is what Duy suggested
> too, but you interpreted it as having /usr/src/git-master,
> /usr/src/git-some-work-tree etc?

That is a sensible workaround.

The question is: why do I need a workaround?

Ciao,
Dscho
