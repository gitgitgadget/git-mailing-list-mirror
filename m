From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn and svn:externals, was Re: Hackontest ideas?
Date: Tue, 29 Jul 2008 15:04:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807291502450.4631@eeepc-johanness>
References: <20080729000103.GH32184@machine.or.cz> <m3myk1t54c.fsf@localhost.localdomain> <alpine.DEB.1.00.0807291354130.4631@eeepc-johanness> <200807291428.32072.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNos5-0003I1-Qk
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 15:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYG2NDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 09:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYG2NDI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 09:03:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:33519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752188AbYG2NDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 09:03:06 -0400
Received: (qmail invoked by alias); 29 Jul 2008 13:03:04 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp042) with SMTP; 29 Jul 2008 15:03:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HCEEYh+aHTDK5Y+XHum1GNHGEyBwnaNiq6hcMVJ
	fffk816oScax9z
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807291428.32072.jnareb@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90632>

Hi,

On Tue, 29 Jul 2008, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Tue, 29 Jul 2008, Jakub Narebski wrote:
> > 
> > >  * handling of svn:externals using submodules
> > 
> > The main concern I have is to get the semantics right: AFAICT 
> > svn:externals has _no notion_ of "what is current".  It just _always_ 
> > fetches the HEAD.  Even if you check out an ancient revision in the 
> > "superproject".
> 
> If I understand correctly with version 1.5 svn:externals can be 
> specified using "peg revisions", so they could refer to some specific 
> revision of 'external', like git submodules.

... which only means that if they had done that from the beginning, it 
the git-svn enhancement would be easy.

But as they did not have it from the beginning, anybody tackling git-svn 
and svn:externals will have to come up with sensible semantics for the 
hard case.

Ciao,
Dscho
