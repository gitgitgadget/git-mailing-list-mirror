From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf
 has not been set
Date: Thu, 24 Jul 2008 15:38:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241537000.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <alpine.DEB.1.00.0807230229410.8986@racer> <719E03C0-E8C3-4C35-AE9C-9BD5A7BCDF03@zib.de> <20080723114022.GP2925@dpotapov.dyndns.org>
 <FCAEAB20-750E-47B9-B58D-9BB0CB1EEAFF@zib.de> <20080724140959.GU2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:40:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM1yx-0008M4-PL
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbYGXOij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752830AbYGXOii
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:38:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:54894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756035AbYGXOih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:38:37 -0400
Received: (qmail invoked by alias); 24 Jul 2008 14:38:35 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2008 16:38:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0SaYfBlH09ceZvfQON9iyVpT+4sEpzNbX+InbzL
	P0Lpog2rSx/Gn4
X-X-Sender: gene099@racer
In-Reply-To: <20080724140959.GU2925@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89888>

Hi,

On Thu, 24 Jul 2008, Dmitry Potapov wrote:

> On Thu, Jul 24, 2008 at 08:06:29AM +0200, Steffen Prohaska wrote:
> > 
> >   I am the maintainer of this project.  I know that this project needs 
> >   crlf conversion, because it is a cross-platform project.  
> >   Therefore, I want to force crlf conversion for this specific 
> >   project, even if the user did not configure core.autocrlf=input on 
> >   Unix.
> 
> I suspect that most problems with crlf is caused by Windows users who 
> have core.autocrlf=false for whatever reason (I suspect without a good 
> reason in most cases).

Almost correct.  It is _unset_!  And it should be perfectly valid for 
users not having to set anything there.

> But perhaps having core.autocrlf=input as default on Unix and Mac will 
> be better than the current core.autocrlf=false.

Have you read Junio's reply?  If so, how can you suggest any change for 
Unix and Mac?

Ciao,
Dscho
