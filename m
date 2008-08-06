From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 6 Aug 2008 14:43:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808061436310.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <200807231544.23472.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness> <200807231852.10206.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231356540.8986@racer> <20080806111545.GD32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 06 14:40:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQiJX-000397-Qq
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 14:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbYHFMjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 08:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYHFMjX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 08:39:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:44599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752605AbYHFMjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 08:39:22 -0400
Received: (qmail invoked by alias); 06 Aug 2008 12:39:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 06 Aug 2008 14:39:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jT1FZtzNjs3abRRmWcMBmx08RV9yqBMtM460mgm
	SwMSSvf9MfhyPw
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080806111545.GD32184@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91509>

Hi,

On Wed, 6 Aug 2008, Petr Baudis wrote:

> On Wed, Jul 23, 2008 at 01:57:54PM +0100, Johannes Schindelin wrote:
> > Note that you will have to do your digging using msysGit (i.e. the 
> > developer's pack, not the installer for plain Git), since git-svn will 
> > be removed from the next official "Windows Git" release, due to lack 
> > of fixers.
> 
>   is there any other problem with git-svn on Windows than the CRLF
> issue? I couldn't find anything significant in the issue tracker.

http://code.google.com/p/msysgit/issues/detail?id=120&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary

It is also frustrating that 

http://code.google.com/p/msysgit/issues/detail?id=83&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary
http://code.google.com/p/msysgit/issues/detail?id=103&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary
http://code.google.com/p/msysgit/issues/detail?id=129&colspec=ID%20Type%20Status%20Priority%20Component%20Owner%20Summary

are probably the same issue.  I cannot only blame the users for not really 
looking if their issue has been reported yet; there are 32 open issues in 
msysGit right now, number increasing, so it gets quite confusing.

I once switched off the issue tracker, because I was the only one who took 
at least a little bit of care of it.  Due to list consensus, it was turned 
back on -- against my will.

Guess who takes care of it right now?

Exactly.  So I will soon be switching it off again, I think, because there 
are few more useless things than an unmonitored issue tracker.

>   If not, why do you want to drop git-svn from Windows Git? It seems 
> that the CRLF issue has trivial workaround to set autocrlf=false; this 
> will make git-svn-tracked repositories useful only on Windows, but I'd 
> bet this is fine for large majority of Windows git-svn users?

If it was so trivial, why does nobody use it?

Oh, and git-svn is slow, too.

And _noone_ of those competent Windows git-svn users seemed fit or willing 
to do anything about git-svn, not even the simplest of issues.

If you want to do something about it, go ahead.  But I have no inclination 
of hearing from any Windows user about git-svn again, ever.

Ciao,
Dscho
