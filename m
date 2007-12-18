From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 22:34:40 -0500 (EST)
Message-ID: <alpine.LFD.0.999999.0712172224560.8467@xanadu.home>
References: <m3fxy5qwbq.fsf@roke.D-201>
 <alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
 <20071214215206.GB7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
 <20071214223957.GC7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
 <20071215004230.GF7300@mail.oracle.com>
 <alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
 <20071217200920.GB19816@mail.oracle.com>
 <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
 <20071218021556.GC13821@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Fasheh <mark.fasheh@oracle.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 04:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4TEd-00023z-Qo
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 04:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXLRDel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 22:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbXLRDel
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 22:34:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37792 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbXLRDel (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 22:34:41 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JT800DPM79SJNB0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Dec 2007 22:34:40 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071218021556.GC13821@ca-server1.us.oracle.com>
User-Agent: Alpine 0.999999 (LFD 847 2007-12-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68693>

On Mon, 17 Dec 2007, Mark Fasheh wrote:

> Hi,
> 
> 	Just to "out" myself, I'm the "co-worker" whose name Joel has been
> (politely) keeping anonymous.
> 
> On Mon, Dec 17, 2007 at 03:41:24PM -0500, Nicolas Pitre wrote:
> > > 	You may not see a case for actual corruptions, but my coworker
> > > updated his tree on a box with 1.5.x, then tried to work on a box with
> > > 1.4.x (I think 1.4.2 back then), and ended up with a tree that was
> > > unusable.  He had to re-clone, and I think he got lucky recovering
> > > pending changes (probably using 1.5.x on the branches with the changes,
> > > as master was what got broken).
> > 
> > I still claim that there wasn't any corruptions.
> 
> The following description is really vague because this was a while ago:
> 
> Something made my ocfs2.git tree unusable in that I could no longer do
> common tasks, such as git-log, etc without getting messages about corrupted
> refs.
> 
> I wish I had saved off some of the messages. Sorry.
> 
> I had to re-create my git tree several times before I learned by deduction
> that it was the older versions of git on some of the machines that were
> writing some sort of incompatible format.

Next time please don't hesitate to post your issue on this list.  The 
fix could have been so obvious to many people on the list, saving you 
time and frustration.  In your case I think the "fix" would have 
consisted of simply running "git repack -a -d" on the machine with the 
most recent Git version.

And if it was a case of real corruption then we certainly would have 
liked to know about it ASAP.

> > Just for fun, just edit some document with Microsoft Office 95, then 
> > open the same document with Office 2007 and save it with default 
> > settings.  Now try to open it back with Office 95.  It won't work.  
> > Does that mean that the document got corrupted?
> 
> Boy, I hope Microsoft Office isn't our bar for compatiblity here...

We can do better of course, like allowing you to still produce the old 
format with a new version of Git.  But sometimes format changes are 
unavoidable for many good reasons.


Nicolas
