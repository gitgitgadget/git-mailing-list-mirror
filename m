From: Theodore Tso <tytso@mit.edu>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 14:23:58 -0400
Message-ID: <20071025182358.GA10664@thunk.org>
References: <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <Pine.LNX.4.64.0710251112390.25221@racer.site> <472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org> <4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org> <1193335339.4522.398.camel@cacharro.xalalinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Oct 25 20:25:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il7Nw-0004eE-Tn
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbXJYSYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 14:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbXJYSYh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 14:24:37 -0400
Received: from thunk.org ([69.25.196.29]:44285 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbXJYSYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 14:24:36 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Il7Xi-0008Sg-76; Thu, 25 Oct 2007 14:34:57 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1Il7NA-0002rR-W7; Thu, 25 Oct 2007 14:24:01 -0400
Content-Disposition: inline
In-Reply-To: <1193335339.4522.398.camel@cacharro.xalalinux.org>
1;1609;0cTo: Federico Mena Quintero <federico@novell.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62350>

On Thu, Oct 25, 2007 at 01:02:19PM -0500, Federico Mena Quintero wrote:
> On Thu, 2007-10-25 at 11:21 -0400, Theodore Tso wrote:
> 
> > And of course it's inelegant.  You just told us we were dealing with
> > CVS-brain-damaged corporate developers who can't be bothered to learn
> > about the fine points of using things the git way.
> 
> Ignore the corporate developers who use SCMs only because their company
> requires them to.  Git is not the right thing for them; some
> Eclipse-based monstrosity probably is.  It's like the horrendous
> Oracle-based expense-reporting thing we have to use at Novell; I use it
> because they make me, not because I'm particularly excited about
> reporting expenses :)

I think I misunderstand Andreas' problem statement.  What I proposed
is useful for corporate developers who are deeply confused by
branches, especially when a single working directory is constantly
jumping back and forth between several branches.  (Having the current
branch in your bash prompt is a *big* help here, but we can't count on
them having it.)

So setting up a solution where each branch gets its own working
directory is a great solution where you have some number of newbie
developers in a company that get easily confused, while still
providing advanced users the ability to use the full power of git, and
giving both the newbie and advanced users the advantages of
disconnected operations.  And, of course, hopefully some day the
newbie users will grow up to become advanced users.

Right now I suspect a number of projects who have picked hg or bzr do
so because the traditional git model is too confusing to newbie users.
So for those people, creating the model where branch == a separate
directory may make life easier for them.  That's probably the one
thing that bzr does much better than git; it has a number of modes
which act as training wheels for the easily confused user.  For
example, the bzr's "bound branch" requires you to have network access,
since anything that modifies the local repository requires hitting the
remote server as well.  Horrible!  Gives you all of the downsides of
CVS!  But it allows some users to use the SCM is CVS-style mode, while
allowing more advanced users to use it in a more distributed mode.

So I think it *is* useful to help the corporate developers, because
that means there are more git users --- and someday some of us on this
list might have to work at such a company, and better that they use
git than something like perforce or Clearcase, right?  :-)

> However, *do think* of the free software developers who have been using
> CVS forever.  You won't make friends among them if you keep saying, "you
> use CVS?  You are brain-damaged, then."  

Fair enough.  I used the term somewhat toungue-in-cheek, and I
probably should have said "newbie user" instead.

							- Ted
