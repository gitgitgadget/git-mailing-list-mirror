From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: How to check new commit availability without full fetch?
Date: Sun, 10 Jan 2010 16:05:41 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001101556490.10143@xanadu.home>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <alpine.LFD.2.00.1001101501520.10143@xanadu.home>
 <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Leo Razoumov <slonik.az@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 22:08:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU4yo-0001xT-G2
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 22:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab0AJVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 16:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131Ab0AJVFm
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 16:05:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58037 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab0AJVFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 16:05:42 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KW100E3VULH7C70@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Jan 2010 16:05:41 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v8wc5itlc.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136589>

On Sun, 10 Jan 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> >> I am sure I am not the only one with such an itch.
> >
> > Maybe you are. There is very little point knowing that the remote repo 
> > has new commits if you're not going to fetch them, so I don't understand 
> > why you need this.
> 
> A feel good factor is in play?  IOW, "I am short of time, so I won't be
> able to really afford to 'git pull' and test the result of re-integrating
> my changes to what happened on the other end.  If I can learn that there
> is nothing happening over there, then I won't have to do anything and know
> that I am up to date."

Just do a fetch then.  If the fetch progress display looks like if it is 
going to take a while then just interrupt it and go home.  If the fetch 
looks trivial then just merge it.  In any case, the "feel good" factor 
can't be that great by only knowing if the remote has changed or not.  

Well maybe if it hasn't changed then you know right away how to feel 
about it (equally with a fetch in that case), and if the remote is 
indeed different then you can't tell whether the changes are trivial or 
not without actually fetching them.


Nicolas
