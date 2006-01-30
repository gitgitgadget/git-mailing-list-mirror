From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [Census] So who uses git?
Date: Mon, 30 Jan 2006 11:58:22 -0700
Organization: Hewlett Packard
Message-ID: <20060130185822.GA24487@hpsvcnb.fc.hp.com>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com> <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org> <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com> <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:59:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3eET-0000qi-IQ
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 19:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWA3S62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 13:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWA3S62
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 13:58:28 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:50896 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S964873AbWA3S61 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2006 13:58:27 -0500
Received: from smtp2.fc.hp.com (unknown [15.15.136.253])
	by atlrel9.hp.com (Postfix) with ESMTP id 487F0356E9;
	Mon, 30 Jan 2006 13:58:26 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 9C54641E808; Mon, 30 Jan 2006 18:58:22 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 7EA81257C5; Mon, 30 Jan 2006 11:58:22 -0700 (MST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Keith Packard <keithp@keithp.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15288>

Junio,

You don't seem to give git enough credit.  I am a hardware engineer with
many softwareish responsibilities.  One of those is to keep up to date
with the many commercial and free SCM type tools that are available.

Git has become my SCM tool of choice for many reasons.

- Anyone can install and fire it up without license/contract hassles.

- The infrastructure barriers to getting a project started with git are
  about as low as they can be.

- Geographically distributed teams even inside a corporation are
  becoming more common.  Git's repository design meets this need
  perfectly.

- The repository is also to designed to be inherently safe from
  data-loss and corruption even in the face of concurrent writes due to
  each objects' immutable nature.

- While on the subject of the repository.  Good job keeping it simple.
  I was able to learn pretty much all there is to know from a technical
  stand-point about the objects and refs directories in an afternoon.
  It follows a principle I always work toward myself.  "Make it simple
  enough that there are obviously no difficiencies rather than making it
  complicated so that there are no obvious difficiencies."

- In my opinion git is flexible enough to support just about any
  development/build/release flow that one can think of.  Most of the
  free tools (including subversion and arch) make branching and merging
  --- on which most of these flows rely --- way too heavy-weight.  Git
  shows how light-weight it can be.

  Not only can parallel development happen easily between
  users/repositories but parallel development is trivial even within the
  same repository.  I  think your 'pu' system illustrates how powerful
  it can be.  I myself have had up to four concurrent branches where I
  implemented four different features in parallel in the same repository
  easily switching between them.  It was almost too easy to bring them
  together using merge as each one finished.

  I was just reading through an article on how to choose an SCM last
  week and I kept thinking how git could be used to meet almost every
  one (if not all) of the needs discussed.

- Git supports enough network protocols to make it immediately useful in
  about any situation with firewalls and such.  This is where it leaves
  monotone behind.

The biggest hurdle that I've seen in adopting git is training the users.
I myself took to it like a duck to water but I've found that even some
of my brightest colleages have trouble wrapping their heads around it.
Currently, I'm trying to look at what parts they are having the most
trouble with.  In general, I think it is grasping the reason for the
index file and how git commands like git-commit and git-diff interact
with it.

Even so, I've always appreciated those tools that may have a steeper
learning curve but that pay dividends over time.  Also, I should mention
that this learning curve has been flattening over time as git has
developed and obtained more porcelainish commands.

Carl

On Sat, Jan 28, 2006 at 01:08:54PM -0800, Junio C Hamano wrote:
> Keith Packard <keithp@keithp.com> writes:
> 
> Wow.......  You are switching Cairo and X.org from CVS to git?
> 
> It could be that anything is better than CVS these days, but I
> have to admit that my jaw dropped after reading this, primarily
> because I've have never touched anything as big as X.
> 
> Awestruck, dumbstruck,... Xstruck.  Yeah, I know I should have
> more faith in git.  Earlier I heard Wine folks are running git
> in parallel with CVS as their dual primary SCM now, and of
> course git is the primary SCM for the Linux kernel project.

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        RADCAD (R&D CAD)
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
