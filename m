From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git tutorial
Date: Thu, 22 May 2008 10:35:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221030380.30431@racer>
References: <dc5b80bf0805210942l388c4439g84b8a6b02346ebe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ian Katz <ifreecarve@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 11:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz7E6-00074f-BB
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 11:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932795AbYEVJfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 05:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbYEVJfm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 05:35:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:43702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932795AbYEVJfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 05:35:40 -0400
Received: (qmail invoked by alias); 22 May 2008 09:35:39 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp046) with SMTP; 22 May 2008 11:35:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++1CsXht2+yK07Kd7KSAezTGRNh1VDyOYqAMnicJ
	lc6ebl+C/o8foh
X-X-Sender: gene099@racer
In-Reply-To: <dc5b80bf0805210942l388c4439g84b8a6b02346ebe8@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82608>

Hi,

On Wed, 21 May 2008, Ian Katz wrote:

> I have a suggestion/request for the git documentation (tutorial),
> currently accessible from:
> http://www.kernel.org/pub/software/scm/git/docs/tutorial.html
> 
> It would be much easier to understand the "Using git for
> collaboration" section if you put the username (bob or alice) as a
> prefix to each of the example command prompts, as is common in most
> linux distributions.  This would make it easier to see at a glance who
> is doing what.
> 
> In other words, it would change from this:
> $ git clone /home/alice/project myrepo
> $ git pull /home/bob/myrepo master
> 
> to this:
> bob$ git clone /home/alice/project myrepo
> alice$ git pull /home/bob/myrepo master
> 
> In the tutorial's current form, I spent so much time looking back into
> the paragraph text to find out who was typing each command that I
> eventually printed it out so I could scribble their names on each one.

This is a good change, yes.

> I hope this change isn't a big deal.

Hey, why don't you give it a try?

Just

Ian$ git clone git://git.kernel.org/pub/scm/git/git.git
Ian$ cd git
Ian$ $EDITOR Documentation/tutorial.txt
	# make the suggested changes

Ian$ git config user.name "Ian Katz"
Ian$ git config user.email ifreecarve@gmail.com
Ian$ git commit -s Documentation/tutorial.txt
	# write a nice oneline description, such as
	#    tutorial: prefix the prompts with the names "alice" or "bob"
	# then an empty line and then a paragraph as to why you like this
	# change

Ian$ git format-patch -1
	# then send the file 0001-*.patch, but inline, please

Hmm?

Ciao,
Dscho
