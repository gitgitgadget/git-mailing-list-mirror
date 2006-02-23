From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 23 Feb 2006 21:19:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602232112200.31035@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
 <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
 <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se>
 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
 <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
 <Pine.LNX.4.64.0602230911410.3771@g5.osdl.org> <7virr5hnw4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0602232037260.30630@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602231151580.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 21:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMvh-0000Ls-4k
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 21:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWBWUTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 15:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWBWUTJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 15:19:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:36542 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932082AbWBWUTI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 15:19:08 -0500
Received: (qmail invoked by alias); 23 Feb 2006 20:19:07 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp038) with SMTP; 23 Feb 2006 21:19:07 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602231151580.3771@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16663>

Hi,

On Thu, 23 Feb 2006, Linus Torvalds wrote:

> On Thu, 23 Feb 2006, Johannes Schindelin wrote:
> > > 
> > > Before anybody mentions tcl ;-).
> > 
> > Darn, I had my suggestion sent out: Java ;-)
> 
> I do see the smileys, but the fact is, "perl" is a hell of a lot more 
> portable than either, if we want to talk executing processes and pipelines 
> etc. But even perl is clearly not portable enough, and has tons of version 
> skew.
> 
> Java, afaik, has absolutely _zero_ support for creating a new process and 
> piping its output to another one and doing things like safe argument 
> expansion. Which is what almost all of the git scripts are all about.

You are right, but for the wrong reason. Java is actually a wonderful 
thing to create new processes and talk between threads.

But Java is HUGE. No, it is rather HOOODGEEE.

And I don't know if something like Lua does any good. The problem is not 
so much the language. It is the fork().

AFAIAC, cygwin is pretty good at hiding Windows behind sortofa POSIX 
layer. <tongue-in-cheek>It hides it behind a POSIX layer *and* a 
performance hit.</tongue-in-cheek>

I would rather like to see how all the fork()ing and |'ing can be done 
with MinGW32.

Ciao,
Dscho
