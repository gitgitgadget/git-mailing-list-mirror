From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stashing untracked files
Date: Sun, 30 Sep 2007 22:25:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709302224270.28395@racer.site>
References: <46FE9924.7080006@theory.org> <bf0b20a90709301344j1ac8f538u616fb4ba3fc47efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Macneale <mac4-git@theory.org>, git <git@vger.kernel.org>
To: Tom Tobin <korpios@korpios.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 23:27:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6Jr-0006LP-JF
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbXI3V1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbXI3V1K
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:27:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:42356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751614AbXI3V1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:27:09 -0400
Received: (qmail invoked by alias); 30 Sep 2007 21:27:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 30 Sep 2007 23:27:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/JHYJxli/gEoTEMsCtzZxf+z7l7Rm6a8wnb1z3G
	hrqwS8x9jR4jGW
X-X-Sender: gene099@racer.site
In-Reply-To: <bf0b20a90709301344j1ac8f538u616fb4ba3fc47efe@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59569>

Hi,

On Sun, 30 Sep 2007, Tom Tobin wrote:

> On 9/29/07, Neil Macneale <mac4-git@theory.org> wrote:
> > When using "git stash," in some cases I'd like to stash away files 
> > that are currently untracked. It seems to me like there should be a 
> > way to stash everything in a working directory so that the end result 
> > is a pristine tree. Then applying the stash will reinstate those file 
> > as untracked.
> 
> Since this is an itch of my own, I have a local copy of git-stash that 
> does this (stashes away the untracked -- but not ignored -- files, and 
> restores them as untracked upon "stash apply"); unfortunately, I'm 
> pretty new to git, so I'm certain my code is *quite* unoptimized and 
> ugly.  As soon as I feel comfortable with it (which should include 
> making the new behavior optional), I'll drop a line here with some code.  
> :-)

We are known on this list for never biting someone's head off, especially 
not when posting patches.

Why not just post it, see what comments come back, adapt it, and repost?  
More often than not, people learn by getting their code reviewed, and 
faster so when the code is reviewed early.

Ciao,
Dscho
