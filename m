From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 15:51:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251548390.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <200705251427.46903.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251343550.4648@racer.site>
 <200705251559.53846.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251514220.4648@racer.site>
 <20070525143815.GF942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri May 25 16:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrb8a-0002Bn-7B
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038AbXEYOvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757718AbXEYOvX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:51:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:39158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751259AbXEYOvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 10:51:22 -0400
Received: (qmail invoked by alias); 25 May 2007 14:51:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 25 May 2007 16:51:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/X5A0A587XTFIHg8z7QycE1r3Wi78WdN6VK7nW7l
	r9MrLz9/0oNJFA
X-X-Sender: gene099@racer.site
In-Reply-To: <20070525143815.GF942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48385>

Hi,

On Fri, 25 May 2007, Sven Verdoolaege wrote:

> On Fri, May 25, 2007 at 03:16:56PM +0100, Johannes Schindelin wrote:
> > And the point about my config being private still stands. You have no 
> > business looking into my config.
> 
> Put your private configuration in config and your public configuration
> in submodulesconfig.
> A public repo typically wouldn't have any submodules configuration
> in config (or any other private information for that matter), but
> we wouldn't read it anyway.

Why complicate things? The information you want to put into 
submodulesconfig is an information you would most likely want to give 
cloners.

And as it happens, we _have_ a perfect transport mechanism for clones. You 
only have to put the information into the object database itself, and -- 
voila -- no need to change any core level plumbing.

That's why I keep harping on .gitmodules, since it _is_ the obvious 
correct, simple and elegant way to do things here.

So, just "s/\.git\/submodulesconfig/.gitmodules/g" in your head, and 
you're done.

Ciao,
Dscho
