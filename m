From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 23 Jul 2008 17:07:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231706520.8986@racer>
References: <200807231544.23472.litvinov2004@gmail.com>  <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>  <200807231852.10206.litvinov2004@gmail.com>  <alpine.DEB.1.00.0807231356540.8986@racer>
 <32541b130807230849t42b491b9jf1d6f31bcdd50dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:10:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgtD-0004D7-1q
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbYGWQHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYGWQHb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:07:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:32826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751797AbYGWQHa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:07:30 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:07:29 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp016) with SMTP; 23 Jul 2008 18:07:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+F9cs31JSFbVcCs9u5+eULOpl/cwJtT06f51SFF8
	uJnio8JvT1fLIr
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807230849t42b491b9jf1d6f31bcdd50dac@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89696>

Hi,

On Wed, 23 Jul 2008, Avery Pennarun wrote:

> On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  On Wed, 23 Jul 2008, Alexander Litvinov wrote:
> >  > > On Wed, 23 Jul 2008, Alexander Litvinov wrote:
> >  > > > In short: I can't clone svn repo into git when crlf convertion 
> >  > > > is activated.
> >  > >
> >  > > This is a known issue, but since nobody with that itch seems to 
> >  > > care enough to fix it, I doubt it will ever be fixed.
> >  >
> >  > That is a bad news for me. Anyway I will spend some time at 
> >  > holidays during digging this bug.
> >
> > Note that you will have to do your digging using msysGit (i.e. the 
> > developer's pack, not the installer for plain Git), since git-svn will 
> > be removed from the next official "Windows Git" release, due to lack 
> > of fixers.
> 
> Presumably cygwin git will work too, right?

Yes.

> Does this known issue apply only to msysGit, or both msys and Cygwin, or 
> all versions?  ie. could it be debugged on Linux?

You mean the crlf vs git-svn issue?  No, yes, yes, yes, and yes.

Ciao,
Dscho
