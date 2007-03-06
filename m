From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Tue, 6 Mar 2007 15:19:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703061518250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070306063501.GA24355@spearce.org> 
 <81b0412b0703060116m166e2da7saeab82c67536558e@mail.gmail.com> 
 <Pine.LNX.4.63.0703061422580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703060537u5140a034s91b35f0d842843a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOaVP-0006pM-1D
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 15:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbXCFOTF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 09:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbXCFOTE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 09:19:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:43539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965047AbXCFOTC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 09:19:02 -0500
Received: (qmail invoked by alias); 06 Mar 2007 14:19:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 06 Mar 2007 15:19:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JvUF4+KfJvRjJNEZ5H6VmkkgdWDtaquhQxbdMWM
	fgN9lE6Waqk9RT
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703060537u5140a034s91b35f0d842843a3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41585>

Hi,

On Tue, 6 Mar 2007, Alex Riesen wrote:

> On 3/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > ...
> > > >     CC builtin-grep.c
> > > > builtin-grep.c:187: warning: 'external_grep' defined but not used
> > >
> > > Can I suggest printing the resulting object file instead of source?
> > > It is useful if you want rebuild just one file by mouse-copy-paste it
> > > into command line (the source file name for editor in case of
> > > error is already in error message).
> > 
> > I don't understand.
> 
> Right. Because I was suggesting to output something like this:
> 
> $ make
> ...
>     CC builtin-grep.o
> builtin-grep.c:187: warning: 'external_grep' defined but not used
> 
> Notice "builtin-grep.o" (the ".o", not _.c_). IOW, we already
> see builtin-grep.c when we need it (in the error/warning message),
> BUT the builtin-grep.o is missing (and is useful for mouse-copy-paste).

Ah! That explains it why I did not understand.

Ciao,
Dscho
