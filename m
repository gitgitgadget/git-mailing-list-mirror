From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Core and Not-So Core
Date: Wed, 11 May 2005 04:14:13 +0200
Message-ID: <20050511021413.GN26384@pasky.ji.cz>
References: <2cfc40320505100800426d38ca@mail.gmail.com> <1115739511.16187.432.camel@hades.cambridge.redhat.com> <2cfc4032050510092238259b63@mail.gmail.com> <1115744609.16187.455.camel@hades.cambridge.redhat.com> <2cfc403205051010151304d88a@mail.gmail.com> <2cfc4032050510101553d391b2@mail.gmail.com> <Pine.LNX.4.61.0505102158140.17216@chimarrao.boston.redhat.com> <2cfc4032050510190950bba995@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rik van Riel <riel@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 04:07:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVgdL-0001br-6B
	for gcvg-git@gmane.org; Wed, 11 May 2005 04:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVEKCOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 22:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVEKCOT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 22:14:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56748 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261881AbVEKCOO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 22:14:14 -0400
Received: (qmail 12369 invoked by uid 2001); 11 May 2005 02:14:13 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc4032050510190950bba995@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, May 11, 2005 at 04:09:49AM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> On 5/11/05, Rik van Riel <riel@redhat.com> wrote:
> > On Wed, 11 May 2005, Jon Seymour wrote:
> > 
> > > I did consider wrapping it - I really did. But after thinking about it
> > > for a couple of weeks I eventually came to the conclusion it would be a
> > > sub-optimal solution.
> > 
> > > So, if I want a stable foundation to build my stuff on, basing it on
> > > the output of the C tools would be a huge mistake.
> > 
> > Can Java use a library that's implemented in C, like Python
> > and Perl can?  If that is the case, the C implementation of
> > git simply needs the ability to be called as a library and
> > you can implement Java bindings for it.
> > 
> 
> It can in principle, yes. This is the so-called Java-Native-Interface (JNI).
> 
> I think in the longer term it would make sense to write a JNI layer
> but the GIT source code is probably a little too unstable for that
> now. What needs to happen first, I think, is that a solid and stable C
> API (e.g. a libgit) be proposed and developed.

FWIW, this is actually happening now (see Brad Roberts' posts in nearby
thread).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
