From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom
 merge strategy
Date: Mon, 28 Jul 2008 20:09:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807282008470.8986@racer>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com> <20080728185604.GA26322@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 21:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNY7Y-0000tS-0O
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 21:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbYG1TJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 15:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbYG1TJ5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 15:09:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:45494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751158AbYG1TJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 15:09:56 -0400
Received: (qmail invoked by alias); 28 Jul 2008 19:09:55 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp054) with SMTP; 28 Jul 2008 21:09:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vj4FpfmUvQ4dxl0/CRtp2CtHW/CRFN6Ap4uJ/5k
	GwUkoIRM8mr2Mh
X-X-Sender: gene099@racer
In-Reply-To: <20080728185604.GA26322@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90487>

Hi,

On Mon, 28 Jul 2008, Jeff King wrote:

> On Mon, Jul 28, 2008 at 04:54:17PM +0200, Sverre Rabbelier wrote:
> 
> > Thus resulting in a 'wrong way around' merge as part of master? It
> > would say "Merge branch 'master' into otherbranch", while what
> > happened was "Merge branch 'otherbranch' into master".
> > 
> > So, in short: what does the list think about adding
> > "git-merge-theirs", that does (although possibly less 'hackish'):
> > 
> > cat > git-merge-theirs << EOF
> > #!/bin/sh
> > eval git read-tree --reset -u \\\$\$#
> > EOF
> 
> I ran into this exact situation while showing somebody how awesome git
> was, and it was a little embarrasing to say "oops, now we have to do
> this backwards."

Well, I have to say that the workflow is a bit backwards if the person who 
_publishes_ the thing is the one saying "Ooops, my version no goodie, 
other version please, but so that pull still works".

I would have expected the one who has the good version to make the choice.

Ciao,
Dscho
