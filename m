From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 15:16:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512241509240.24308@wbgn013.biozentrum.uni-wuerzburg.de>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se>
 <009701c60891$50893fd0$6900a8c0@sps>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 15:43:26 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqX5j-0005fJ-3q
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 15:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVLYOnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Dec 2005 09:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVLYOnP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 09:43:15 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:49366 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750833AbVLYOnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 09:43:15 -0500
Received: by wrzx28.rz.uni-wuerzburg.de (Postfix, from userid 51)
	id 96498140A2F; Sun, 25 Dec 2005 15:43:13 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4A89D140C73; Sat, 24 Dec 2005 15:16:42 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rob McDonald <robm@asdl.gatech.edu>
In-Reply-To: <009701c60891$50893fd0$6900a8c0@sps>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14046>

Hi,

On Sat, 24 Dec 2005, Rob McDonald wrote:

> > Is there some reason you can't install Cygwin, which effectively
> > overcomes both those problems?
> 
> I've had consistently lousy luck with Cygwin which has left a bad taste in
> my mouth.  Cygwin is generally a lot slower than Mingw, although that is
> most noticeable when you're making extensive use of math.h.  Also, it seems
> that every time I install some package in Cygwin, something else I've
> installed gets messed up.  It just seems to me that there isn't any reason
> for an efficient command-line tool like git to depend on a large
> unmaintained project like Cygwin.

Well, cygwin is everything but unmaintained. It's unfair to blaim the good 
work of the cygwin folks if you can't get it to work. I have *never* had a 
problem I could not solve with cygwin. In particular, *no* package got 
messed up when I installed/upgraded another package. Before you ask: I use 
cygwin extensively.

> Of course, one could use -mno-cygwin (or whatever it is) to use the MinGW
> headers when compiling in Cygwin as an intermediate step.  That would give
> any speed advantages.

As I already stated, there are two *big* showstoppers when it comes to 
port git to MinGW.

> However, I've had great luck porting Linux apps using the gcc toolchain to
> Windows using MinGW.  All these programs 'just worked'.

Okay, I'll bite. Could you please port python to MinGW?

> Thanks for the comments.  The best idea may be to just try it....

You're welcome. Just be sure to tackle the hard problems first, else you 
end up having wasted lots of valuable time for nothing.

Hth,
Dscho
