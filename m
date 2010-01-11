From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 21:01:14 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001102055070.10143@xanadu.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
 <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Leo Razoumov <slonik.az@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 03:01:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU9bB-00087w-6s
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 03:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab0AKCBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 21:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412Ab0AKCBS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 21:01:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23608 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab0AKCBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 21:01:15 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KW200F018A2U080@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Jan 2010 21:01:14 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <ee2a733e1001101736p2f395de6ka05044fe7cca624d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136596>

On Sun, 10 Jan 2010, Leo Razoumov wrote:

> On 2010-01-10, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sun, 10 Jan 2010, Junio C Hamano wrote:
> >  >
> >  > A feel good factor is in play?  IOW, "I am short of time, so I won't be
> >  > able to really afford to 'git pull' and test the result of re-integrating
> >  > my changes to what happened on the other end.  If I can learn that there
> >  > is nothing happening over there, then I won't have to do anything and know
> >  > that I am up to date."
> >
> >
> > Just do a fetch then.  If the fetch progress display looks like if it is
> >  going to take a while then just interrupt it and go home.  If the fetch
> >  looks trivial then just merge it.  In any case, the "feel good" factor
> >  can't be that great by only knowing if the remote has changed or not.
> >
> 
> Forced interruption is not such a good idea. I would favor a
> non-destructive way to monitor availability of remote commits.

You still don't answer my question though.  Again, _why_ do you need to 
know about remote commit availability without fetching them?

> BTW, pull and push are in a way symmetric operations. Is there any
> deep reason why push supports --dry-run but pull/fetch does not??

Pushing involves resource usage on your own machine while 
pulling/fetching involves the remote machine.  Your choice to "waste" 
CPU cycles on your own machine is not the same as having anybody do the 
same on a central server.


Nicolas
