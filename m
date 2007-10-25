From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 11:27:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251117310.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site>
 <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site>
 <79366145-3C91-4417-B62C-FFF9EC452076@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Baumann <waste.manager@gmx.de>, Andreas Ericsson <ae@op5.se>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkzxB-0007xw-Ta
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbXJYK23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755158AbXJYK23
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:28:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:41409 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754650AbXJYK21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:28:27 -0400
Received: (qmail invoked by alias); 25 Oct 2007 10:28:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 25 Oct 2007 12:28:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+t9LQxsYmtWK8H7odtFPOUxYGlOEoNY16xiq03by
	zY+MjnbXG3O5tW
X-X-Sender: gene099@racer.site
In-Reply-To: <79366145-3C91-4417-B62C-FFF9EC452076@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62305>

Hi,

On Thu, 25 Oct 2007, Steffen Prohaska wrote:

> On Oct 25, 2007, at 1:28 AM, Johannes Schindelin wrote:
> 
> > On Thu, 25 Oct 2007, Steffen Prohaska wrote:
> > 
> > > On Oct 25, 2007, at 12:14 AM, Johannes Schindelin wrote:
> > > 
> > > > But I think I have to drive my message home again: if what you 
> > > > desire becomes reality, you take away the clear distinction 
> > > > between local and remote branches.  In fact, those branches are 
> > > > neither local (because the next pull will automatically update 
> > > > them with remote changes, but _only_ if they fast-forward) nor 
> > > > remote (because you plan to work on them locally).
> > > 
> > > Exactly, because I do not work on those branches alone. These are 
> > > _shared_ branches. I can work on such a branch with a group of 
> > > developers. I'm willing to accept this bit of chaos.
> > 
> > It is not just a chaos.  I see a serious problem here.  On _your_ 
> > computer, you do _not_ have a shared branch.  Which is visible _even_ 
> > in your modified work flow when you have unpushed changes.
> > 
> > So your desired illusion that your local branches are anything but 
> > local branches will never be perfect enough.
> 
> Ok, there is not a fundamental difference between local branches
> that automatically merge from remotes and local branches that
> are purely local and _never_ merge anything automatically. Both
> are only local branches.

Actually, not really.  For refs/remotes/* you expect them to change 
possibly at the same time.  For your local branches, I'd expect them only 
to change when I am actually working on them (and yes, that includes a 
pull into the current branch).

> > > Your rebase workflow is not possible if more than one dev wants to 
> > > work on the topic branch together.
> > 
> > Why not?  I do it all the time.  CVS users do it all the time, for 
> > that matter.
> 
> You're right. You can rebase your local changes on top of the new shared 
> remote head. And this is probably the best thing you can do to get a 
> clean history. Maybe it should be easier.

It should.  Thus my question about best practices (which is technically in 
this thread, but we are in a subthread which permuted into "I want git 
pull to behave differently")

I _want_ this to be easier.

> So, do I understand correctly, what you propose is:
> - never merge but only rebase
> - Due to lacking support for this in "git pull", never use
>  git pull when working with shared branches but instead _always_ use
>  "git fetch; git rebase origin/<branch_I'm_on>".
> 
> So you say that one of the first messages in "git for CVS users", "The 
> equivalent of cvs update is git pull origin" [1], is wrong. I don't 
> think I'm able to sell your proposed workflow with the current 
> documentation. But maybe I try if I'm absolutely convinced that it is 
> superior.

Hehe.  You just experienced the tremendous speed at which git moves.  In 
the beginning, we really thought that "git pull" is all you'll ever want 
to have.

But in the meantime, one of the biggest Enemies of the Rebase (yours 
truly) converted to an avid fan of it, because it really helps 
development.  It also makes for clean history, which is always good.

> > > > But here is a proposal which should make you and your developers 
> > > > happy, _and_ should be even easier to explain:
> > > > 
> > > > Work with topic branches.  And when you're done, delete them.
> > > 
> > > Again, if you want to share the topic branch the situation gets more 
> > > complex.
> > 
> > Hardly so.  In my proposed solution to your problem, there is nothing 
> > which prevents you from working off of another branch than "master".
> 
> Well if you have several local branches checked out that are
> shared with others you run into the "git push" problem again ...
> (see below at git push origin master).

Do the same as I, always say "git push origin master" (of course, you 
should exchange "master" with whatever branch you want to push).  Be 
precise.

> > > > So the beginning of the day could look like this:
> > > > 
> > > > 	git fetch
> > > > 	git checkout -b todays-topic origin/master
> > > > 
> > > > 	[hack hack hack]
> > > > 	[test test test]
> > > > 	[debug debug debug]
> > > > 	[occasionally commit]
> > > > 	[occasionally git rebase -i origin/master]
> > > > 
> > > > and the end of the topic
> > > > 
> > > > 	git branch -M master
> 
> Isn't this a bit dangerous? It forces to overwrite master no matter 
> what's on it. You don't see diffstats nor a fast forward message that 
> confirms what you're doing.

Yeah, I should have said something like "git branch -m master" 
(implicitely assuming that you have no current "master" branch).

> > > > 	git push origin master
> 
> I'd like to see "git push" here.

I think it is not asking too much for the user to be a bit more precise.  
If you really do not trust your developers to be capable of that, point 
them to git gui.

>    git branch -m <shared_branch>
>    git push origin <shared_branch>
>    git checkout do-not-work-here
>    git branch -D <shared_branch>

Actually, the last two commands would better be

	git checkout HEAD^{commit}
	git branch -d <shared_branch>

> > The problem I see here: you know git quite well.  Others don't, and 
> > will be mightily confused why pull updates local branches sometimes, 
> > and sometimes not.
> 
> But it already happens now. "git pull" sometimes merges a remote branch 
> (--track) and sometimes it reports an error that is fails to do so 
> (--no-track).

If there really is an inconsistent behaviour, then we'll have to fix that.  
We should not introduce inconsistent behaviour on top of that.

Ciao,
Dscho
