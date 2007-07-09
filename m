From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Mon, 9 Jul 2007 15:59:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091558090.5546@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707090011070.4248@racer.site>
 <20070709094703.GP1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707091257470.5546@racer.site> <20070709134918.GT1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707091450440.5546@racer.site> <20070709144248.GW1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Jul 09 17:07:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7upl-0006Hx-5s
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 17:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbXGIPHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 11:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbXGIPHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 11:07:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:51806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750788AbXGIPHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 11:07:24 -0400
Received: (qmail invoked by alias); 09 Jul 2007 15:07:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 09 Jul 2007 17:07:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aRmhOkfgapnbdUFDmA9m9O8ks69VeCFzl4pqVl7
	yVUXbTdm8jG5xU
X-X-Sender: gene099@racer.site
In-Reply-To: <20070709144248.GW1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51998>

Hi,

On Mon, 9 Jul 2007, Sven Verdoolaege wrote:

> On Mon, Jul 09, 2007 at 03:11:45PM +0100, Johannes Schindelin wrote:
> > On Mon, 9 Jul 2007, Sven Verdoolaege wrote:
> > > The current git-rewrite-commits will rewrite all SHA1's it can find,
> > > irrespective of any 'commit ' that may precede it.
> > 
> > Even abbreviated ones?
> 
> Yes.  I'll add that to the documentation.

That is definitely something you want to control.  I have seen commit 
messages referencing certain hexadecimal numbers, and they were definitely 
no commit names.  The shorter they are, the more likely they are to be 
rewritten by your magic.

> > * rename the darned things to "filter" again.
> > 
> > * --write-sha1-mappings=<directory> (or --write-commit-mappings), possibly 
> >   defaulting to .git/mappings/.  Be careful not to overwrite an existing 
> >   such directory.
> > 
> > * change the semantics of the commit filter: the output is a list 
> >   (possibly empty) of replacement sha1's for this commit.
> > 
> > * if any filters are called, provide a script with convenience functions, 
> >   and an environment variable pointing to it.  These functions should 
> >   include:
> > 
> > 	* map
> > 	* commit
> > 	* save
> > 	* restore
> 
> Hmm... you're tricking me into write shell code.

Ah, oh well.  If you do the rest, I'll do the shell code.

Ciao,
Dscho
