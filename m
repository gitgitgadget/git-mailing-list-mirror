From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: cogito and remote#branch, was Re: [PATCH] Git homepage: remove all
 the references to Cogito
Date: Tue, 16 Oct 2007 11:49:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161139530.25221@racer.site>
References: <20071015233800.6306e414@paolo-desktop> <20071016021933.GH12156@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihk0C-0002uO-5u
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbXJPKuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 06:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757355AbXJPKuI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:50:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:46331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757313AbXJPKuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:50:06 -0400
Received: (qmail invoked by alias); 16 Oct 2007 10:50:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 16 Oct 2007 12:50:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18k2AQNoHgkcCq8RNvKB2rAv7tSciCip9sPx0vPed
	pbVDk/OviDcroj
X-X-Sender: gene099@racer.site
In-Reply-To: <20071016021933.GH12156@machine.or.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61141>

Hi,

On Tue, 16 Oct 2007, Petr Baudis wrote:

> On Mon, Oct 15, 2007 at 11:38:00PM +0200, Paolo Ciarrocchi wrote:
> > @@ -286,15 +285,6 @@ a gitweb interface, at <a href="http://repo.or.cz/">http://repo.or.cz/</a>.</p>
> >  
> >  <dl>
> >  
> > -<dt id="cogito">Cogito</dt>
> > -<dd>
> > -<a href="http://git.or.cz/cogito/">Cogito</a>
> > -is a popular version control system on top of Git.
> > -It aims at seamless user interface and ease of use, providing
> > -generally smoother user experience than the "raw" Git interface
> > -and indeed also many other version control systems. However, it
> > -also lacks many advanced capabilities of Git and is currently
> > -being slowly phased out.</dd>
> >  
> >  <dt id="stgit">StGIT</dt>
> >  <dd><a href="http://www.procode.org/stgit/">Stacked Git</a> provides
> 
> I'm not sure this is good idea, Cogito is still quite frequently used
> and it should be documented that it exists.

I agree.  But maybe it could be marked as unmaintained?  Maybe someone 
steps up to maintain it.  Or, even better, comes up with a list of "this 
is what I like do regularly with cogito, but there's no easy way with core 
git" issues.

In related news, I recently thought about the url#branch issue.

There were three arguments against it AFAIR: "#" is a comment marker, and 
this syntax is not extensible to more than one branch names.  And that the 
branch name is not really a part of the URL.

Turns out that I am not so sure about the last two issues.

It is easily extensible to more than one branch by remote#branch1#branch2, 
and in a very real sense, this is a resource locator.

And we could replace the "#" by every character that is illegal in ref 
names as well as URLs.  I propose SPC.  ('#' is allowed in refnames.)

Ciao,
Dscho
