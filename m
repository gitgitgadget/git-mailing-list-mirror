From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 2 Oct 2007 21:59:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710022159090.28395@racer.site>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
 <87bqbisae6.wl%cworth@cworth.org> <Pine.LNX.4.64.0710021045430.28395@racer.site>
 <87641psey8.wl%cworth@cworth.org> <Pine.LNX.4.64.0710021841300.28395@racer.site>
 <7vwsu5l6j8.fsf@gitster.siamese.dyndns.org> <BAYC1-PASMTP05AB6AE16E90C15710819EAEAE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Carl Worth <cworth@cworth.org>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icorl-0004ee-HW
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbXJBVBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbXJBVBI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:01:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:32795 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753936AbXJBVBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:01:07 -0400
Received: (qmail invoked by alias); 02 Oct 2007 21:01:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp045) with SMTP; 02 Oct 2007 23:01:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cssRyGeycioAipI5oHp2IglgdA5Idy15IXoQDs5
	xarGKi1SDsTUNc
X-X-Sender: gene099@racer.site
In-Reply-To: <BAYC1-PASMTP05AB6AE16E90C15710819EAEAE0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59734>

Hi,

On Tue, 2 Oct 2007, Sean wrote:

> On Tue, 02 Oct 2007 11:23:39 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
> > If your push were "next~27^2:frotz", it becomes even less clear. It 
> > may be that I am pushing out the tip of a topic branch I usually do 
> > not push out, so it would be easier for some specific person to build 
> > on top of.  Or maybe I am marking that place as a lightweight tag.  
> > They are equally likely.
> 
> But you could pick a reasonable default in assuming that a new branch is 
> desired with the above example.  If someone wants to push a tag, they 
> can create the tag locally, and then push it.

And if someone wants to push a branch, they can create the branch locally, 
and then push it.  (Your last sentence with s/tag/branch/g applied.)

Ciao,
Dscho
