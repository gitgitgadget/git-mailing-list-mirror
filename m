From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 14:33:33 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271408290.9925@racer>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCE8A-0001ZC-Nx
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043AbYF0Nff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759086AbYF0Nff
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:35:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:43106 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759043AbYF0Nfe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:35:34 -0400
Received: (qmail invoked by alias); 27 Jun 2008 13:35:31 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp004) with SMTP; 27 Jun 2008 15:35:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++B0NCHiu+/6nTR1uafc1/I+HQzFgF1E9L6+UNFq
	I06IVAESR/RCFO
X-X-Sender: gene099@racer
In-Reply-To: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86560>

Hi,

On Thu, 26 Jun 2008, Robert Anderson wrote:

> Seems to me the concept of the "index" is a half-baked version of what
> I really want, which is the ability to factor a working tree's changes
> into its constituent parts in preparation for committing them.

Half-baked is probably too strong a word.

What you are basically asking for is to have the working directory 
as staging area, and to be able to stash away changes that are not to be 
committed.

Now, this is not necessarily what everybody wants, which is why many 
people are fine with the index.

Having said that, I played with the idea of a "git stash -i", which would 
allow you to select the changes to stash away.  (And by extension, "git 
stash -e" using the "git add -e" command.)

Hmm?

Ciao,
Dscho
