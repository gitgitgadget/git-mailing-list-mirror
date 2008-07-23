From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: git rebase -i and root commits
Date: Wed, 23 Jul 2008 11:05:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231103230.2830@eeepc-johanness>
References: <loom.20080723T013019-412@post.gmane.org> <20080723020232.GF5904@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Raible <raible@gmail.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 11:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLaI9-0000ot-0K
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYGWJEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYGWJEM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:04:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:40826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752389AbYGWJEK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:04:10 -0400
Received: (qmail invoked by alias); 23 Jul 2008 09:04:09 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp016) with SMTP; 23 Jul 2008 11:04:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18K1mZ8PE4KsssF4RPz7qgT0hQiFLCeK4DmZSFATF
	0AOoW3wO++3EDU
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080723020232.GF5904@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89613>

Hi,

On Wed, 23 Jul 2008, Stephan Beyer wrote:

> Eric Raible wrote:
> > My normal workflow is to create a .gitignore in my initial commit.
> > 
> > When I later realize that I've forgotten something from that file
> > I could of course just commit the changes, but I'd rather use "git rebase -i"
> > in the normal way to make myself appear smarter than I am.
> > Especially since this realization usually comes early on
> > (and certainly before publishing).
> > 
> > But rebase can't go all the way to a root ("fatal: Needed a single revision").
> 
> I think this has been fixed recently.

No, it has not.

What has been fixed is that you can cherry-pick a root commit now, not 
rebase onto nothing.

While I am somewhat sympathetic with Eric's use case, I am not sure that 
we should support it with rebase -i.

Ciao,
Dscho
