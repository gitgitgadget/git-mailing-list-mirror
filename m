From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
 add new Git::Repo API)
Date: Sun, 20 Jul 2008 15:21:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201517120.3305@eeepc-johanness>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807192254.24622.jnareb@gmail.com> <alpine.DEB.1.00.0807201233010.3305@eeepc-johanness> <20080720104935.GB10151@machine.or.cz>
 <alpine.DEB.1.00.0807201420500.3305@eeepc-johanness> <20080720125841.GD10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 15:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYrF-0003r7-Vp
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 15:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756900AbYGTNUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 09:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756876AbYGTNUu
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 09:20:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:60917 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754462AbYGTNUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 09:20:50 -0400
Received: (qmail invoked by alias); 20 Jul 2008 13:20:48 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp017) with SMTP; 20 Jul 2008 15:20:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+S3ANjT5uScCVGtaGAISngcC7FSSD6nnyueq+vPT
	zk6d5MGAt0TbMm
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080720125841.GD10151@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89201>

Hi,

On Sun, 20 Jul 2008, Petr Baudis wrote:

> On Sun, Jul 20, 2008 at 02:33:46PM +0200, Johannes Schindelin wrote:
> > On Sun, 20 Jul 2008, Petr Baudis wrote:
> > 
> > > On Sun, Jul 20, 2008 at 12:38:07PM +0200, Johannes Schindelin wrote:
> > >
> > > > Pasky tried to convert all Perl scripts at once IIRC, and my 
> > > > numerous problems just _making_ the Git scripts led me to rewrite 
> > > > a few Perl scripts in C, so I could safely exclude the Perl 
> > > > scripts from my personal fork.
> > > 
> > > I don't remember any concrete report of such problems ever reaching 
> > > me; exactly what trouble are you hitting with the Perl scripts using 
> > > Git.pm?  I will be glad to try to fix it.
> > 
> > They reached you:
> > 
> > http://article.gmane.org/gmane.comp.version-control.git/23153
> 
> running Git in-place without correctly setting the prefix is not 
> supported anyway; git wrapper will still be using non-builtin commands 
> from the prefix location instead of your fresh build.

There were none.  Anyway, because Git makes it _really_ hard to run 
in-place, I gave in.  I run Git from $HOME/bin now.

> > http://thread.gmane.org/gmane.comp.version-control.git/22764/focus=22778
> 
> It seems I fixed this right away?

That is not what I remember.  I remember that I had the next issue right 
away.  I remember that there were problems with ActiveState Perl+Cygwin. 
And I remember that the Git.xs was not merged in the end.

Anyway, this whole discussion is moot, methinks.

Let's concentrate back on the real issue: merging the two as-of-now 
incompatible Perl modules.  It really would be nice to have one pony with 
one saddle in the end, so that the use of Lea's GSoC project is not 
limited to gitweb with enabled caching.

Ciao,
Dscho
