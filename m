From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-add--interactive: manual hunk editing mode v2
Date: Mon, 9 Jun 2008 00:02:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090001090.1783@racer>
References: <200805232221.45406.trast@student.ethz.ch> <20080606051026.GA18257@sigill.intra.peff.net> <alpine.DEB.1.00.0806061528270.1783@racer> <200806090018.48784.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5TwL-0004Jw-Kt
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626AbYFHXDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbYFHXDw
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:03:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:46723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755347AbYFHXDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:03:52 -0400
Received: (qmail invoked by alias); 08 Jun 2008 23:03:50 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 09 Jun 2008 01:03:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wTrJerfVwWqfx9DK0bEHGLzp41Oqci3k4RUrkZU
	xDmsGVQflr++6t
X-X-Sender: gene099@racer
In-Reply-To: <200806090018.48784.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84340>

Hi,

On Mon, 9 Jun 2008, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > 
> > On Fri, 6 Jun 2008, Jeff King wrote:
> > >   2. It's not integrated into the git-add--interactive loop at all. 
> > >      That is, I don't start out saying "I want to edit this diff." I 
> > >      look at the diff while staging with "git add -p" and say "Oops, 
> > >      I need to edit this hunk." So I think it is better implemented 
> > >      as an "e"  option in the hunk adding loop, with "git add -e" as 
> > >      a shortcut.  Or maybe there is simply room for both (and "git 
> > >      add -e", rather than being a shortcut, just means "do this on 
> > >      the _whole_ file").
> > 
> > This is very much on purpose.  I do not like "git add -i" at all.  It 
> > limits my work unduly.  That's why I tried to change the hunk editing 
> > in git-gui once upon a time, but I never got round to fix that, and it 
> > does not work well with ssh either.
> > 
> > So no, I do not want to use that perl script with that menu.  I want 
> > to have the raw diff in a raw editor, where I can change the things I 
> > need to change.
> 
> While there is obviously little point in trying to convince you,

Oh, sorry, I really meant the "I do not want" literally.  It is just me.  
That does not mean that your hunk editing from within add -i has no merit.  
It's just that this guy is not very interested in that feature.

Ciao,
Dscho
