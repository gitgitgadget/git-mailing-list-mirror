From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:17:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241415050.4648@racer.site>
References: <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
 <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site> <20070524123936.GO942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 15:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDCB-0004Ij-05
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901AbXEXNRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756912AbXEXNRc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:17:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:58038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756901AbXEXNRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:17:31 -0400
Received: (qmail invoked by alias); 24 May 2007 13:17:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 24 May 2007 15:17:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VFklqHF7VOu+sORqDWvbOgvZxK2Qqjvpn5E/4WN
	V/VxIry6f1wnDx
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524123936.GO942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48258>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 01:16:38PM +0100, Johannes Schindelin wrote:
> > I was more thinking about something like this:
> > 3fa7ded19a8da868d3af7c942f86358e6720f0c7	refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}
> 
> As Johannes already indicated I don't think this rev makes sense.

You like to confuse me, don't you?

> I suppose we could just set it to 0.
> I also don't think the URL should be associated to a ref.

It does not need to be.

But then, it is sort of a "subref": You could just clone the submodule in 
its own right, correct?

Ciao,
Dscho
