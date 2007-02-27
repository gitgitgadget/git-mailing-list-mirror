From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 20:45:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272040440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org>
 <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xejflk2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Josefsson <simon@josefsson.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:45:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8G8-0000q6-U7
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXB0TpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbXB0TpH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:45:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:60816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbXB0TpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:45:05 -0500
Received: (qmail invoked by alias); 27 Feb 2007 19:45:03 -0000
X-Provags-ID: V01U2FsdGVkX1/jg44Cairj57aTVkSiuR35oqNxk3jYvyVC5GaI6u
	oU7A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xejflk2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40774>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 27 Feb 2007, Simon Josefsson wrote:
> >
> >> * Is there a tool that produce ChangeLog files in the GNU format,
> >>   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
> >>   should look like:
> >> ...
> > Let me hack something.
> 
> I do not know why you want to pile something like this into builtin-log.  
> It would add maintenance burden and I do not see a gain from it.
> 
> One beauty of git is being scriptable.  When somebody new asks for 
> something like this, I think it is much more productive to demonstrate 
> the power of scriptability than piling random crap in the core.

Well, I briefly considered writing a little Perl script using the output 
of "git log --stat".

BUT. GNU ChangeLog is a really often asked-for feature. And before risking 
some Haskell script producing GNU ChangeLog output in git.git, which I 
have to rewrite as plugin eventually anyway, I thought that I include it 
right away.

Demonstrating the ease of Git's core, and hacking on Git was a benefit 
from it.

As were the first two patches: I think print_wrapped_text() only now got 
usable. And show_date() with an enum should be an improvement, too.

Anyway, it was the third time I read about such a request, and I had a go 
at it. If you don't like it, don't take it. I have no problems with that.

Ciao,
Dscho
