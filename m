From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 00:30:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com> <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de> <20090319214001.GA6253@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRgc-0005wQ-0o
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbZCSX2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754188AbZCSX2f
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:28:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:49040 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752890AbZCSX2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:28:35 -0400
Received: (qmail invoked by alias); 19 Mar 2009 23:28:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 20 Mar 2009 00:28:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/o6kw6f1fo8mXwr0QfiO93IqP2qYzL+fMydEeY73
	SE8HGcNRzO+KmJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090319214001.GA6253@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113862>

Hi,

On Thu, 19 Mar 2009, Alex Riesen wrote:

> Johannes Schindelin, Thu, Mar 19, 2009 11:57:01 +0100:
> 
> > I'd rather just disable WIN32_STAT for Cygwin, because otherwise, we 
> > will keep running into issues.
> 
> I'd rather not. The thing is just so unbelievably slow and being stuck 
> on it I'm just trying my damnedest to squeeze every last bit of 
> performance out of it.

If you are serious about performance, you will not stay with Cygwin -- for 
the purposes of Git.

Do not get me wrong: Cygwin is a wonderful thing if your goal is to spare 
yourself a lot of trouble with that seriously challenged win32 API.

But if your goal is to get the most out of the Win32 API in terms of 
speed, you _will_ have to go with MinGW (at least, as long as you are 
unwilling to shell out big bucks in the vague direction of Redmond, and 
add some time tax to that).

Now, we _do_ have msysGit, you _do_ have shown the capability to fix 
issues when they arise, so I do _not_ see any obstacle why you should not 
go msysGit, rather than staying with the pain of trying to stay 
POSIX-compatible, but not quite all the time.

Ciao,
Dscho
