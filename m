From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 16:16:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121613570.4362@racer.site>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com> 
 <Pine.LNX.4.64.0711121412410.4362@racer.site>
 <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:16:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irbxx-0005rT-S7
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbXKLQQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756AbXKLQQd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:16:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:41874 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753812AbXKLQQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:16:33 -0500
Received: (qmail invoked by alias); 12 Nov 2007 16:16:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 12 Nov 2007 17:16:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+s28sWCtust2cQMuAJFXI3gHQoq7/GHfulrlZZyG
	FqeR35zdWrSrQN
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64648>

Hi,

On Mon, 12 Nov 2007, Jon Smirl wrote:

> On 11/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 12 Nov 2007, Jon Smirl wrote:
> >
> > > git clone linus
> > > move origin to digispeaker.git
> >
> > AKA "git config remote.origin.url <your-digispeaker-url-here>"
> 
> There is more to this:

You must be hiding something.

> jonsmirl@terra:~/foo$ git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git ds
> clone.....

This sets up branch.master.{remote,merge} to {origin,master}.

> jonsmirl@terra:~/foo/ds$ git config remote.origin.url
> http://git.digispeaker.com/projects/digispeaker-kernel.git

This does not change that setting.

> jonsmirl@terra:~/foo/ds$ git pull
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch.master.merge' in
> your configuration file does not tell me either.  Please
> name which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details on the refspec.

And this does not come up here.

Maybe you don't have a master branch on digispeaker.

Ciao,
Dscho
