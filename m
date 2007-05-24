From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 19:07:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241907021.4648@racer.site>
References: <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site> <20070524123936.GO942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241415050.4648@racer.site> <20070524132434.GQ942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241446070.4648@racer.site> <20070524174252.GT942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 20:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHjP-0001ji-N1
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXEXSHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbXEXSHs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:07:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:49986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750795AbXEXSHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:07:47 -0400
Received: (qmail invoked by alias); 24 May 2007 18:07:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 24 May 2007 20:07:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hASw3eRRhJYXjIIHl7xPccfZyBbJcjzMA2UovDv
	chwWHcaEjFN6t7
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524174252.GT942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48284>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 02:52:25PM +0100, Johannes Schindelin wrote:
> > It is not that expensive to just give the SHA-1 with the URL, and to 
> > introduce a new namespace, say
> > 
> > 3f... submodule/path^{URL:blablub}
> > 
> > to say that the submodule which is connected in "HEAD:path" is available 
> > with the URL "blablub" and just so happens to be at commit "3f..." at the 
> > moment. Heck, you can even use this instead of expensive fetches to verify 
> > up-to-date, and even more, you can make sure that you are as up-to-date as 
> > the remote supermodule.
> 
> What about all the other branches?
> Also, the submodule may not even be in any of the tips of the branches.

Okay, bad idea.

> > Without some very intrusive surgery into the transport code of Git, in 22 
> > patches, which I am not at all comfortable with.
> 
> You're not comfortable with the number or with the patches?
> There's only about four or five that deal with this git-config stuff
> and any other mechanism would have to implemented as well.

If it was even only one, which is as intrusive, I would still be 
uncomfortable. And yes, the large number does not make me want to review 
the series either.

Ciao,
Dscho
