From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Mon, 22 Mar 2010 12:33:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003221231540.7596@pacific.mpi-cbg.de>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com>  <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>  <alpine.LNX.2.00.1003212011280.14365@iabervon.org> <201003220341.38918.chriscool@tuxfamily.org>
 <f3271551003212049r1139d6b4x279c6803cc4c7fe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 12:34:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtftW-0001qG-Ka
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 12:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0CVLeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 07:34:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:45206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754370Ab0CVLd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 07:33:59 -0400
Received: (qmail invoked by alias); 22 Mar 2010 11:33:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 22 Mar 2010 12:33:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JtFVPiOHJWPIX9KZZp7FLYfpskHtheKpGSkkwNH
	ugd4KR0n5bqan6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <f3271551003212049r1139d6b4x279c6803cc4c7fe2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142923>

Hi Ram,

On Mon, 22 Mar 2010, Ramkumar Ramachandra wrote:

> > Don't know about importer modes, but in native connection mode it is 
> > possible to avoid calling or linking to git in any way (been there, 
> > done that).
> 
> > Mostly, except that I think it should be possible to avoid having 
> > git-remote-svn actually link to the git core, because the git core 
> > should be taking care of everything git-specific for you. Of course, 
> > the git core also provides a bunch of useful C library code that you 
> > may want to use, such as a nice string buffer implementation, so you 
> > may want to link to git even if you don't actually need it, if 
> > licenses are suitable and it would be convenient.
> 
> As of this point, I'm undecided about which parts of Git Core to link 
> to, if at all. I'll try to avoid linking, but I'll do whatever is most 
> convenient within the bounds of the license as I write the remote 
> helper.

AFAICT the git-remote idea is to use a text protocol (which may lend 
itself to be copied by Mercurial at some stage, a clear sign that we did 
something well when that happens).

> > Because it's much better for everyone at the end of the GSoC if only 
> > half of the project is finished but merged, rather than if all the 
> > project is "finished" but nothing can be merged.
> 
> Right. I'll merge the whole thing in 3-4 phases then.

I am sure that Sverre will be of tremendous help to decide when is the 
opportune moment to show off your code.

Ciao,
Dscho
