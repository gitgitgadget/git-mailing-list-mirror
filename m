From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 23:33:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003052331140.20986@pacific.mpi-cbg.de>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>  <alpine.DEB.1.00.1003050953580.20986@pacific.mpi-cbg.de> <32541b131003051022oe64428bsa387e64e30bbeaab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: walt <w41ter@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 23:26:14 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnfyI-00071K-EV
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 23:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173Ab0CEW0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 17:26:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:34548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755337Ab0CEW0C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 17:26:02 -0500
Received: (qmail invoked by alias); 05 Mar 2010 22:26:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp072) with SMTP; 05 Mar 2010 23:26:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+l45U0N0ul37rq5bMCvCrFukWYvEdBRL11pz15T5
	x1l5MRjSJ2WOkV
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <32541b131003051022oe64428bsa387e64e30bbeaab@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141599>

Hi,

On Fri, 5 Mar 2010, Avery Pennarun wrote:

> On Fri, Mar 5, 2010 at 4:25 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > The trick now is to craft the commit in such a manner that it will not be
> > noticed retro-actively. This is a simple case of social engineering: you
> > have to imitate the style of the committer/author you are impersonating.
> > The commit message must look like the usual ones (typos, preferred words,
> > grammar, length of paragraphs, comprehensibility, etc)
> >
> > Likewise, the code has to be analyzed for style, and obviously for most
> > likely targets of a backdoor (both in terms of "it is a perfect spot for
> > a backdoor" and "it is not uncommon for the author to touch that
> > part of the code").
> 
> There is still one major advantage to preventing modification of past
> commits: once you find out there's been a breach, you can just go back
> through the commits *since* the breach and double-check them.

If you find out which commit it was in the past, you can always revert it. 
It does not take Git to do it.

I am all in favor of Git, yes, but let's be honest: Git does not prevent 
an intelligent break-in.

To repeat, as I seem to not have made the point before: a break-in is a 
social problem, so it requires a social solution.

Ciao,
Dscho
