From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git
 repository
Date: Sat, 12 Jul 2008 00:02:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807120000580.8950@racer>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>  <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>  <alpine.DEB.1.00.0807112215050.8950@racer>  <alpine.DEB.1.00.0807112238350.8950@racer> 
 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>  <alpine.DEB.1.00.0807112310140.8950@racer> <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	David Symonds <dsymonds@gmail.com>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:03:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHReN-00026i-Uk
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbYGKXCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755912AbYGKXCb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:02:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:60664 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755172AbYGKXCb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:02:31 -0400
Received: (qmail invoked by alias); 11 Jul 2008 23:02:29 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp054) with SMTP; 12 Jul 2008 01:02:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EfH8y6M8EAOlrpyMmO0FyWiwN6UylzKsO+GLZut
	VFbLcidaO3BhL8
X-X-Sender: gene099@racer
In-Reply-To: <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88196>

Hi,

On Sat, 12 Jul 2008, Sverre Rabbelier wrote:

> On Sat, Jul 12, 2008 at 12:11 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > The mechanism is this: you look up the email in .mailmap (actually you
> > parse that once, but the idea stays the same), and if there is a name for
> > it, you use that _instead of_ the given author name.
> 
> Ah, so you suggest changing "format:%ae" to "format:%ae %an" and
> falling back to the latter id specified on that line if the former is
> not in .mailmap? That would work I guess, I'll put it on my TODO list
> :).

Hmm.  I missed the fact that you used pretty formats.  Seems like %an does 
not respect .mailmap; I'm on it.

Ciao,
Dscho
