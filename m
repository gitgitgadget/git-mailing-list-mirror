From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Starting 1.5.3 stabilization cycle
Date: Wed, 4 Jul 2007 00:16:28 +0200
Message-ID: <20070703221628.GF4580@xp.machine.xx>
References: <7v8x9yrllv.fsf@assigned-by-dhcp.cox.net> <20070703181428.GD4580@xp.machine.xx> <Pine.LNX.4.64.0707031923180.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:16:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qfn-0003rv-O7
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397AbXGCWQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754423AbXGCWQS
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:16:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:33901 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756557AbXGCWQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:16:17 -0400
Received: (qmail invoked by alias); 03 Jul 2007 22:16:16 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp031) with SMTP; 04 Jul 2007 00:16:16 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/uX6BvT7bua1tQw+poHHScBJuxgg3k6TJQiyVLTQ
	7kyvLcyhY4yxSV
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707031923180.4071@racer.site>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51543>

On Tue, Jul 03, 2007 at 07:27:54PM +0100, Johannes Schindelin wrote:

[... skipping an embarrassing part of the message :-) ...]

> > 	This is meant for reordering the commits, merge several commits into
> > 	one or even remove some of them.
> 
> Or even better:
> 
> 	- "git rebase" learned an "interactive" mode, where you can pick 
> 	  and reorder the commits to be applied.

Sounds nicer, but I would add that it is also possible to remove commits.

> > >   - "git-filter-branch" is a reborn cg-admin-rewritehist.
> > 
> > Better mention what it is for, e.g:
> > 
> > 	Lets you rewrite GIT revision history by applying custom filters 
> >	on each revision. Those filters can modify each tree or 
> >	information about each commit.
> 
> I never liked that description. How about (shameless plug) the description 
> >from my last patch:
> 
> 	git-filter-branch lets you rewrite the revision history of the 
> 	current branch, creating a new branch. You can specify a number of 
> 	filters to modify the commits, files and trees.

I find it a little distracting to mention the "new branch" in this short
description. I think this belongs into the manpage and not in a short
description for the release notes. But I agree that this sounds otherwise nicer.

-Peter
