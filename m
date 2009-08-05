From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a
 foreign vcs
Date: Wed, 5 Aug 2009 23:20:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnu8-0001ME-3w
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbZHEVUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbZHEVUC
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:20:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:52242 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751930AbZHEVUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:20:02 -0400
Received: (qmail invoked by alias); 05 Aug 2009 21:20:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 05 Aug 2009 23:20:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//otFhFOL/OkEDX8gsBhku8ERqMXcEU7jTJbLCLD
	oTv/1ymL7zB3F/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908051658530.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124990>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> On Wed, 5 Aug 2009, Johannes Schindelin wrote:
> 
> > On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> > 
> > > If this is set, the url is not required, and the transport always 
> > > uses a helper named "git-remote-<value>".
> > 
> > I wonder what's wrong with saying "git config remote.origin.url p4:" 
> > instead of having two different code paths that do essentially the 
> > same.
> 
> I believe some cases will want to use a URL which is "http://something" 
> and have some other option cause the code to use "git helper-svn".

I actually would rather have "svn-http://something" because it tells me 
right away and in red letters what is happening.

Ciao,
Dscho
