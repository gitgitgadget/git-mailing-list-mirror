From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: making a branch with just one file and keeping its whole
 history
Date: Mon, 21 Jul 2008 19:39:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807211937390.8986@racer>
References: <20080721061804.223f7801@mail.tin.it>  <loom.20080721T161926-61@post.gmane.org>  <alpine.DEB.1.00.0807211907270.8986@racer> <279b37b20807211122w3a1e0687wc84693bd95689326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 20:40:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0JS-0002PT-SN
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 20:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbYGUSjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 14:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbYGUSjq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 14:39:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:46379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751899AbYGUSjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 14:39:46 -0400
Received: (qmail invoked by alias); 21 Jul 2008 18:39:44 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp049) with SMTP; 21 Jul 2008 20:39:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1f7hfjxS16zjXJB6NyIalL7vS5XPuw6M4/BNU1l
	cUfLSUi7zn8en8
X-X-Sender: gene099@racer
In-Reply-To: <279b37b20807211122w3a1e0687wc84693bd95689326@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89383>

Hi,

On Mon, 21 Jul 2008, Eric Raible wrote:

> On Mon, Jul 21, 2008 at 11:08 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 21 Jul 2008, Eric Raible wrote:
> >
> >> http://www.gitcasts.com/posts/empty-branches
> >
> > Beware!  This is one of the sites that triggered my mail about considering
> > teaching plumbing to new users harmful.
> >
> > In other words, I think that these "git casts" are not really the best way
> > to teach Git to new users, but rather confusing.
> >
> > Which is a pity, because they are nicely done otherwise.
> 
> I understand your concern, but if you treat that particular gitcast 
> simple as a recipe to be followed it accomplishes the goal in the in the 
> most straightforward way I've seen.

Note, I haven't even bothered to watch that Gitcast, since it would make 
me mad again.

> A new-user pure-porcelain way would be to branch then delete all of the 
> files in the branch.  Which seems a bit dirty to me.

This will not start a new branch, which is what I presume you want to do.  
The "correct" (as in: probably the best) way to do it is to make a new 
directory, initialize a new git repository in it, and when you have 
something, push that branch into the other repository.

However, I think that the OP was talking about something completely 
different: extracting the history of a single file as a new branch.

Ciao,
Dscho
