From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 20:32:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907172029230.4495@intel-tinevez-2-302>
References: <20090716230031.GM7503@vinegar-pot.mit.edu> <4A601C59.8040108@viscovery.net> <7vk52767el.fsf@alter.siamese.dyndns.org> <4A6038E8.1090402@viscovery.net> <20090717164845.GL7878@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Haberman <stephen@exigencecorp.com>
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 20:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRsER-0002gR-SC
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbZGQScY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 14:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbZGQScY
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 14:32:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:43072 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750734AbZGQScX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 14:32:23 -0400
Received: (qmail invoked by alias); 17 Jul 2009 18:32:22 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 17 Jul 2009 20:32:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GzYE5jS8G3S8ivcPsDRmFpczHV8JY7wCaKnDEgu
	LhjzO1pF6MHx7T
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090717164845.GL7878@vinegar-pot.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123481>

Hi,

On Fri, 17 Jul 2009, Greg Price wrote:

> On Fri, Jul 17, 2009 at 10:40:08AM +0200, Johannes Sixt wrote:
> > I have used rebase -i -p in the past to rewrite history that involves
> > merges of topic branches like this:
> > 
> >   ---------Y--M--M--F     <-- master
> >              /  /
> >   ----a--a--a  /
> >               /
> >   --b--b--b--b
> > 
> > where F is a fixup that I want to insert between Y and M, and I thought
> > rebase -i -p was intended for this use-case.
> 
> I don't believe rebase -i -p has ever worked with reordering commits.

It was not meant to.  Actually, it was never meant as "rebase -i -p", but 
always as "rebase -p" (which, for technical reasons, would be implemented 
in git-rebase--interactive.sh).

Having said that, I am working on a rebase-i-p series which _does_ allow 
reordering commits, putting commits on newly-created topic branches, 
redoing merges explicitely.

Unfortunately, I seem to have less and less time for Git (which is not 
helped by the frustrating experience of a first-slow then-failing GSoC 
project), and when I finally decided to set aside some time to polish the 
series and submit it, 1.6.4-rc0 came out.  And I do not want Junio to be 
distracted from that very important (think push-to-current-branch) 
release.

Ciao,
Dscho
