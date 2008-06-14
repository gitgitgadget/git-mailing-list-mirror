From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Mercurial to git converter.
Date: Sat, 14 Jun 2008 16:53:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806141648020.6439@racer>
References: <1168537766.22649.19.camel@localhost.localdomain> <loom.20080614T101342-542@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 17:55:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Y6g-00012t-98
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 17:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbYFNPyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbYFNPyw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 11:54:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:52229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752420AbYFNPyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 11:54:51 -0400
Received: (qmail invoked by alias); 14 Jun 2008 15:54:49 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 14 Jun 2008 17:54:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tbbB2/A4tEXSRlKJ7nzmnKS9rAwJkmGBuhMjw6A
	I//O74cPsgJMZ2
X-X-Sender: gene099@racer
In-Reply-To: <loom.20080614T101342-542@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85021>

Hi,

On Sat, 14 Jun 2008, Nick Andrew wrote:

> Stelian Pop <stelian <at> popies.net> writes:
> 
> > I switched recently from Mercurial to git for some of my projects, and
> > needed a conversion tool with branch support (unlike tailor). I didn't
> > find any, so I ended up writing my own one. 
> > 
> > hg-to-git.py can probably be greatly improved (it's a rather crude 
> > combination of shell and python) but it does already work quite well 
> > for me. [...]
> 
> Thanks for that. One small problem is that it does not get the changelog 
> right if a commit is made on a local branch. It thinks the "branch:" 
> line is part of the changelog.

FWIW I switched my local mercurial2git conversion to the hg-fast-export 
solution from 

	git://repo.or.cz/fast-export.git

Even if it's documentation leaves almost completely to be desired, after 
figuring out how to operate it by reading the source, it works pretty 
nicely, and fast, because it uses fast-import.

Originally, I did not try it because I thought it cannot operate in 
incremental mode, but it can.

Ciao,
Dscho
