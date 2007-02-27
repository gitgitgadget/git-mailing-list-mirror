From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 21:54:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272152460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org>
 <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xejflk2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702272040440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon Josefsson <simon@josefsson.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9Kx-0005Ay-2e
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbXB0UyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXB0UyM
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:54:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:60573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752591AbXB0UyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:54:11 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:54:10 -0000
X-Provags-ID: V01U2FsdGVkX1+7sA55eRK7XGnKuIQNFaPX0X7Biuy1z2McHI1e0v
	P06A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702272040440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40804>

Hi,

On Tue, 27 Feb 2007, Johannes Schindelin wrote:

> On Tue, 27 Feb 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Tue, 27 Feb 2007, Simon Josefsson wrote:
> > >
> > >> * Is there a tool that produce ChangeLog files in the GNU format,
> > >>   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
> > >>   should look like:
> > >> ...
> > > Let me hack something.
> > 
> > I do not know why you want to pile something like this into 
> > builtin-log.  It would add maintenance burden and I do not see a gain 
> > from it.
> > 
> > One beauty of git is being scriptable.  When somebody new asks for 
> > something like this, I think it is much more productive to demonstrate 
> > the power of scriptability than piling random crap in the core.
> 
> Well, I briefly considered writing a little Perl script using the output 
> of "git log --stat".

Side note. I am not a good enough Perl/Shell/Python hacker to know how to 
wrap text correctly to reflect GNU ChangeLog format. That is why I wrote 
print_wrapped_text() in the first place.

Ciao,
Dscho
