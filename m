From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sun, 9 Jun 2013 05:07:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1306090502470.28957@s15462909.onlinehome-server.info>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg Troxel <gdt@ir.bbn.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 05:07:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVyz-00009J-LR
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 05:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3FIDHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 23:07:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:61848 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3FIDHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 23:07:36 -0400
Received: from mailout-de.gmx.net ([10.1.76.30]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MgJFg-1UzBTN2oyM-00Nior for
 <git@vger.kernel.org>; Sun, 09 Jun 2013 05:07:35 +0200
Received: (qmail invoked by alias); 09 Jun 2013 03:07:35 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp030) with SMTP; 09 Jun 2013 05:07:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+s56RjAkWs9zXdjJu4XoX0Utn+kt7/VAa8wXdINl
	clqcjKncZs+866
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226876>

Hi Duy,

On Sat, 8 Jun 2013, Duy Nguyen wrote:

> On Thu, Jun 6, 2013 at 11:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Greg,
> >
> > On Thu, 6 Jun 2013, Greg Troxel wrote:
> >
> >> As one of the people who helps maintain git packages in pkgsrc, my
> >> initial reaction is negative to adding a ruby dependency.
> >
> > My initial reaction, too. It was hard enough to get Perl included with Git
> > for Windows (because of that pesky Subversion dependency).
> >
> > As you can see from the commit history, I was the primary force behind
> > trying to get everything "core" in Git away from requiring scripting
> > languages (I think it is an awesome thing to provide APIs for as many
> > languages as possible, but a not-so-cool thing to use more than one
> > language in the core code). It does not seem that anybody picked up that
> > task when I left, though.
> 
> Nobody seems to mention it yet. There's another reason behind the C
> rewrite effort: fork is costly on Windows. The C rewrite allows us to
> run with one process (most of the time). This applies for shell, perl
> and even ruby scripts because libgit.a is never meant to be used
> outside git.c context (unlike libgit2). In this regard, ruby is just
> as bad as currently supported non-C languages.

I think you should have said "on Windows" when you said "fork is costly".
Oh wait, you did.

It seems that at least some people participating in this discussion are
not overly keen on supporting the platform that -- according to
statistics, i.e. facts -- is the most prevalent.

I am glad that Junio still seems to be interested in giving us poor folks
trying to make the Git experience on Windows a less sucky one enough
credit, even if we only got a little over 900 commits into git.git. But
that does not count because the commits are older than one year. That
makes them useless to some people, apparently.

Hopefully Junio will have more mercy on us poor Windows folks than others
would,
Dscho
