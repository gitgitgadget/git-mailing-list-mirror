From: Nicolas Pitre <nico@cam.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 16:17:12 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703191608340.18328@xanadu.home>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com>
 <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
 <45FEE629.8030606@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: John Goerzen <jgoerzen@complete.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOIK-0001LV-R4
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXCSURP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbXCSURP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:17:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59151 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbXCSURO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:17:14 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF600CVX30OOTD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Mar 2007 16:17:13 -0400 (EDT)
In-reply-to: <45FEE629.8030606@midwinter.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42664>

On Mon, 19 Mar 2007, Steven Grimm wrote:

> Nicolas Pitre wrote:
> > And some will argue that explicit renames are susceptible to user error
> > misidentifying the rename too, certainly in the 1% figure of all renames if
> > not more.
> >   
> 
> If you're using "git mv" instead of "mv" to do the rename, it is impossible to
> misidentify the rename since the rename and identification are happening in
> the same command with no additional inputs that could confuse anything.

I was actually referring to someone using cp + rm + {svn|hg|whatever} to 
commit a rename in which case the tool won't know.  And I'm sure that 
happens more than 1% of the time.

> If you
> are talking about adding a new tool that can manually tag a rename after the
> fact, then I can't disagree with you except to say that the fact that no such
> command exists today means any estimate of user error rate is pure
> speculation.

Sure.  

> Aside from that, the possibility of user error is an entirely different thing
> than the possibility of tool error -- if I misidentify a rename, I will blame
> myself, not the version control system, and rightly so. People are expected to
> make mistakes from time to time. But if my version control tool misidentifies
> a rename on my behalf, and there's nothing I can do about it because there's
> no way to influence the tool's concept of what got renamed to what, then I'm
> not going to consider it a failure of the tool, not a mistake on my part.

But GIT's rename heuristics can be modified/improved, and all renames 
that were wrongly identified before will suddenly be fixed.

If the rename is part of the recorded history then there is nothing you 
can do to fix mistakes, be it human or tool based.

> > So maybe, just maybe, at the end of the day getting renames right 100% of
> > the time instead of 99% is not such a big thing after all.
> >   
> 
> For me personally, that is true -- but I'd still prefer that extra 1%.

I'm sure the human screwups is at _least_ in the 1% range.  So even if 
you think you should know better, being a human you'll make a mistake 
eventually so you won't have that 100% anyway.


Nicolas
