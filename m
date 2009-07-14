From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Re: Make 'git show' more useful
Date: Tue, 14 Jul 2009 12:44:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907141243410.3155@pacific.mpi-cbg.de>
References: <7vtz1gi67v.fsf@alter.siamese.dyndns.org> <1247528614-24590-1-git-send-email-bonzini@gnu.org> <alpine.LFD.2.01.0907131652120.13838@localhost.localdomain> <alpine.DEB.1.00.0907140324140.3155@pacific.mpi-cbg.de> <4A5C24BE.4090804@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 14 12:42:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQfSi-00026k-8e
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 12:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbZGNKmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 06:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbZGNKmH
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 06:42:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:42084 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753564AbZGNKmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 06:42:07 -0400
Received: (qmail invoked by alias); 14 Jul 2009 10:42:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 14 Jul 2009 12:42:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZPKZcC8qZbAdHsLKCfZdzr9pNeNnI9GoOyTIYCQ
	ZSOWh8rxi3RdFT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A5C24BE.4090804@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123236>

Hi,

On Tue, 14 Jul 2009, Paolo Bonzini wrote:

> > > The actual "--no-walk" flag was then added over a year later by 
> > > Dsco, in commit 8e64006eee ("Teach revision machinery about 
> > > --no-walk").
> > >
> > > Doing a "git log -p -S--no-walk", I have to admit that I don't find 
> > > a single actual _use_ of --no-walk.
> >
> > Actually, I remember very precisely why I introduced it.  The 
> > difference between "git log --no-walk a b c" and "git show a b c" is 
> > that "git log" sorts the commits by commit time, which is pretty 
> > important in my case.
> 
> Very nice.  Can you add a test for that?

Unfortunately, no; I am very short on time.

Ciao,
Dscho
