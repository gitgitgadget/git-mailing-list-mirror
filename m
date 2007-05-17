From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 01:52:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705170152470.6410@racer.site>
References: <20070515201006.GD3653@efreet.light.src> 
 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> 
 <Pine.LNX.4.64.0705161232120.6410@racer.site>
 <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 02:53:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoUEs-0007ik-J2
	for gcvg-git@gmane.org; Thu, 17 May 2007 02:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbXEQAxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 20:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755753AbXEQAxA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 20:53:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:46753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755334AbXEQAw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 20:52:59 -0400
Received: (qmail invoked by alias); 17 May 2007 00:52:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 17 May 2007 02:52:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3K+h2HKG3J+ingg0j5Thk9c96hMWDy3jLS1tTna
	8WReIz+4w8sotv
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47473>

Hi,

On Thu, 17 May 2007, Martin Langhoff wrote:

> On 5/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 16 May 2007, Martin Langhoff wrote:
> > > Do the indexes have enough info to use them with http ranges? It'd be
> > > chunkier than a smart protocol, but it'd still work with dumb servers.
> > It would not be really performant, would it? Besides, not all Web servers
> > speak HTTP/1.1...
> 
> Performant compared to downloading a huge packfile to get 10% of it?
> Sure! It'd probably take a few trips, and you'd end up fetching 20% of
> the file, still better than 100%.

Don't forget that those 10% probably do not do you the favour to be in 
large chunks. Chances are that _every_ _single_ wanted object is separate 
from the others.

> > Besides, not all Web servers speak HTTP/1.1...
> 
> Are there any interesting webservers out there that don't? Hand-rolled 
> purpose-built webservers often don't but those don't serve files, they 
> serve web apps. When it comes to serving files, any webserver that is 
> supported (security-wise) these days is HTTP/1.1.
> 
> And for services like SF.net it'd be a safe low-cpu way of serving git
> files. 'cause the git protocol is quite expensive server-side (io+cpu)
> as we've seen with kernel.org. Being really smart with a cgi is
> probably going to be expensive too.

It's probably better and faster than relying on a feature which does not 
exactly help.

Ciao,
Dscho
