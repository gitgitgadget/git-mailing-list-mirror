From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 11:59:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061154310.4362@racer.site>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
 <20071105234049.GA31277@genesis.frugalware.org>
 <3abd05a90711052016s615cd66cy5a5f932900d89143@mail.gmail.com>
 <176851C5-D735-4DDC-B799-A5106CD03989@lrde.epita.fr> <20071106073455.GA19106@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpN6X-0007hA-7Z
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281AbXKFMAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbXKFMAF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:00:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:56520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756177AbXKFMAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:00:04 -0500
Received: (qmail invoked by alias); 06 Nov 2007 12:00:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 06 Nov 2007 13:00:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+EsqZaH9iEFkglEiutRKYojreXI6jSQFC1hmYfRw
	ykysqbQL9VOSxE
X-X-Sender: gene099@racer.site
In-Reply-To: <20071106073455.GA19106@ins.uni-bonn.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63663>

Hi,

On Tue, 6 Nov 2007, Ralf Wildenhues wrote:

> * Benoit Sigoure wrote on Tue, Nov 06, 2007 at 06:29:58AM CET:
> > On Nov 6, 2007, at 5:16 AM, Aghiles wrote:
> >
> >>> who will run git stash clear? :)
> >>
> >> Yes you are right. By the way, in the context of merging into a
> >> dirty tree, "git stash clear" seems to be a dangerous command:
> >> there is a risk of loosing all your changes without a question
> >> asked!
> 
> I would love it if for once in the git world, there were a pair of
> commands that would do the exact opposite of each other and where the
> naive newbie (me) would immediately recognize that from their names:
>   git stash push
>   git stash pop
> 
> Both applied in this order should be a no-op on both the working tree,
> the index, and also the stash.  There's room for extensions (pop
> --keep-stash to not remove the stashed information), explicit naming of
> stashes, doing multiple pops at once, and so on.  Please don't add more
> of the git-push/git-pull, git-add/git-rm unsymmetrical interfaces.
> Even if they're perfectly clear to git intimates, each one of them
> takes precious extra time to learn due to this lack of symmetry.
> 
> Since I simply don't have the time resources to just implement that, 
> I'll thank you for your attention and go back to lurking mode now.

You might as well be honest, and say that they are not time constraints, 
but lack of motivation. There is -- still! -- the patch "Teach "git 
reflog" a subcommand to delete single entries" in "pu" to delete 
single reflogs (and being in "pu" means it is only a fetch and a 
cherry-pick away).

Implementing that feature would be a piece of cake, but I will not do it, 
since _you_ want it, not _I_.  In spite of that, I implemented that reflog 
deleting, which was the hardest part of the exercise.

So, out, out with you, out of lurking mode!

Ciao,
Dscho
