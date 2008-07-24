From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf
 has not been set
Date: Fri, 25 Jul 2008 01:58:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807250157370.4140@eeepc-johanness>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de> <alpine.DEB.1.00.0807241742220.8986@racer> <200807242244.04799.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 01:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAha-0002Sm-4d
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbYGXX53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756887AbYGXX53
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:57:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:45073 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756098AbYGXX52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:57:28 -0400
Received: (qmail invoked by alias); 24 Jul 2008 23:57:25 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp011) with SMTP; 25 Jul 2008 01:57:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SGmsXyIOSSndaHPDn/EgHtIDB9teJ2mLQrcXRKB
	Riy+IJ/GiqlO85
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807242244.04799.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89976>

Hi,

On Thu, 24 Jul 2008, Robin Rosenberg wrote:

> torsdagen den 24 juli 2008 18.45.07 skrev Johannes Schindelin:
> > However, I see Junio's point: on sane platforms you have to work hard 
> > to get CR-damaged files.  And the regular sane platform user should 
> > not be punished for the brain/CR damage a certain monopolist has 
> > brought over this planet.
> 
> That wasn't hard at all :) Eclipse did it all by itself for JEE 
> MANIFEST.MF files. We got into some strange problems on windows with 
> msysgit after that where git (status) detected the files as changed, but 
> no actual content change and refused to change it's mind. I think we had 
> actually fixed the files on Windows prior to that. Only after converting 
> the checkout to autocrlf=input did msysgit enter a sane state again. I 
> was not able to repeat the problem at the time.
> 
> Maybe I'll try again in a few weeks time.

That would be rather useful, because without a way to reproduce, you leave 
me with a rather frustrating situation.

Hth,
Dscho
