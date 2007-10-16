From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Tue, 16 Oct 2007 11:51:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161151030.25221@racer.site>
References: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
 <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz>
 <20071013202713.GA2467@fieldses.org> <Pine.LNX.4.64.0710140135020.25221@racer.site>
 <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org>
 <20071014014445.GN27899@spearce.org> <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
 <47125BF7.2070503@midwinter.com> <alpine.LFD.0.9999.0710141542020.19446@xanadu.home>
 <20071015232017.GS27899@spearce.org> <alpine.LFD.0.9999.0710152245530.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 12:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihk26-0003Db-DN
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 12:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbXJPKwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 06:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbXJPKwE
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 06:52:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:60759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932111AbXJPKwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 06:52:03 -0400
Received: (qmail invoked by alias); 16 Oct 2007 10:52:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 16 Oct 2007 12:52:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dkctqpPodqaG9jyi8ce/HvzCWP1g26xPe9IKJdU
	XEMfAvAe6DR+tq
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0710152245530.19446@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61143>

Hi,

On Mon, 15 Oct 2007, Nicolas Pitre wrote:

> On Mon, 15 Oct 2007, Shawn O. Pearce wrote:
> 
> > Nicolas Pitre <nico@cam.org> wrote:
> > > BTW I have patches here reworking the progress code for a more compact 
> > > display which should mitigate this issue quite a bit.
> > 
> > git-gui is scraping the output of the current progress meter using
> > a regex and then building a graphical progress bar from that output.
> 
> Erk!
> 
> > Any change in how git produces the progress bar should still keep
> > it in a form that git-gui can regex match and scrape, preferably
> > without needing to know what version of git it is pulling that
> > output from.  For example just teach git-gui to try two different
> > regexps, new format and if that doesn't match then try the old
> > (aka current) format.
> 
> I think my new format might be easier for you as the "title" and the 
> actual percentage and count is now on the same line.

That might have been an advantage if Shawn did not do the code already.  
As it is, he'll have to maintain two different regexes, _and_ detect when 
to use which.

Ciao,
Dscho
