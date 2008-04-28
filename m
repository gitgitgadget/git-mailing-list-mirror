From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: my git problem
Date: Mon, 28 Apr 2008 20:13:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282012140.19187@eeepc-johanness>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org> <20080427124454.6a606305.akpm@linux-foundation.org> <alpine.LFD.1.10.0804271315010.3119@woody.linux-foundation.org>
 <20080428114509.240ef4ae.akpm@linux-foundation.org> <alpine.DEB.1.00.0804281948270.19187@eeepc-johanness> <20080428120917.dd9f01e8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:14:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYo9-0005D0-3y
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 21:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966387AbYD1TNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934487AbYD1TNg
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 15:13:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:42456 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966362AbYD1TNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 15:13:35 -0400
Received: (qmail invoked by alias); 28 Apr 2008 19:13:32 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 28 Apr 2008 21:13:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zG1o+a6jzZyDLmlQs6LqoPfhewLX2J45SEtlmKe
	TdyTuR37+6Feqj
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428120917.dd9f01e8.akpm@linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80591>

Hi,

On Mon, 28 Apr 2008, Andrew Morton wrote:

> On Mon, 28 Apr 2008 19:49:28 +0100 (BST) Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Mon, 28 Apr 2008, Andrew Morton wrote:
> > 
> > > hm, weirdness.
> > > 
> > > y:/usr/src/git26> git-diff origin...git-ia64   
> > > y:/usr/src/git26> git-log origin...git-ia64 | wc -l
> > > 15574
> > > 
> > > I'd have expected git-log to operate on the same patches as git-diff.
> > > 
> > > I'm sure there's a logical explanation for this ;)
> > 
> > Yes.  git-diff with "..." will show you the diff of git-ia64 since the 
> > branch point, whereas log will show you _all_ the logs (both in origin and 
> > in git-ia64) since the branch point.
> > 
> 
> That's missing the "logical" bit :)

Heh, you're right.  I am too used to Git to think how other people would 
feel about these things... :-)

> Oh well.  Can you suggest how I can extract the changelogs for the 
> patches which `git-diff origin...git-ia64' will print out?

I think you get what you want with

	$ git-log --cherry-pick origin...git-ia64

(although I might be wrong on the order of origin and git-ia64).

Ciao,
Dscho
