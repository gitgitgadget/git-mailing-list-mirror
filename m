From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-checkout: use struct lock_file correctly
Date: Thu, 14 Feb 2008 18:55:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141854280.30505@racer.site>
References: <alpine.LNX.1.00.0802071137490.13593@iabervon.org> <alpine.LSU.1.00.0802141816120.30505@racer.site> <alpine.LNX.1.00.0802141319380.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 19:56:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPjFV-0008Kt-Ad
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 19:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362AbYBNSzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 13:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756733AbYBNSzU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 13:55:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:41864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757058AbYBNSzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 13:55:19 -0500
Received: (qmail invoked by alias); 14 Feb 2008 18:55:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 14 Feb 2008 19:55:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18j6Qt5OGMjEZK/ylrvxWBZjCzDA31VIbDo95Asqz
	WemeLG0PqqPI0O
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802141319380.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73904>

Hi,

On Thu, 14 Feb 2008, Daniel Barkalow wrote:

> On Thu, 14 Feb 2008, Johannes Schindelin wrote:
> 
> > A lock_file instance must not be cleaned up, since an atexit() handler 
> > will try to access even correctly committed lock_files, since it has 
> > to make sure that they were correctly committed.
> 
> I think the lock_file API changed between when I wrote this code (using 
> other code as reference) and now; could you check that there aren't other 
> things I have to change as well, since I think you were following the 
> lock_file changes at the time, and I wasn't?

I think the rest is safe.  (Of course, I grepped for "struct lock_file" in 
the _whole_ working directory).

Ciao,
Dscho
