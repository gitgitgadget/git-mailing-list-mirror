From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Sun, 22 Jul 2007 20:15:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222013200.14781@racer.site>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> 
 <Pine.LNX.4.64.0707221959100.14781@racer.site>
 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICguA-0002TO-Ap
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXGVTPn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXGVTPm
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:15:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:60200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751287AbXGVTPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:15:42 -0400
Received: (qmail invoked by alias); 22 Jul 2007 19:15:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 22 Jul 2007 21:15:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ayzgIa+8aMyHkAW63eV7Fo/fLoLeg7Qo9VW7pC9
	jNsLf4amx7ahdZ
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53299>

Hi,

On Sun, 22 Jul 2007, Jon Smirl wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 22 Jul 2007, Jon Smirl wrote:
> > 
> > > It would really be useful if git diff had an option for suppressing 
> > > diffs caused by CVS keyword expansion.
> > 
> > Looks to me slightly a bit like an XY problem.
> > 
> > How about using git-filter-branch to get rid of the expansions?  Or 
> > even better, if you have access to the CVS server, use the -k option 
> > to cvsimport?
> 
> No access to the server the people handing over the diffs and not
> making things easy.

Ah yes, that's what I feared.  Darn.

But still, I think that it would be much better not to put this into Git.  
We do have diff gitattributes now, so that you can roll your own diff for 
specific files, but I still think that this is more a task for a 
standalone perl script.  Possibly being called from filter-branch to be 
done with the conversion once and for all times.

Ciao,
Dscho
