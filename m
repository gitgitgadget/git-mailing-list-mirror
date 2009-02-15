From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Mon, 16 Feb 2009 00:18:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902160016230.10279@pacific.mpi-cbg.de>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 00:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqGC-0002kt-O2
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbZBOXR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbZBOXRZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:17:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:39779 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753963AbZBOXRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:17:24 -0500
Received: (qmail invoked by alias); 15 Feb 2009 23:17:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 16 Feb 2009 00:17:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18+fTg9fkI+oY6tEvGPoYa65X3TwoMqtKVR3AJmmd
	Rocm+yh4ReynKL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110084>

Hi,

On Sun, 15 Feb 2009, david@lang.hm wrote:

> On Mon, 16 Feb 2009, Johannes Schindelin wrote:
> 
> > On Sun, 15 Feb 2009, david@lang.hm wrote:
> >
> > > On Sun, 15 Feb 2009, Junio C Hamano wrote:
> > >
> > > > Thanks.
> > > >
> > > > * git-push to update the checked out branch will be refused by default
> > > >
> > > >  Make "git push" into a repository to update the branch that is checked
> > > >  out fail by default.
> > > >
> > > >  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> > >
> > > If I understand this one, it will cause grief for quite a few people.
> > >
> > > I have a public repository that I push to and then have a trigger that
> > > checks
> > > out the current version, compiles it, publishes the compiled version,
> > > sends an
> > > announcement, etc
> >
> > So you have to set a config variable.  Big deal.
> >
> > Compared to that, the thousands of new Git users will no longer be bitten
> > by the "do not push to a non-bare repository" issue without a useful error
> > message.
> >
> > Please, please, publicize that if there is somebody who is doing the same
> > as you (which I deem a dangerous workflow; I certainly do not use it
> > myself) that they will have to adjust their receive.denyCurrentBranch
> > variable.
> 
> since this repository isn't use for anything other than publishing for public
> access, what's so dangerous about it?

Hey, you do what you want...

I just keep in mind that it _is_ a working directory that can go dirty, 
for whatever reasons.

Which is why _I_ do things like your workflow locally, even if that means 
that I log onto another machine (which is then "local").

But again, it is your choice.  And certainly, it will be possible in the 
future, too, just more deprecated than it is already.

Ciao,
Dscho
