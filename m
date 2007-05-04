From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 21:31:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705042127390.4015@racer.site>
References: <463ADE51.2030108@gmail.com> <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
 <463AFAAE.853DEF7B@eudaptics.com> <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705042104370.4015@racer.site> <7v1whwtmvj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 21:31:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk3VV-00036G-GQ
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423098AbXEDTby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423097AbXEDTby
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:31:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:49693 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423098AbXEDTbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:31:53 -0400
Received: (qmail invoked by alias); 04 May 2007 19:31:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 04 May 2007 21:31:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cRbhJcnmc/SnryYyuksP6kzbwQ43/4Bh3Wt+gSv
	4tNekf28ZMFrIu
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1whwtmvj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46204>

Hi,

On Fri, 4 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > FWIW I still find that unintuitive. I know "<something>:<path>" from ssh, 
> > and there it does not change meaning depending on where I am. IMHO in most 
> > cases you want to use git-diff anyway, which _does_ honour the current 
> > relative path.
> 
> There, its meaning is relative to where you are, namely "$HOME".

No, it is relative to where I am _at the other end_. If I "cd /tmp", it 
still is relative to $HOME.

Now, what you want to do is changing the meaning of v1.5.1:Makefile, 
depending if you "cd Documentation/"ed or not.

For me, "v1.5.1:" means something similar to ssh: it is a distant 
revision. It is not a complete filesystem. I think of revisions as 
something more general than a directory, but less general than a 
filesystem. And thus, it makes perfect sense to me that "v1.5.1:Makefile" 
means the main Makefile, no matter where I am in the current repository.

Now, I agree that often you want to compare some file in the current 
directory to the corresponding file in a certain revision. That is why 
git-diff has a different idea, and indeed, a different notation, too.

Ciao,
Dscho
