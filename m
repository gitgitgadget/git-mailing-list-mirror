From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Git wrapper: add --redirect-stderr option
Date: Wed, 30 May 2007 05:12:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705300510450.4011@racer.site>
References: <Pine.LNX.4.64.0705291446170.4648@racer.site> <465C3502.BE134BC9@eudaptics.com>
 <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
 <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl>
 <Pine.LNX.4.64.0705300337510.4011@racer.site> <20070530025705.GN7044@spearce.org>
 <Pine.LNX.4.64.0705300407170.4011@racer.site> <20070530033830.GO7044@spearce.org>
 <Pine.LNX.4.64.0705300444020.4011@racer.site> <20070530035335.GP7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 06:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtFZQ-00010W-Gj
	for gcvg-git@gmane.org; Wed, 30 May 2007 06:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbXE3ENt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 00:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXE3ENt
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 00:13:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:40622 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751369AbXE3ENs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 00:13:48 -0400
Received: (qmail invoked by alias); 30 May 2007 04:13:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 30 May 2007 06:13:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mTcoxoX1mvfEMBz3Z49cMiSpcYRSvaw2cmxFoAT
	vzesQeOsHe8vwv
X-X-Sender: gene099@racer.site
In-Reply-To: <20070530035335.GP7044@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48734>

Hi,

On Tue, 29 May 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > On Tue, 29 May 2007, Shawn O. Pearce wrote:
> > 
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > 
> > > > With this option, stderr is redirected to stdout. The short option is '-2'.
> > > > 
> > > > Alternatively, you can say '--redirect-stderr=<filename>' to redirect
> > > > stderr to a file.
> > > 
> > > Yes, that works nicely.  ;-)
> > > 
> > > Now here's my other problem: How does git-gui know the underlying
> > > git will accept --redirect-stderr?  Or that it supports any other
> > > recent features we've developed?
> > 
> > I thought that git-gui is now really closely coupled with core-git.
> 
> Not really.  It requires 1.5.0 and later, but after that it should
> be OK with any 1.5.x version of Git.  Junio graciously bundles it
> with core Git, to help it get a wider audience.  ;-)
> 
> However I'd like to let it be smarter about what it expects from the
> underling core Git.  I'm sure the other Porcelain authors would also
> like to be able to determine if they can rely on something, or not.
> At the least we can just tell the user "Your Git old.  Upgrade to new
> Git today!".  Yes, bad Engrish included... ;-)

When in doubt, you can always test the return value to check if the 
command line option is accepted...

Ciao,
Dscho
