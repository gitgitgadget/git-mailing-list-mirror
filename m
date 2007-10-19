From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 12:12:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710191211210.19446@xanadu.home>
References: <20071019062219.GA28499@coredump.intra.peff.net>
 <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
 <20071019073938.GN14735@spearce.org> <4718D25A.7040109@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 18:13:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiuT3-0007JR-3t
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 18:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbXJSQMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 12:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754760AbXJSQMn
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 12:12:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46381 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXJSQMn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 12:12:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ600H852D560E0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 12:12:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4718D25A.7040109@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61730>

On Fri, 19 Oct 2007, Steven Grimm wrote:

> On 19/10/2007, Jeff King <peff@peff.net> wrote:
> > This makes the fetch output much more terse. It is likely to
> > be very controversial. Here's an example of the new output:
> >
> > Indexing objects: 100% (1061/1061), done.
> > Resolving deltas: 100% (638/638), done.
> 
> Those two lines are actually my beef with the fetch output. As a newbie, I had
> no idea what "Indexing objects" actually meant. We have this thing called "the
> index" in git so I would expect "Indexing objects" to have something to do
> with that, but it doesn't seem to.
> 
> How about something more descriptive of the high-level operation that's going
> on, along the lines of:
> 
> Gathering changes from remote: 100% (1061/1061), done.
> Applying changes locally: 100% (638/638), done.

This is even more wrong.

Agreed, indexing objects might not be the best description.  It probably 
will become "receiving objects" along with a bandwitth meter.


Nicolas
