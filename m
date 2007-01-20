From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 10:28:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701201025070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45AF5F83.6090207@fs.ei.tum.de> <Pine.LNX.4.63.0701181441010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vps9ag58g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200052210.12889@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvej2bkn2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701200213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 10:28:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8CWI-0007td-KG
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 10:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbXATJ2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 04:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbXATJ2N
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 04:28:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:54001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965237AbXATJ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 04:28:12 -0500
Received: (qmail invoked by alias); 20 Jan 2007 09:28:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 20 Jan 2007 10:28:11 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfya69xym.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37260>

Hi,

On Fri, 19 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > P.S.: Perhaps you should just stop worrying and learn to love --reverse 
> > ;-)
> 
> Another thing to think about is how --reverse should interact
> with --max-count and --skip (and perhaps --max-age but I am not
> sure about that one).
> 
> I think there are two very valid ways.  You determine what you
> would spit out as if there is no --reverse, and then reverse the
> result, or you do not limit with them to get everthing, reverse
> the result and do the counting limit on that reversed list.

Evidently, I did not even think about the latter. And I guess that most 
people expect the former, too. (Maybe we should make it a flipflop, so 
that "--reverse --reverse" unsets the reverse flag again?

> I do not think you would need to artificially make it limited like your 
> patch does if you go this route

Why? To see the last commit (which should be output first), I _have_ to 
traverse them first, before reversing the order. I thought revs->limited 
does exactly that -- traverse all commits first. Am I mistaken?

Ciao,
Dscho
