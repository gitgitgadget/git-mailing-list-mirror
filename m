From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [VOTE]  git versus mercurial
Date: Tue, 28 Oct 2008 15:28:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 15:22:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KupST-0003zf-BR
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 15:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbYJ1OUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 10:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbYJ1OUy
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 10:20:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:39073 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751048AbYJ1OUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 10:20:54 -0400
Received: (qmail invoked by alias); 28 Oct 2008 14:20:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 28 Oct 2008 15:20:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Vs+sUc40VB68XDFbf8EcK7Qlqup6vtUeXg5ipaG
	pOlSV0pIOnlLV4
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <ge70nl$l6t$1@ger.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99291>

Hi,

On Tue, 28 Oct 2008, walt wrote:

> walt wrote:
> > No, no, I'm not the one calling for a vote.  You old-timers here will 
> > know the name Matt Dillon, who is leading the dragonflybsd project 
> > (www.dragonflybsd.org).
> >
> > Matt is the one who is calling for the vote in his thread "Vote for 
> > your source control system" in the dragonfly.kernel group, accessible 
> > via nntp://nntp.dragonflybsd.org...
> 
> The official vote was 19 to 19, plus one for perforce and one for svn.  
> Matt has proposed a primary git repository and a mirror in hg, and 
> that's being debated now.

While many may say that that is a half-baked solution, I actually like it.  
Mercurial and Git are pretty similar in their concept (if not in how the 
data is actually stored).

Note that with git fast-export and hg fast-import, it should be relatively 
simple to convert from one data format to the other, even incrementally.

And for the other direction, you could use hg fast-export from the 
fast-export.git repository (I am working on a better one at the moment, 
too, so that incremental fast-export would be possible, too).

Ciao,
Dscho
