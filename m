From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Tue, 6 Jan 2009 20:40:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp>
 <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
 <20090106111712.GB30766@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:41:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHnL-0006km-2K
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbZAFTjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbZAFTjb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:39:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:55152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751029AbZAFTjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 14:39:31 -0500
Received: (qmail invoked by alias); 06 Jan 2009 19:39:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 06 Jan 2009 20:39:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4S/ILD0b4X4ismZsvpa9TrDXQNPRHISsphY/Jqi
	KE6MWzwS+SjR9Z
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090106111712.GB30766@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104713>

Hi,

On Tue, 6 Jan 2009, Pierre Habouzit wrote:

> On jeu, jan 01, 2009 at 04:38:09 +0000, Johannes Schindelin wrote:
> > 
> > Nothing fancy, really, just a straight-forward implementation of the
> > heavily under-documented and under-analyzed paience diff algorithm.
> 
> Btw, what is the status of this series ? I see it neither in pu nor in 
> next. And I would gladly see it included in git.

AFAICT people wanted to be reasonably sure that it is worth the effort.

Although I would like to see it in once it is fleshed out -- even if it 
does not meet our usefulness standard -- because people said Git is 
inferior for not providing a patience diff.  If we have --patience, we can 
say "but we have it, it's just not useful, check for yourself".

> On jeu, jan 01, 2009 at 07:45:21 +0000, Linus Torvalds wrote:
> > 
> > So could we have some actual real data on it?
> 
> For example, look at the following (shamelessly stolen from the real
> life example http://glandium.org/blog/?p=120).

Due to the lines being much longer than 80 characters, this example was 
not useful to me.

Ciao,
Dscho
