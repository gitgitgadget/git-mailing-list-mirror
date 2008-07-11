From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Fri, 11 Jul 2008 23:11:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112310140.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer>  <alpine.DEB.1.00.0807112238350.8950@racer>
 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQqr-0006eC-PO
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbYGKWLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbYGKWLc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:11:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:57860 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755580AbYGKWLc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:11:32 -0400
Received: (qmail invoked by alias); 11 Jul 2008 22:11:30 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp006) with SMTP; 12 Jul 2008 00:11:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OkctoGemOoYxwA+4m5mTuDxdn5iAe+oF2spT9RU
	Skk35qmJwHa0+p
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88189>

Hi,

On Fri, 11 Jul 2008, Sverre Rabbelier wrote:

> On Fri, Jul 11, 2008 at 11:39 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > something else I just realized: you might want to use .mailmap, e.g. 
> > to coalesce the changes of Shawn "O." Pearce correctly.
> 
> Ah, hmmm, but I'm not sure how, as not nearly every developer is in
> the .mailmap file and many devs use different e-mails while most use
> the same name. A similar file containing developer aliases maybe?
> E.g.:
> "Shawn Pearce = Shawn O. Pearce"?

The mechanism is this: you look up the email in .mailmap (actually you 
parse that once, but the idea stays the same), and if there is a name for 
it, you use that _instead of_ the given author name.

Otherwise you use the given author name, and typos be damned.

Ciao,
Dscho
