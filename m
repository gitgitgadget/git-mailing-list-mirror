From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sun, 14 Oct 2007 15:44:45 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710141542020.19446@xanadu.home>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
 <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz>
 <20071013202713.GA2467@fieldses.org>
 <Pine.LNX.4.64.0710140135020.25221@racer.site>
 <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org>
 <20071014014445.GN27899@spearce.org>
 <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
 <47125BF7.2070503@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Reece Dunn <msclrhd@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 21:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih9OT-0007HI-8u
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 21:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbXJNTor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 15:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbXJNTor
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 15:44:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22885 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006AbXJNToq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 15:44:46 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JPX00M942V0YYB0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 14 Oct 2007 15:45:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <47125BF7.2070503@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60895>

On Sun, 14 Oct 2007, Steven Grimm wrote:

> Verbosity. IMO Mercurial swings too far in this direction, but in general it's
> either completely silent or very terse in its output. There is never, as far
> as I can see, any low-level diagnostic information spit out to the user unless
> an hg command is run with a "verbose" option. Here's "hg pull; hg update", for
> example (and "pull" is one of hg's chattier commands):
> 
> pulling from ../child1
> searching for changes
> adding changesets
> adding manifests
> adding file changes
> added 8 changesets with 8 changes to 3 files (+1 heads)
> (run 'hg heads' to see heads, 'hg merge' to merge)
> 3 files updated, 0 files merged, 0 files removed, 0 files unresolved
> 
> Compare with the equivalent "git pull" and put yourself in the shoes of a user
> who is running that command for the first time:

BTW I have patches here reworking the progress code for a more compact 
display which should mitigate this issue quite a bit.


Nicolas
