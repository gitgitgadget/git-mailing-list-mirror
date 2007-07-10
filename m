From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add for_each_remote() function, and extend
 remote_find_tracking()
Date: Tue, 10 Jul 2007 15:11:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101511440.4047@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
 <7vhcoexqeh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707091228290.5546@racer.site>
 <7v4pkduw2f.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707092203100.5546@racer.site>
 <7vzm25tex6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707100401070.4131@racer.site>
 <Pine.LNX.4.64.0707092323160.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:19:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GZ9-00028M-09
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbXGJOTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXGJOTh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:19:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:57510 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753358AbXGJOTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:19:36 -0400
Received: (qmail invoked by alias); 10 Jul 2007 14:19:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 10 Jul 2007 16:19:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+95Us6TXy96ZmVn7iIg4Q1Yz2Xv07W0/E+SKFA4b
	li472dFi7QDmg4
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707092323160.6977@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52078>

Hi,

On Mon, 9 Jul 2007, Daniel Barkalow wrote:

> On Tue, 10 Jul 2007, Johannes Schindelin wrote:
> 
> > The function for_each_remote() does exactly what the name suggests.
> > 
> > The function remote_find_tracking() was extended to be able to search
> > remote refs for a given local ref.  You have to set the parameter
> > "reverse" to true for that behavior.
> 
> I think I'd like this better if reverse meant that it looked at 
> refspec->dst and set refspec->src, rather than returning the refspec 
> reversed; the current version sets the refspec so that it's effectively 
> something from the list, which makes it easier to understand.
> 
> Maybe make it so the user calls it with at most one of src and dst NULL, 
> and it returns with neither NULL or returns -1 if it can't find anything?

Will do.

Ciao,
Dscho
