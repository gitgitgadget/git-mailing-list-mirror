From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Tue, 15 Mar 2016 14:56:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603151448220.4690@virtualbox>
References: <cover.1457609615.git.johannes.schindelin@gmx.de> <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com> <alpine.DEB.2.20.1603101417590.4690@virtualbox> <CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
 <xmqqmvq5bjlc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1603150746490.4690@virtualbox> <CACsJy8B+c8=Y0Lb-TxjGF4689xP2Vyqjp4Q6CuffTLDWDMh3gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 14:56:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afpSf-0003J9-5q
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 14:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965286AbcCON42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 09:56:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:64253 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934119AbcCON40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 09:56:26 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LlHsg-1a8Pqc2dGQ-00b0fi; Tue, 15 Mar 2016 14:56:20
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8B+c8=Y0Lb-TxjGF4689xP2Vyqjp4Q6CuffTLDWDMh3gg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:lJAkdxgbHTLFPQW6pPXa28o7H7IyWCfBn8rvWNyJggw823idoSy
 LzpDU3Hurio4uKY2rO68VbbyAXEZMXdh+ZQouBEFvYK0jQLenkpuHV+bRAxKD32a/TH5m8U
 WONmxlHGKldPZwukpV9IPZJNS8pmb6xBJj0rl+fAe2BC+XeIQhN3k/wP/8Lyrq9VkiF1zwv
 3Q7pjd8nfU36Jh8WmrToQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yBBGJXfHTb8=:MqSgPsfhrNRmwvDU4yjKB6
 DL/t/y3OSCMxkkfLoEcphzEWK4R1WajGbldjUFek241N7bqlRZUdcXUMbBY0SpwnfaClaJrPz
 mz0atiOSpTMT6XC5Xi151rYlDE6X7SrJ2ERmhPXiDoCzyyKd+GylH9Q5baWr5aXy7k9siwT1o
 ZlQWgGOAs8XdBG14kIlsl2YB3WFjatfn+UZ79J0JJXvzioJ35Q4psMVj598VEnKX7P78kTXut
 8hFfTsStrM4wC5LQ1Xp6OS1N8D6I3h25geDWyWz1xqGcXwn2QGtx1oqMqCYIw6rN+sLJwzJKV
 QZLWyBa0dJIXlNOXqkjTkE4dLpujpyvIAFxG7UidYDowXUliDB/L3OdTLVvM4zoAwjBeI1pzd
 H4l/3+kZwHOAAV0GeRTyowuX++ErQp4N4sA0ntBvKapI4KurueTekuuwbnXidzJB5m65WCtSi
 3ZRDe2ZI36qJ+F+1DeJ1x2K6RU0XSlMCyOqFTvVdNpEtUwZ3iWuZf2U23thOsW0rg3DbVrB0K
 cgxQt8WncuSdB3fKNdMQ+9lJe4APEBbBmEP/n5oKghG4F/g9jzUtpJ7fJaIofixO1PKqPC4Df
 36/8FQUxajku11Stqyjd6c07NOJJ4rN8uYt43oYUBCfaq+IOE0jQqVZKr+BV+oTM+fHhulKW9
 pv5JsMt0W70aaERZ0YedYdLNxbT//sMnMl7OddggHa56WDw84XYV5St/hDP8hzUAxks+qbR2O
 UyoUPUgU/4ICxygBUdG4EVG0HnH7tTWFvI7OCdRiZGmzbuSzlgKs1mW787xfWOfRfZUYYnEW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288853>

Hi Duy,

On Tue, 15 Mar 2016, Duy Nguyen wrote:

> On Tue, Mar 15, 2016 at 1:53 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> That approach to implement the UI that directly faces the end users
> >> via scripting would let your users choose layouts more flexibly.
> >> Some people may want a repository and its worktrees next to each
> >> other, some others may want the worktrees embedded inside the main
> >> repository, yet some others may want layouts other than those two.
> >
> > Having the worktree in a totally different location than the associated
> > repository is *very* confusing.
> 
> I disagree (unless I misunderstood you).

How is it not confusing having all of your worktrees, no matter whether
they connect to git.git, to git-for-windows/build-extra.git, to
Alexpux/MSYS2-packages.git, to cygwin.git, to curl/curl.git, to
whatever.git inside $HOME/worktrees/?

I tell you how it is not confusing. It is not confusing by artificially
re-creating the hierarchy inside the $HOME/worktrees/ directory.

And you only need to re-create the hierarchy because, you guessed it, you
tried to disconnect the worktrees from their repositories.

So it is nothing but a bad old workaround, is what it is.

> One of the use cases I have for multi worktree is move all repos to a
> central place. Remember the .git directory security bug?

I remember.

> It would not happen if the repo is put away.

Sure. And with the repository being put elsewhere, you also buy the tedium
to no longer be able to simply "less .git/rebase-apply/patch". Which I
have to type *a lot*. You win some, you lose some. If you ask me, you lose
some more, but in some cases that is worth it.

> And it would be easier to backup repo data too. Also, "git worktree
> list" is there to locate any worktree. I don't see why it's confusing.

Yeah, it is clear to me now that you do not find it confusing. Even if I
find that fact in and of itself confusing, because it is very, very
confusing to me to have the repository so far away from my worktree as to
forget where it actually is, opening the door real wide for trouble e.g.
by archiving my repository behind my worktree's back.

You win some, you lose some. I am simply not prepared to lose *that* much.
My worktrees will stay inside my originally checked out working directory,
thankyouverymuch.

Ciao,
Dscho
