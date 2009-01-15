From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 17:53:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151751580.3586@pacific.mpi-cbg.de>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <496F3C99.1040800@drmicha.warpmail.net> <20090115135518.GB10045@leksak.fem-net> <496F44AC.2060607@drmicha.warpmail.net> <alpine.DEB.1.00.0901151518520.3586@pacific.mpi-cbg.de>
 <496F4BF0.6020805@drmicha.warpmail.net> <alpine.DEB.1.00.0901151658060.3586@pacific.mpi-cbg.de> <slrngmuoq8.3u2.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 17:55:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNVUb-0006W9-SQ
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 17:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754746AbZAOQxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 11:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbZAOQxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 11:53:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:43612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754374AbZAOQxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 11:53:16 -0500
Received: (qmail invoked by alias); 15 Jan 2009 16:53:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 15 Jan 2009 17:53:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182bjIsgnc2okvemrjotHX2V0zxIZeHSFJRkSrjId
	3ea73g6F3eUxr1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <slrngmuoq8.3u2.sitaramc@sitaramc.homelinux.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105853>

Hi,



if you would like me to respond to your questions in the future, it is 
mandatory to keep me in the Cc: list.



On Thu, 15 Jan 2009, Sitaram Chamarty wrote:

> On 2009-01-15, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > The intention was this:
> >
> > 	$ git rebase -p master
> >
> > would need to rewrite _all_ commits that are in "master..".  All of them, 
> > including the merge commits.
> 
> I went hog wild with all sorts of test cases and my head is
> spinning, but -- even when things happen more predictably,
> I'm unable to make "rebase -p" carry an evil merge over.
> The "evil" part stays behind.
> 
> I'm not sure if that is intentional or not, or (more likely)
> my brain has become addled and I missed something somewhere.

Yes, this is intentional.

	Instead of ignoring merges, try to recreate them.

That means it tries to recreate them.  Not that it is successful.  And not 
even that it realizes when it failed.

Hth,
Dscho
