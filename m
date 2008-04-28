From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 23:04:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282302580.27457@eeepc-johanness>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428143501.7d6e3ad0.akpm@linux-foundation.org> <alpine.LFD.1.10.0804281437160.3119@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:05:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqbTL-000639-O6
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 00:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965638AbYD1WEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 18:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbYD1WEa
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 18:04:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:59601 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964981AbYD1WE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 18:04:29 -0400
Received: (qmail invoked by alias); 28 Apr 2008 22:04:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp053) with SMTP; 29 Apr 2008 00:04:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NtFgsBv/NlHAedLok6NQ73cRes5DgkHDg3MPDj+
	7Hvv6cbUA9rP2x
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.LFD.1.10.0804281437160.3119@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80627>

Hi,

On Mon, 28 Apr 2008, Linus Torvalds wrote:

> On Mon, 28 Apr 2008, Andrew Morton wrote:
> > 
> > origin.patch (generated via git-diff v2.6.25...origin) has:
> > 
> > commit 7f424a8b08c26dc14ac5c17164014539ac9a5c65
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Fri Apr 25 17:39:01 2008 +0200
> > 
> >     fix idle (arch, acpi and apm) and lockdep
> > 
> > 
> > and git-x86 (generated via git-diff origin...git-x86) has:
> > 
> > commit 0a1679501624482a06c19af49d55b68d3973e2f0
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Fri Apr 25 17:39:01 2008 +0200
> > 
> >     fix idle (arch, acpi and apm) and lockdep
> >     
> > 
> > which I assume is the same patch as a different commit.
> 
> Yes. 

FWIW that is why I suggested using --cherry-pick.  It tries to filter out 
the patches from "upstream" by calculating a patch-id (Basically a SHA-1 
of the patch), and leaving out all commits from "downstream" with the same 
patch-id.

Of course, it does not always work perfectly, because it wants a context 
of 3 lines to agree.

Ciao,
Dscho
