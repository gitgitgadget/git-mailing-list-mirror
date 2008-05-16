From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 14:40:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161439100.30431@racer>
References: <482D6F41.2060809@laser-point.co.uk> <g0js1p$l22$1@ger.gmane.org> <482D7EE1.9020503@laser-point.co.uk> <g0jvig$1dn$1@ger.gmane.org> <482D8BEB.6070706@laser-point.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Paul Gardiner <paul@laser-point.co.uk>
X-From: git-owner@vger.kernel.org Fri May 16 15:41:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0BE-0004nh-Hx
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 15:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbYEPNkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbYEPNkM
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 09:40:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:48267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755231AbYEPNkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 09:40:11 -0400
Received: (qmail invoked by alias); 16 May 2008 13:40:09 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp052) with SMTP; 16 May 2008 15:40:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19e4IUPrOxeVJ1AzFzHQZIeDWbJi7nOY1Ewxf3WXU
	CJwNaJO+1YPFRr
X-X-Sender: gene099@racer
In-Reply-To: <482D8BEB.6070706@laser-point.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82286>

Hi,

On Fri, 16 May 2008, Paul Gardiner wrote:

> Michael J Gruber wrote:
> > Paul Gardiner venit, vidit, dixit 16.05.2008 14:32:
> > > Michael J Gruber wrote:
> > > > Paul Gardiner venit, vidit, dixit 16.05.2008 13:25:
> > > > > I create the initial repository with
> > > > >
> > > > >      git-clone /<full-path>/<name>.git/ <folder>
> > > > >
> > > > > That works fine, but then I can't fetch. git-fetch gives the error
> > > > > "fatal: 'origin': unable to chdir or not a git archive"
> > > > > "fatal: The remote end hung up unexpectedly"
> > > > >
> > > > > P.
> > > > Are you trying to clone a bare repository?
> > > > Or is your repo maybe at /<full-path>/<name> with a .git subdir?
> > >
> > > Yes, a bare repository.
> > 
> > Then, maybe the full list of command lines (including cd and git-fetch)
> > would be helpful in order to track this down.
> 
> Ok, sorry, thought it was probable something really obvious. Here's the
> sequence (using git version 1.5.4).
> 
> $ git-clone /big/git/paul.git/ epage
> Initialized empty Git repository in /home/paul/epage/.git/
> 719749 bolcks

Something tells me that this is not a copy/paste ;-)

> $ cd epage
> $ git-fetch
> fatal: 'origin': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly

Is there a "[remote "origin"]" section in .git/config?  What Git version 
is this, anyway?

Ciao,
Dscho
