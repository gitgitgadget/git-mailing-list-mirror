From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Add --quoted option to produce machine-parsable
 output
Date: Mon, 21 May 2007 22:53:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705212252570.6410@racer.site>
References: <20070520225953.GK4085@planck.djpig.de>
 <11797696193384-git-send-email-frank@lichtenheld.de> <7vejladpfr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0705211945470.6410@racer.site> <7vbqgddgff.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 23:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqFqB-0003aF-V1
	for gcvg-git@gmane.org; Mon, 21 May 2007 23:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763110AbXEUVyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 17:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763149AbXEUVyP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 17:54:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:46609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763110AbXEUVyO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 17:54:14 -0400
Received: (qmail invoked by alias); 21 May 2007 21:54:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 21 May 2007 23:54:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vzSIHs/Nv6bAsm1ZiqkLadMdGrqyk+kcYWu6vu7
	7fzxw11D/YhR3x
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqgddgff.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48055>

Hi,

On Mon, 21 May 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Git.pm could simply do:
> >> 
> >> 	my $eval = `git config --perl --get-regexp 'gitcvs\..*'`;
> >> 	my $cfg = eval "$eval";
> >> 
> >> if you code your "perl" notation to produce:
> >> 
> >> 	+{
> >> 		'gitcvs.ext.enabled' => 'false',
> >>                 'gitcvs.logfile' => '/var/log/gitcvs.log',
> >> 	}
> >> 
> >> in order to read things in.
> >> 
> >> Hmm?
> >
> > IOW, something like 
> > http://article.gmane.org/gmane.comp.version-control.git/36922
> 
> Indeed (perhaps except fixing minor details like not hijacking
> the variable name).  Care to resubmit with docs and tests?

Well, my version was not good, as Eric pointed out.

Do you want me to clean up Eric's version (according to my own comments, 
that is)?

Ciao,
Dscho
