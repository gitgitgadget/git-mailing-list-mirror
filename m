From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 15 Oct 2007 22:48:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710152245530.19446@xanadu.home>
References: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
 <Pine.LNX.4.64.0710130130380.25221@racer.site> <853awepyz6.fsf@lola.goethe.zz>
 <20071013202713.GA2467@fieldses.org>
 <Pine.LNX.4.64.0710140135020.25221@racer.site>
 <alpine.LFD.0.999.0710131810550.6887@woody.linux-foundation.org>
 <20071014014445.GN27899@spearce.org>
 <3f4fd2640710140320h5c1e1f7gf9f43a626aaa6897@mail.gmail.com>
 <47125BF7.2070503@midwinter.com>
 <alpine.LFD.0.9999.0710141542020.19446@xanadu.home>
 <20071015232017.GS27899@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Steven Grimm <koreth@midwinter.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 04:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhcVE-0008BF-PX
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 04:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828AbXJPCtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 22:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757676AbXJPCtm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 22:49:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63359 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829AbXJPCtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 22:49:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JPZ00I5TH5YWD00@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Oct 2007 22:49:10 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071015232017.GS27899@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61065>

On Mon, 15 Oct 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > BTW I have patches here reworking the progress code for a more compact 
> > display which should mitigate this issue quite a bit.
> 
> git-gui is scraping the output of the current progress meter using
> a regex and then building a graphical progress bar from that output.

Erk!

> Any change in how git produces the progress bar should still keep
> it in a form that git-gui can regex match and scrape, preferably
> without needing to know what version of git it is pulling that
> output from.  For example just teach git-gui to try two different
> regexps, new format and if that doesn't match then try the old
> (aka current) format.

I think my new format might be easier for you as the "title" and the 
actual percentage and count is now on the same line.


Nicolas
