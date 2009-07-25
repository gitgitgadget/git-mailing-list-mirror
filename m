From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 0/3] Request for help: graph-based UI
Date: Sun, 26 Jul 2009 01:20:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907260119140.8306@pacific.mpi-cbg.de>
References: <cover.1247408350u.git.johannes.schindelin@gmx.de> <200907212140.32520.robin.rosenberg@dewire.com> <ed88cb980907251354o3c5e9007t4de328d0c4cdea52@mail.gmail.com> <20090725205936.GF11191@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Douglas Campos <douglas@theros.info>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:20:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqXs-0001xK-Oh
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbZGYXUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 19:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbZGYXUp
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:20:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:39142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752414AbZGYXUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 19:20:45 -0400
Received: (qmail invoked by alias); 25 Jul 2009 23:20:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 26 Jul 2009 01:20:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bvXp3mxxbMTLaoQRl0z0Ahq/4I9LY5oduYrwXNS
	5wDuXjA60zTHoV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090725205936.GF11191@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124094>

Hi,

On Sat, 25 Jul 2009, Shawn O. Pearce wrote:

> Douglas Campos <douglas@theros.info> wrote:
> > Just a question.. all graphic things that we implement in swing aren't 
> > usable inside eclipse with swt-awt bridge?
> 
> They should be usuable inside the SWT-AWT bridge, but that bridge is 
> really dicey to get working right sometimes.  I had a lot of trouble 
> with it at my prior day-job and am happy I no longer have to deal with 
> it.
> 
> For the most part, SWT and AWT are similar enough in their rendering 
> that its possible to build most of a layout algorithm to be rendering 
> API agnostic, and then permit implementation of AWT and SWT backends. 
> But that still is duplicated effort, vs. straightforward code reuse.

Of course, the Graph GUI is Swing...

But I would definitely welcome if somebody made the rendering more 
modular, to allow for an SWT backend.

In fact, I think I welcome almost everything people contribute to the 
Graph GUI project.

Ciao,
Dscho
