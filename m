From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Notes - Track rebase/etc + reverse-lookup for bugs ideas
Date: Mon, 10 Nov 2008 21:48:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811102147340.30769@pacific.mpi-cbg.de>
References: <6A0F154C-B9FE-4770-BF70-82A5BEBF907C@gmail.com> <20081110191134.GA3329@sigill.intra.peff.net> <alpine.DEB.1.00.0811102049460.30769@pacific.mpi-cbg.de> <20081110195120.GA3688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:42:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdai-0003LL-1d
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbYKJUlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYKJUlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:41:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:42817 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750923AbYKJUlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:41:16 -0500
Received: (qmail invoked by alias); 10 Nov 2008 20:40:57 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 10 Nov 2008 21:40:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+xTz1PzA6xP4bTgGQrycamKjIjD5ovcfI2IuL6hM
	MnStWC7Ky0DZrf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081110195120.GA3688@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100564>

Hi,

On Mon, 10 Nov 2008, Jeff King wrote:

> On Mon, Nov 10, 2008 at 08:51:50PM +0100, Johannes Schindelin wrote:
> 
> > > Not that I know of, but then again, I'm not sure exactly what you 
> > > mean by "track rebases".
> > 
> > I guess he means that you could have something like this
> > 
> > 	rebased from <SHA-1>
> > 
> > in the notes for any given commit, so that _if_ you have the commit, 
> > e.g. gitk could show that connection (maybe dashed in the graphical 
> > history display, and as a "Rebased from:" link).
> 
> You don't really need "notes" for that, though, since you can put that 
> information into the commit message (or headers) if you choose. I guess 
> it has the advantage of not polluting the commit for others.

Exactly.  And it would have the nice side effect that you could use a 
notes ref "rebases", and just not show it when you are not interested in 
looking at rebases.

Ciao,
Dscho
