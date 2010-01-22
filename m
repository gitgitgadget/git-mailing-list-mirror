From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Fri, 22 Jan 2010 02:43:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001220242170.4985@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1001220158381.4985@pacific.mpi-cbg.de> <7v3a1zhrzz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 02:37:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY8T4-0007sP-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 02:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0AVBhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 20:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112Ab0AVBhm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 20:37:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:54969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752370Ab0AVBhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 20:37:41 -0500
Received: (qmail invoked by alias); 22 Jan 2010 01:37:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 22 Jan 2010 02:37:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/L760qk5PL91EV9TGaAKAPINKn70KANul9e6DN+R
	XhQzm0F0oxfArU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3a1zhrzz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137713>

Hi,

On Thu, 21 Jan 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 21 Jan 2010, Junio C Hamano wrote:
> >
> >> By the way, do you think anybody still uses "git merge-trees"?
> >
> > IMO this is the only viable way to a non-broken merge-recursive.  Removing 
> > it would be counterproductive.
> 
> Do you mean you don't think
> 
>     Subject: Re: git-merge segfault in 1.6.6 and master
>     Date: Thu, 21 Jan 2010 16:38:56 -0800
>     Message-ID: <7vaaw7j7mn.fsf@alter.siamese.dyndns.org>
> 
>     ...
>     In the meantime, I think applying this patch is the right thing to do.
> 
>     -- >8 --
>     Subject: merge-recursive: do not return NULL only to cause segfault
> 
> would help us?

Sorry, I cannot have a look at this now.

But in the long run, I think that it gets tiring to chase all kinds of 
weird interactions between unpack_trees(), the rename detection and the 
recursive merge.

I could see merge-trees as a viable alternative approach.

Ciao,
Dscho
