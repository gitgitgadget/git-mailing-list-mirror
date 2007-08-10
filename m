From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysgit: does git gui work?
Date: Fri, 10 Aug 2007 14:53:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708101452060.21857@racer.site>
References: <3CD6111C-13B5-444C-A28C-A7445C8A199B@zib.de>
 <E886F099-5E9F-4785-A560-F9AAAA4E4C1F@zib.de> <20070810053158.GJ24573@spearce.org>
 <B6C82889-ABE0-4B3D-A455-A2EE1CE48297@zib.de> <Pine.LNX.4.64.0708101113380.21857@racer.site>
 <3351C69E-C0A8-4D02-9E04-085E18F1DF75@zib.de> <Pine.LNX.4.64.0708101309430.21857@racer.site>
 <31EFF30A-CC7A-4BB0-B083-13A1F7B62781@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 15:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJUwx-000156-A8
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 15:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbXHJNyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 09:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbXHJNyn
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 09:54:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:55816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932126AbXHJNym (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 09:54:42 -0400
Received: (qmail invoked by alias); 10 Aug 2007 13:54:40 -0000
Received: from ppp-82-135-86-56.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.86.56]
  by mail.gmx.net (mp047) with SMTP; 10 Aug 2007 15:54:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9kIZIf4S90POTtIhtiYRr9BqkjcAnS53GifiwZB
	EMMX+d6AWyjnG+
X-X-Sender: gene099@racer.site
In-Reply-To: <31EFF30A-CC7A-4BB0-B083-13A1F7B62781@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55538>

Hi,

On Fri, 10 Aug 2007, Steffen Prohaska wrote:

> On Aug 10, 2007, at 2:13 PM, Johannes Schindelin wrote:
> 
> > On Fri, 10 Aug 2007, Steffen Prohaska wrote:
> > 
> > > On Aug 10, 2007, at 12:16 PM, Johannes Schindelin wrote:
> > > 
> > > > On Fri, 10 Aug 2007, Steffen Prohaska wrote:
> > > 
> > > I agree and pushed the following to mob
> > > 
> > > faeb4e3df9fb7c853dd1a46d6942776d4a743545
> > > 
> > > I forced a non-fast-forward of mob. Is this ok? Apparently it's allowed.
> > 
> > Yes, it is allowed exactly for this purpose.  When you want to redo/undo
> > commits.
> > 
> > > Another question related to mob. How do I need to setup /git/.git/config
> > > to be able to push to git's mob?
> > 
> > My understanding is that the GitMe installer already sets up a remote
> > named "mob".
> > 
> > 	$ git push mob
> > 
> > It automatically pushes the "master" branch to "mob".  If you have to
> > force the push, you'll have to do this:
> > 
> > 	$ git push mob +master:mob
> > 
> > But please avoid this when possible, since you might well overwrite other
> > people's work.
> 
> I have a mob for /.git, but I do not have the setup for /git/.git. Maybe
> I deleted it because I didn't understand what is means.

Ah, I misunderstood.  Yes, it is quite possible to have a mob installed 
for 4msysgit.git by default.  Should by done in 
msysgit.git:share/GitMe/setup-msysgit.sh.

> Whoever has setup the mob configurations, maybe it would be a good idea 
> to forbid non-fast-forward but instead allow the creation of new mob* 
> branches. If I can't push to mob, I could push to mob-topic instead. 
> Cleanup would be in the responsibility of the repository owner.

This is not possible.  The refusal of a non-fast-forward is a per-repo, 
not a per-user, configuration.

Ciao,
Dscho
