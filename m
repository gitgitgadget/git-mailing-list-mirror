From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 22:57:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802082256290.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>  <alpine.LSU.1.00.0802081142060.11591@racer.site> <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNcB1-0004YR-5F
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYBHW5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbYBHW5c
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:57:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:59396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751031AbYBHW5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:57:31 -0500
Received: (qmail invoked by alias); 08 Feb 2008 22:57:29 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 08 Feb 2008 23:57:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7WPcizLj7WLBPQHFBshCB7717QgpR87/RfR5ClF
	BgkuqQxFiPfPDS
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73169>

Hi,

On Sat, 9 Feb 2008, Martin Langhoff wrote:

> On Feb 9, 2008 12:50 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > The problem is that the local side cannot tell
> 
> The local side has the remote refs if the client has fetched recently, 
> so it might be able to tell in some cases. Not with authority (things 
> may have changed on the server side...) but the client might be able to 
> say something less alarming.

But if it was not fetched recently?  I think that what you suggest is too 
tricky (IOW too prone to break).

> > Another way to "solve" this issue, of course, is to use the remote 
> > layout. I did the switchover myself some time ago; it was hard at 
> > first, since I was so used to just check out the branches I just 
> > fetched.  But in the long run the distinction between local and 
> > tracking branches made life much easier for me.
> 
> What do you mean with "the remote layout"? I am using "remotes"+tracking 
> branches as far as I can tell...

I mean keeping most branches purely as tracking branches.  Whenever you 
are done with one branch, you delete the local branch.

Ciao,
Dscho
