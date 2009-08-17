From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] quick question about __stdcall at run-command.c
 mingw.c
Date: Mon, 17 Aug 2009 11:12:13 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171109091.4991@intel-tinevez-2-302>
References: <1976ea660908161619x5182762sade051f24fef13db@mail.gmail.com> <a5b261830908161703l2296448l698d07d01ae8a6d3@mail.gmail.com> <4A890C32.6010507@viscovery.net> <alpine.DEB.1.00.0908171018490.4991@intel-tinevez-2-302> <4A891840.4050403@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@googlemail.com>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 11:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McyGN-0004RL-3j
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 11:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538AbZHQJMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 05:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbZHQJMO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 05:12:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:51274 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757528AbZHQJMN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 05:12:13 -0400
Received: (qmail invoked by alias); 17 Aug 2009 09:12:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 17 Aug 2009 11:12:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jQiVeJc7jJjkLBoRefXTr1cqVjrIcuddOcq8xit
	cH0IsMuFuVngRZ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A891840.4050403@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126147>

Hi,

On Mon, 17 Aug 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Mon, 17 Aug 2009, Johannes Sixt wrote:
> >> Pat Thoyts schrieb:
> >>> 2009/8/17 Frank Li <lznuaa@gmail.com>:
> >>>> I am tring to clear VC build patch.
> >>>>
> >>>> I found __stdcall position break MSVC build.
> >>>>
> >>>> static __stdcall unsigned run_thread(void *data)
> >>>>
> >>>> MSVC require __stdcall should be between return type and function 
> >>>> name. like static unsigned __stdcall run_thread(void *data)
> >>>>
> >>>> I think msys gcc should support MSVC format.
> > 
> > I think that it does.
> > 
> > But it is _your_ duty to check.
> 
> Cool down. Asking for "please could you check whether this works" *if* 
> you don't have the infrastructure to test it yourself is certainly 
> dutyful enough.
> 
> Do you have an Irix, Solaris, HP box on your desk next to your Linux, so 
> that you don't have to ask others to test your patches?

This is Windows.  Frank has Windows.

Downloading msysGit does not incur any cost.  Actually running the whole 
thing from the net installer just takes a little time and a two-digit 
megabyte download.

I put a lot of work into making this procedure as painless to use (for 
other people, it caused me a lot of pain).  So Frank might just as well 
not let my effort go to hell.

Of course, Frank could ask one of the few msysGit contributors to try to 
compile something he prepared, wait for the results and possibly fix 
things for another round.  This appears as a rather poor use of 
everybody's time, methinks.

Ciao,
Dscho
