From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 12:08:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909281059180.4985@pacific.mpi-cbg.de>
References: <h9nlhj$heq$1@ger.gmane.org> <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: newsgroups@catchall.shelter13.net, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 12:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsD7c-00042y-So
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 12:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbZI1KGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 06:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZI1KGK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 06:06:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:59698 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751596AbZI1KGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 06:06:10 -0400
Received: (qmail invoked by alias); 28 Sep 2009 10:06:12 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 28 Sep 2009 12:06:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uZccKg9Iukag6cCatCExGfB1XwzEqnbTPLJptWd
	VHMi0Q9l10dqCu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129244>

Hi,

I tried to refrain from commenting in this thread, because I do not want 
to encourage people just to use msysGit and never even attempt to fix 
their own issues.

But I cannot let this go uncommented:

On Mon, 28 Sep 2009, Felipe Contreras wrote:

> IMO the key difference between hg and git is the storage model: hg 
> stores deltas, while git stores snapshots. That would mean that certain 
> operations are theoretically faster in git (e.g. checkout, diff) while 
> others faster in hg, although with git's packed format I guess there's 
> no operation faster in hg. This means that it doesn't matter how much 
> hg's python code improves, or if they even re-write parts in C, they 
> will never be able to match git's performance (unless they change the 
> storage model, which essentially means changing the whole design -- 
> won't happen).

That is wrong.  "git log -- <file>" will always be slightly faster in 
Mercurial, for all the reasons you mentioned.

In addition, Mercurial _has_ parts re-written in C for performance, which 
renders it not-exactly more portable if you ask me.  Last time I checked, 
there was no way to compile a Python module with MinGW (or for that 
matter, Python itself), but you needed MSVC...

Ciao,
Dscho
