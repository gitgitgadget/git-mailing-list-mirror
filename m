From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 18:09:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708171808340.20400@racer.site>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site>
 <20070817165655.GA13891@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5KI-00026g-6a
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbXHQRJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbXHQRJa
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:09:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:53202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753827AbXHQRJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:09:29 -0400
Received: (qmail invoked by alias); 17 Aug 2007 17:09:28 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp002) with SMTP; 17 Aug 2007 19:09:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19p421Tx4hpm3iPnYcQ8X4KXX5ilFIQrhfVZJMsh2
	I0vFK5Yx0CqEwA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070817165655.GA13891@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56068>

Hi,

On Fri, 17 Aug 2007, Mike Hommey wrote:

> On Fri, Aug 17, 2007 at 05:52:52PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Fri, 17 Aug 2007, Mike Hommey wrote:
> > 
> > >   ?   committer name and email and the commit time.
> > >   If not provided, "git-commit-tree" uses your name, hostname and domain to
> > >   provide author and committer info. This can be overridden by either
> > >   .git/config file, or using the following environment variables.
> > >   (...)
> > > 
> > > The "If not provided" part doesn't make sense.
> > 
> > It does, if you know how to specify the committer info.  Which the man 
> > page specifies how to provide:
> > 
> > This can be overridden by either `.git/config` file, or using the 
> > following environment variables.
> > 
> >         GIT_AUTHOR_NAME
> >         GIT_AUTHOR_EMAIL
> >         GIT_AUTHOR_DATE
> >         GIT_COMMITTER_NAME
> >         GIT_COMMITTER_EMAIL
> >         GIT_COMMITTER_DATE
> >         EMAIL
> 
> This is exactly where the man page doesn't make sense to me. It tells
> you that if you don't provide committer name, etc. it uses your name,
> hostname, etc., and you can override this with .git/config or the
> environment variable you listed.
> 
> So where were you supposed to provide these informations in the first
> place ?

In /etc/passwd.  Like on every Unix system.  (Oh yeah, there is NIS and 
other things, but in effect it is the same system.)

Ciao,
Dscho
