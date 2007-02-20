From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Tue, 20 Feb 2007 14:26:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702201420550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702191839.05784.andyparkins@gmail.com>
 <200702201021.58754.andyparkins@gmail.com> <7vabz9w270.fsf@assigned-by-dhcp.cox.net>
 <200702201057.21398.andyparkins@gmail.com>
 <Pine.LNX.4.63.0702201235350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DAE893.9030204@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Tue Feb 20 14:26:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJV0X-0000TZ-2G
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 14:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbXBTN0J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 08:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbXBTN0J
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 08:26:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:53253 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964856AbXBTN0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 08:26:08 -0500
Received: (qmail invoked by alias); 20 Feb 2007 13:26:06 -0000
X-Provags-ID: V01U2FsdGVkX19hSrd4JYZhalBEjXBxk6+TUgHCsi+yROdvM0zRYm
	nrtA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45DAE893.9030204@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40237>

Hi,

On Tue, 20 Feb 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> > > I've never really liked "!" on strcmp() lines (but I accept that that is
> > > the tradition in git) because it implies the the output of prefixcmp is
> > > boolean, but it's actually ternary.
> > 
> > Actually, it's not even ternary, but to the return value should only be
> > handled in terms of >0, ==0, <0.
> > 
> > Ah, and if "!" implies a boolean, then why is "!!" a common construct?
> > Because "!" really does not imply a boolean.
> 
> Depends on how you look at it.  I code using semantics which use 
> expressions only as boolean if they are really are.

There are no booleans in C.

Also, you just state that the construct is not common for _you_. It is 
really quite common in C. Why? Because it is a short way to say _exactly_ 
what you want. Like when you say "BTW" instead of "by the way". It is not 
only quicker to type, it is also quicker to read.

> Even after so many years of breathing C, I find "if (!strcmp(foo, bar))" 
> misleading, suggesting "not compare", which translates to "not equal".

No, in plain English "!strcmp("nothing", u)" translates to "nothing 
compares to u.

In mathematics, which is the basis of computer languages, "not compare" 
means something completely different yet: "a" does not compare to "b" 
means that they cannot be compared at all, i.e. the statement "a<b" is 
neither true nor false.

So, we have -- as so often -- a case, where somebody says "it is obvious 
how this expression translates to English", but really, it is not. So, why 
not stay in the context, and interpret it like millions of programmers 
before us? Or do you want to start another Babel?

Ciao,
Dscho
