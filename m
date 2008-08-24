From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: About git pretty
Date: Sun, 24 Aug 2008 19:49:58 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808241948390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>  <20080823000336.GB14684@leksak.fem-net> <94a0d4530808231157y3d36fc23q4617787214a02ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 19:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJfA-00088T-OG
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYHXRo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbYHXRo7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:44:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:55346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751884AbYHXRo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:44:58 -0400
Received: (qmail invoked by alias); 24 Aug 2008 17:44:56 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 24 Aug 2008 19:44:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qArQF145qrqyTxiGRVQvYbrogllxOhd28p/JEip
	yKYkrw/aPKJk6V
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <94a0d4530808231157y3d36fc23q4617787214a02ea1@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93540>

Hi,

On Sat, 23 Aug 2008, Felipe Contreras wrote:

> On Sat, Aug 23, 2008 at 3:03 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> > Felipe Contreras wrote:
> >> Hi,
> >>
> >> Please read aloud the following commands:
> >> git log --pretty=short
> >> git log --pretty=full
> >> git log --pretty=format:%s
> >>
> >> It is just me or 'pretty full' doesn't exactly convey the meaning of 
> >> the action to execute?
> >
> > But "pretty short" and "pretty format" is. :)
> >
> >> How about:
> >> git log --format=short
> >> git log --format=full
> >> git log --format=custom:%s
> >>
> >> If you like the idea I can work on a patch.
> >
> > Because --pretty=<format> is an option taken by many git commands 
> > including git plumbing (e.g. rev-list), many scripts will rely on 
> > "--pretty" and they all would have to be changed. And --pretty exists 
> > since Jan 2005 (see 9d97aa64).
> 
> Well, it might be difficult, but that doesn't mean it should not be 
> done. Just like the 'git-*' removal, there could be a period for 
> transition.

Of course it could be done.  But I do not deem it necessary.  In the 
balance gain/pain it comes out as not worth the hassle on this guy's 
calculator.

Ciao,
Dscho
