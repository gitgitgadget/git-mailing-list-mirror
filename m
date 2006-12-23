From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 16:58:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612231655420.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net>
 <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-545987104-1166889487=:19693"
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 16:58:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy9GI-0003gr-Ej
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 16:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbWLWP6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 10:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbWLWP6K
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 10:58:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54395 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753559AbWLWP6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 10:58:09 -0500
Received: (qmail invoked by alias); 23 Dec 2006 15:58:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 23 Dec 2006 16:58:07 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35323>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-545987104-1166889487=:19693
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 23 Dec 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> BTW, is there some explanation why branch.*.merge specifies a _remote_
> >> head? The following would make much more sense to me:
> >>
> >> [branch "master"]
> >> remote = origin
> >> merge = refs/remotes/origin/master
> >
> > Only *if* you store it in that tracking branch.  The name the
> > other party gives _do_ matter to you anyway, because you have to
> > _know_ it to fetch.  What it does NOT matter is if you use a
> > tracking branch, or if you do, which local tracking branch you
> > use to track it.
> 
> Having said that, I think we _could_ do this.
> 
> If you (or other people) use branch.*.merge, with its value set
> to remote name _and_ local name, and actually verify that either
> form works without confusion, please report back and I'll apply.

I do not claim to understand your patch (I have no idea if || or && is 
stronger in shell), but here is another proposition: if the config 
variabl√e starts with "refsremotes/", assume it is local.

Ciao,
Dscho

---1148973799-545987104-1166889487=:19693--
