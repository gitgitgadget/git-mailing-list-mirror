From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 8 Feb 2009 21:54:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
References: <20090208042910.19079.qmail@science.horizon.com>  <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de> <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 21:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWGg4-00048L-Lk
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 21:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbZBHUxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 15:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZBHUx3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 15:53:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:47615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753513AbZBHUx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 15:53:28 -0500
Received: (qmail invoked by alias); 08 Feb 2009 20:53:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 08 Feb 2009 21:53:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ayeAYXT8aMbtkNBj9EqEY442KqFZb67aDV1o2Ic
	JOcO+GjqsdfAGX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109013>

Hi,

On Sun, 8 Feb 2009, Jay Soffian wrote:

> On Sun, Feb 8, 2009 at 5:30 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > It's insane, that's what it is.
> >
> > You have _no_ business meddling with a remote working directory, _except_
> > by logging into that machine and working on that working directory
> > _directly_.
> >
> > If you do not agree, you have not thought about the implications, i.e.
> > what problems you buy.
> 
> Just by way of providing an additional perspective, I thought I'd illustrate
> how Mercurial handles this situation:
>
> [... lots of lines which say in a long and winding manner the same as 
>  the following...] 
>
> What I especially like about Mercurial here is that pushing from A is 
> perfectly symetrical to pulling from B.

Just to make it clear: if you have merge conflicts on the remote end, you 
will get into trouble.

I do not know how Mercurial handles this (I am sure you will send a 
page-long mail illustrating it), but in my humble opinion, there is _no_ 
way to handle this except if you have shell access to the remote 
repository/working directory.

No matter if you suggest leaving merge conflict, a detached HEAD, or 
"read-tree -u -m HEAD" (i.e. trying a simple merge with the working 
directory): _all_ of them are unsafe.

Ciao,
Dscho
