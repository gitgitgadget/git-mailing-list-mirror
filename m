From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Git wrapper: add --redirect-stderr option
Date: Wed, 30 May 2007 04:45:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705300444020.4011@racer.site>
References: <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com>
 <Pine.LNX.4.64.0705291446170.4648@racer.site> <465C3502.BE134BC9@eudaptics.com>
 <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com>
 <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl>
 <Pine.LNX.4.64.0705300337510.4011@racer.site> <20070530025705.GN7044@spearce.org>
 <Pine.LNX.4.64.0705300407170.4011@racer.site> <20070530033830.GO7044@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 05:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtF9k-0005pc-ST
	for gcvg-git@gmane.org; Wed, 30 May 2007 05:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbXE3DrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 23:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbXE3DrW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 23:47:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:38287 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751485AbXE3DrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 23:47:21 -0400
Received: (qmail invoked by alias); 30 May 2007 03:47:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 30 May 2007 05:47:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tPUIskqftMTzo4pdfmg2LBWl7C3MCynqAJvkwSv
	gmKTdJHpg2D8x+
X-X-Sender: gene099@racer.site
In-Reply-To: <20070530033830.GO7044@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48732>

Hi,

On Tue, 29 May 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > With this option, stderr is redirected to stdout. The short option is '-2'.
> > 
> > Alternatively, you can say '--redirect-stderr=<filename>' to redirect
> > stderr to a file.
> 
> Yes, that works nicely.  ;-)
> 
> Now here's my other problem: How does git-gui know the underlying
> git will accept --redirect-stderr?  Or that it supports any other
> recent features we've developed?

I thought that git-gui is now really closely coupled with core-git.

> Sure I can check the version, but until I know what version of Git
> its shipping in I cannot put the check into git-gui.
> 
> I was thinking about adding a "git-supported-features" plumbing
> command that prints back feature code strings, much as our
> network protocol supplies back the few feature codes it supports
> ("multi-ack", "sideband", etc.).

Problem is: it would be more interesting to have this program in _older_ 
versions... ;-)

Ciao,
Dscho
