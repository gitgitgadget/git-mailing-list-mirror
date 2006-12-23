From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git reflog show
Date: Sat, 23 Dec 2006 15:53:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612231552140.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061223101956.GD9396@spearce.org> <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 15:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy8GC-0004oj-L5
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbWLWOxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbWLWOxz
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:53:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:48590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753562AbWLWOxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:53:54 -0500
Received: (qmail invoked by alias); 23 Dec 2006 14:53:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp011) with SMTP; 23 Dec 2006 15:53:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4prmsxjl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35321>

Hi,

On Sat, 23 Dec 2006, Junio C Hamano wrote:

> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I'm toying with what a 'git reflog show' might look like.  I attached
> > the prototype code below.  Here's the output from the recent part of
> > my mmap pack window topic:
> >
> >   $ ./git-reflog show refs/heads/sp/mapwin
> >   ...clipped for space...
> >   
> 
> The output should look almost the same as "git log" for the part
> that represents a series of normal branch activity where commits
> are built up one-by-one.  I think it would be useful if you can
> somehow make parts that are _not_ linear stand out and perhaps
> allow omitting a stretch of ordinary single strand of pearls.

I wonder if it would make sense to teach the revision walking machinery 
about reflogs. A commit could be marked as coming from a reflog entry, and 
in that case the parents could be determined by the reflog rather than the 
commit itself.

Is this a stupid idea?

Ciao,
Dscho
