From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 19:26:10 +0200
Message-ID: <20071019172610.GE30825@uranus.ravnborg.org>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <4718D25A.7040109@midwinter.com> <alpine.LFD.0.9999.0710191211210.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 19:26:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iivbn-0007GB-Bx
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 19:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935742AbXJSRYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 13:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935719AbXJSRYk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 13:24:40 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:43505 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935493AbXJSRYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 13:24:39 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 34E968008CA;
	Fri, 19 Oct 2007 19:24:35 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id 741DF580D2; Fri, 19 Oct 2007 19:26:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710191211210.19446@xanadu.home>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61734>

On Fri, Oct 19, 2007 at 12:12:41PM -0400, Nicolas Pitre wrote:
> On Fri, 19 Oct 2007, Steven Grimm wrote:
> 
> > On 19/10/2007, Jeff King <peff@peff.net> wrote:
> > > This makes the fetch output much more terse. It is likely to
> > > be very controversial. Here's an example of the new output:
> > >
> > > Indexing objects: 100% (1061/1061), done.
> > > Resolving deltas: 100% (638/638), done.
> > 
> > Those two lines are actually my beef with the fetch output. As a newbie, I had
> > no idea what "Indexing objects" actually meant. We have this thing called "the
> > index" in git so I would expect "Indexing objects" to have something to do
> > with that, but it doesn't seem to.
> > 
> > How about something more descriptive of the high-level operation that's going
> > on, along the lines of:
> > 
> > Gathering changes from remote: 100% (1061/1061), done.
> > Applying changes locally: 100% (638/638), done.
> 
> This is even more wrong.
> 
> Agreed, indexing objects might not be the best description.  It probably 
> will become "receiving objects" along with a bandwitth meter.

The term 'objects' here always confuses me. What is often my first
thing to check the number of individual commits being added after
a git pull. Wether a commit touches one or several files is less
important (to my way of using git).

	Sam
