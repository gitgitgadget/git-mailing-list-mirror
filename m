From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add pretty format %aN which gives the author name,
 respecting .mailmap
Date: Sat, 12 Jul 2008 00:42:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807120041300.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer>  <alpine.DEB.1.00.0807112238350.8950@racer> 
 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>  <alpine.DEB.1.00.0807112310140.8950@racer>  <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com>  <alpine.DEB.1.00.0807120000580.8950@racer>  <alpine.DEB.1.00.0807120027330.8950@racer>
 <bd6139dc0807111630j306f0225m90b501296a508552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:43:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSH5-0002Ds-Q1
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbYGKXml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbYGKXml
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:42:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:46527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751455AbYGKXmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:42:40 -0400
Received: (qmail invoked by alias); 11 Jul 2008 23:42:38 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 12 Jul 2008 01:42:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185+/9jJZM5Hyhf4mrA966+wEmaf7bzPPiKEVdoxZ
	Srh7XOg7+B/kDs
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111630j306f0225m90b501296a508552@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88205>

Hi,

On Sat, 12 Jul 2008, Sverre Rabbelier wrote:

> On Sat, Jul 12, 2008 at 1:28 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > The pretty format %an does not respect .mailmap, but gives the exact 
> > author name recorded in the commit.  Sometimes it is more desirable, 
> > however, to look if the email has another name mapped to it in 
> > .mailmap.
> >
> > This commit adds %aN (and %cN for the committer name) to do exactly 
> > that.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Whoah, that's fast ;).

Heh.  The price is that my patches are usually more buggy than other 
contributors' patches.

> I'm not sure what to do though, if I use this new %cN GitStats will
> only work with the latest git version... :(

Yes, that is correct.  But my impression was that GitStats was never meant 
as a pure add-on, but rather some integral part of Git, no?  IOW at least 
contrib/ stuff.

Ciao,
Dscho
