From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] prepare deprecation of git-revert
Date: Sat, 1 Nov 2008 00:13:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010012320.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1225468527-29694-1-git-send-email-madcoder@debian.org> <20081031165003.GA5355@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:07:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw35Y-0003BF-JQ
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbYJaXGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYJaXGM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:06:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:42407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751403AbYJaXGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:06:11 -0400
Received: (qmail invoked by alias); 31 Oct 2008 23:06:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 01 Nov 2008 00:06:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bZ7I9vwZby2h8nWfc5GmIZkPZST7gnLNx7cVfmz
	aqpjNUzYMNf+4R
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081031165003.GA5355@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99669>

Hi,

On Fri, 31 Oct 2008, Alex Riesen wrote:

> Pierre Habouzit, Fri, Oct 31, 2008 16:55:27 +0100:
> > @@ -439,16 +436,17 @@ static int revert_or_cherry_pick(int argc, const char **argv)
> >  
> >  int cmd_revert(int argc, const char **argv, const char *prefix)
> >  {
> > +#if 0
> > +	warning("git revert is deprecated, please use git cherry-pick --revert/-R instead");
> > +#endif
> 
> "git revert" is much shorter to type than "git cherry-pick -R". How 
> about renaming "cherry-pick" into something short, like "pick"?

I thought we agreed that we should _never_ remove support for "git 
revert"?  I mean, we can deprecate it, but I find it pretty strong, and 
unnecessary, to break existing users' expectations.

Ciao,
Dscho
