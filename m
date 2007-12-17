From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 15:41:24 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
 <m3fxy5qwbq.fsf@roke.D-201>
 <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
 <20071214215206.GB7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
 <20071214223957.GC7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
 <20071217200920.GB19816@mail.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:42:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Mmi-0007fz-MP
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:41:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557AbXLQUl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759206AbXLQUl0
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:41:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30557 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757557AbXLQUlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:41:25 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT700492O50YQ90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Dec 2007 15:41:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071217200920.GB19816@mail.oracle.com>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68614>

On Mon, 17 Dec 2007, Joel Becker wrote:

> On Fri, Dec 14, 2007 at 09:23:38PM -0500, Nicolas Pitre wrote:
> > On Fri, 14 Dec 2007, Joel Becker wrote:
> > > 	The relevant message is:
> > > 
> > > Message-ID: <7vveaindgp.fsf@gitster.siamese.dyndns.org>
> > > 
> > > See the paragraphs at the bottom.  The thread, started by me, begins
> > > with:
> > > 
> > > Message-ID: <20070910205429.GE27837@tasint.org>
> > 
> > OK.  From those emails Junio forwarded to me, I don't see any case for 
> > actual _corruptions_.  Git does indeed refuse to work with unknown pack 
> > index or unknown objects in a pack.  Really old versions were not overly 
> > clueful as to why they refused to work, but they should never corrupt a 
> > pack which, for all purposes, is always read-only anyway.
> 
> 	You may not see a case for actual corruptions, but my coworker
> updated his tree on a box with 1.5.x, then tried to work on a box with
> 1.4.x (I think 1.4.2 back then), and ended up with a tree that was
> unusable.  He had to re-clone, and I think he got lucky recovering
> pending changes (probably using 1.5.x on the branches with the changes,
> as master was what got broken).

I still claim that there wasn't any corruptions.

Just for fun, just edit some document with Microsoft Office 95, then 
open the same document with Office 2007 and save it with default 
settings.  Now try to open it back with Office 95.  It won't work.  
Does that mean that the document got corrupted?

> 	My point is not that change is always bad, but that we should
> really look forward to what we're doing, and that "it's in the release
> notes" is not sufficient if an older git gives an incomprehensible error
> or a silent problem.  I was responding to the cavalier statement "well,
> it's in the release notes, so don't worry about older versions".

Your allegation of corruptions is cavalier just as well.

I'm telling you that there won't be any such corruption.  Just like in 
the M$ Office case, it is expected that newer versions make data 
unusable by older versions at some point -- that's the inevitable side 
effect of progress.

And we cannot always anticipate what kind of incompatibility will be 
worth making in the future, so it is hard to come with proper error 
messages in all cases today.

Recent enough Git versions do suggest upgrading when they refuse to 
access repositories though, and later Git versions can be configured to 
remain compatible with old Git versions.  And we also document it.

And when you still cannot figure it out on your own, then there is that 
free support available on a public mailing list, and even an IRC 
channel.

So I don't see how we could do better in that regard.  Carving the 
repository format in stone to keep ancient versions working forever is 
_not_ a solution.


Nicolas
