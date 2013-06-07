From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 05:25:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-15?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 05:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UknJI-0006nL-OC
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 05:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3FGDZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 23:25:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:53555 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab3FGDZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 23:25:41 -0400
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MgJ3I-1UzYlZ3WGE-00Njnw for
 <git@vger.kernel.org>; Fri, 07 Jun 2013 05:25:39 +0200
Received: (qmail invoked by alias); 07 Jun 2013 03:25:39 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp029) with SMTP; 07 Jun 2013 05:25:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Gc0ISbhSGg7QNfvPnOMR/+4deLUsUYFCKmva3C/
	KiqOReCBz8wmpB
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226582>

Hi Ram,

On Fri, 7 Jun 2013, Ramkumar Ramachandra wrote:

> Johannes Schindelin wrote:
> > My initial reaction, too. It was hard enough to get Perl included with Git
> > for Windows (because of that pesky Subversion dependency).
> 
> Nevertheless, we had to do it, and we did it.

That is not quite correct. *I* did it. Not *we*. And I will not do it
again.

> We will do it again, if we get enough important code written in Ruby.

I am a bit bored by this hypothetical talk. This hypothetical "we will do
it again", to be precise. Given my experience, it would be very painful if
"enough important code" was written in Ruby. Nobody would help me "do it
again". Just like nobody helps right now to upgrade to a newer Perl. Feel
free to prove me wrong. Until that time, I will firmly believe that there
is no "we will do it again".

So here is a chance to prevent that: not repeat the mistake, and stay away
from language hell by avoiding to require yet another language.

> > As you can see from the commit history, I was the primary force behind
> > trying to get everything "core" in Git away from requiring scripting
> > languages (I think it is an awesome thing to provide APIs for as many
> > languages as possible, but a not-so-cool thing to use more than one
> > language in the core code). It does not seem that anybody picked up
> > that task when I left, though.
> 
> Rewriting everything in C?  Is anyone bored enough to pick up this task?
> Bourne shell is a great language for prototyping; git-rebase.sh (and
> friends), git-stash.sh, git-pull.sh are doing just fine.  Sure, it makes
> sense to do heavy-lifting in C, and this is happening as it has always
> been happening (remember git-commit.sh?).  If you followed the list
> emails, you'd know that Felipe is looking into delegating large portions
> of the work done by git-rebase.sh to sequencer.c.

As you know, there are very good reasons why I do not follow those mails.

> Anyway, all this talk about some hypothetical ideas just bores me.
> What matters is what is currently happening.  And nobody is actively
> rewriting the "core in Git" in C, so I don't see the point of
> discussing anything but patches.

Exactly. Nobody really cares about keeping Git portable enough. Hence my
impression that this idea to start requiring yet another language for core
parts of Git is a bit misguided, and only logical from the point of view:
"If you don't like it, why don't you install Linux?" (which, just in case
you wondered, is a pretty naive way of looking at the real world).

Ciao,
Johannes
