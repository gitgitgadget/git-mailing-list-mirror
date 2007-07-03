From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Starting 1.5.3 stabilization cycle
Date: Tue, 3 Jul 2007 19:27:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031923180.4071@racer.site>
References: <7v8x9yrllv.fsf@assigned-by-dhcp.cox.net> <20070703181428.GD4580@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:28:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5n6Z-0005z8-BC
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 20:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbXGCS2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 14:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbXGCS2A
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 14:28:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:50574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755516AbXGCS17 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 14:27:59 -0400
Received: (qmail invoked by alias); 03 Jul 2007 18:27:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 03 Jul 2007 20:27:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DMJ4gZWkDJOqf+LSUxNwN7uWTfJxl6UvSGkwxTE
	KXhjp92CHnGW9k
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703181428.GD4580@xp.machine.xx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51521>

Hi,

On Tue, 3 Jul 2007, Peter Baumann wrote:

> On Tue, Jul 03, 2007 at 12:29:32AM -0700, Junio C Hamano wrote:
> 
> >   - "git rebase" learned an "interactive" mode.
> 
> Short describtion missing?

s/b/p/ ;-)

> 	This is meant for reordering the commits, merge several commits into
> 	one or even remove some of them.

Or even better:

	- "git rebase" learned an "interactive" mode, where you can pick 
	  and reorder the commits to be applied.

> >   - "git-filter-branch" is a reborn cg-admin-rewritehist.
> 
> Better mention what it is for, e.g:
> 
> 	Lets you rewrite GIT revision history by applying custom filters 
>	on each revision. Those filters can modify each tree or 
>	information about each commit.

I never liked that description. How about (shameless plug) the description 
from my last patch:

	git-filter-branch lets you rewrite the revision history of the 
	current branch, creating a new branch. You can specify a number of 
	filters to modify the commits, files and trees.

Ciao,
Dscho
