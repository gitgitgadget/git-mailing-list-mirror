From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 20:42:06 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711122040350.4362@racer.site>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
 <Pine.LNX.4.64.0711121412410.4362@racer.site>
 <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:42:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irg7H-0003jg-G3
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbXKLUm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXKLUmZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:42:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:33540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751700AbXKLUmY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:42:24 -0500
Received: (qmail invoked by alias); 12 Nov 2007 20:42:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 12 Nov 2007 21:42:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tJsJJ5ewt0sboVCtvDHX6Q5m8oxtQbTvLwNn0/F
	1GLR7KODQKOZlD
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64701>

Hi,

On Mon, 12 Nov 2007, Linus Torvalds wrote:

> On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> > 
> > On Mon, 12 Nov 2007, Jon Smirl wrote:
> > 
> > > I'd like to do this sequence, but I can't figure out how without 
> > > editing the config file. There doesn't seem to be a simple command 
> > > to move the origin.
> > > 
> > > git clone linus
> > > move origin to digispeaker.git
> > 
> > AKA "git config remote.origin.url <your-digispeaker-url-here>"
> 
> I really think people should at least also mention:
> 
> 	"Or just edit your .git/config file by hand"

FWIW I agree.  The intent of git-repo-config (as it was named then) was to 
have a program for _scripts_ to use.

But for some reasons, people on IRC refuse to edit .git/config by hand.  
*sigh*  Will have to relearn giving proper help.

Thanks,
Dscho
