From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 21:20:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807272116030.5526@eeepc-johanness>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>  <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>  <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>  <20080727183309.GD32184@machine.or.cz>
 <9e4733910807271207o2e18cef1h869c659bd0ae31ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 21:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNBnN-0003uy-VI
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 21:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518AbYG0TTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757508AbYG0TTk
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 15:19:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:46519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757239AbYG0TTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 15:19:39 -0400
Received: (qmail invoked by alias); 27 Jul 2008 19:19:37 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp001) with SMTP; 27 Jul 2008 21:19:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/B8K1wfMnBnGHjCX+Sa4QdHE14LfbAgbN6ZcH/mj
	z05a26V+BNAlah
X-X-Sender: user@eeepc-johanness
In-Reply-To: <9e4733910807271207o2e18cef1h869c659bd0ae31ba@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90358>

Hi,

On Sun, 27 Jul 2008, Jon Smirl wrote:

> On 7/27/08, Petr Baudis <pasky@suse.cz> wrote:
> > On Sun, Jul 27, 2008 at 02:16:30PM -0400, Jon Smirl wrote:
> >  > On 7/27/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > > Something like .mailmap?
> >  > >
> >  > >  And to show the mapped author name instead of the committed one, you would
> >  > >  use "--pretty=format:%aN"?  (Needs 1.6.0-rc0 at least, IIRC)
> >  >
> >  > So we can already do this? Where is a .mailmap for the kernel tree?
> >
> >         http://repo.or.cz/w/linux-2.6.git?a=blob;f=.mailmap
> >
> >  ...right there. :-)
> 
> I updated to 1.6.0-rc0 and this is working. mailmap needs some
> cleanup. Errors are still in the list, but this is a lot better than
> it was. That made about 800 'contributors' disappear.
> 
> Is there a way to do short log and have it map the names?

Yes, as of v1.6.0-rc0~58 you can pass --pretty=format: to shortlog.

> What about replacing the emails with their current email address?

Nope, that was never meant to be done.

Ciao,
Dscho
