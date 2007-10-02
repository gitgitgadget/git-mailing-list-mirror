From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 2 Oct 2007 22:02:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710022200000.28395@racer.site>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
 <87bqbisae6.wl%cworth@cworth.org> <Pine.LNX.4.64.0710021045430.28395@racer.site>
 <87641psey8.wl%cworth@cworth.org> <Pine.LNX.4.64.0710021841300.28395@racer.site>
 <7vwsu5l6j8.fsf@gitster.siamese.dyndns.org> <BAYC1-PASMTP05AB6AE16E90C15710819EAEAE0@CEZ.ICE>
 <7vfy0tl4fd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, Carl Worth <cworth@cworth.org>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:03:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icou9-0005bW-4G
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXJBVDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbXJBVDg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:03:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:45054 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754426AbXJBVDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:03:35 -0400
Received: (qmail invoked by alias); 02 Oct 2007 21:03:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 02 Oct 2007 23:03:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QLrJACEjQUjSWCNRC+NwC5eDVpPzxGdSIFJJe+o
	C6Xmy2KJYXaYQm
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy0tl4fd.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59738>

Hi,

On Tue, 2 Oct 2007, Junio C Hamano wrote:

> The discussion between Johannes and I was about picking what default is 
> _reasonable_; Johannes made it sound like branches are norm and tags are 
> oddball.  I was merely pointing out that it won't be so cut-and-dried.

Actually, I had Carl Worth in mind when I asked the (rhetorical) question 
what is meant by "master:blub".  And I think Carl agrees that he would 
expect it to create a new branch.

However, as I hope I made clear that I do not think that a DWIMery would 
do good here.  IOW I vote for keeping the existing behaviour (otherwise 
you'd have seen a patch from me, too).

Ciao,
Dscho
