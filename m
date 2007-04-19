From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 23:00:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704192257520.8822@racer.site>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <f06d4m$3rs$1@sea.gmane.org> <4626C4B9.1040707@midwinter.com>
 <200704190408.59595.jnareb@gmail.com> <Pine.LNX.4.64.0704191043140.8822@racer.site>
 <4627BCF0.3000004@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 23:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HedkT-0004GW-Hz
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 23:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbXDSVA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965397AbXDSVA4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 17:00:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:36260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965345AbXDSVAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 17:00:55 -0400
Received: (qmail invoked by alias); 19 Apr 2007 21:00:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 19 Apr 2007 23:00:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gAU0JnaagPRoLlFhBuR+YOpNC0bhH2/LD3jAoQD
	rn4VHoKAHps19J
X-X-Sender: gene099@racer.site
In-Reply-To: <4627BCF0.3000004@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45045>

Hi,

On Thu, 19 Apr 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
>
> > Let me pick up the ball here. Once you did your share of conflicting 
> > merges, you _will_ realize how much better it is to merge when you are 
> > at a relatively stable state, i.e. you can test things (if only to 
> > make sure that the merge did not introduce strange side effects). And 
> > guess what, at such a stage I would commit anyway.
> 
> That's a great workflow if you're working on relatively discrete, 
> standalone changes. A lot of the time, when I'm working on an isolated 
> change, I do just that, and I merge when I'm stable just like you 
> describe. That's probably the vastly most common mode of operation for 
> distributed open-source projects, which obviously were git's initial 
> target audience.

It is also possible (and I do that) when merging often. I use cherry-pick 
for that. At a later stage, I merge, and this mostly succeeds, since the 
merge is really a 3-way merge (with the obvious results).

> And out of curiosity, are you using git for distributed, relatively 
> autonomous development, or for collaboration with a high level of 
> interdependency between developers?

I use Git virtually everywhere it can be used:

- backups
- personal projects
- configuration files
- documents
- collaboration with other people
- tracking CVS
- ...

Ciao,
Dscho
