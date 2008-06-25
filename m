From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
   to
Date: Wed, 25 Jun 2008 13:38:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806251334060.9925@racer>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer>
 <486220CE.3070103@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 14:42:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBUK6-00055E-Gz
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 14:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbYFYMke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 08:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757177AbYFYMkd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 08:40:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:34485 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756820AbYFYMkc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 08:40:32 -0400
Received: (qmail invoked by alias); 25 Jun 2008 12:40:30 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp042) with SMTP; 25 Jun 2008 14:40:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/atZMUNaLaoQ5NK8R3iXSJQvY8GSdnwBOvlGZAwg
	VeZO8/DeJ6bG+I
X-X-Sender: gene099@racer
In-Reply-To: <486220CE.3070103@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86273>

Hi,

On Wed, 25 Jun 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > Incidentally, a friend just told me that "checkout" is everything but 
> > intuitive, and he would have preferred "git branch switch <branch>", but 
> > then settled for my proposed "git branch --switch <branch>", which I did 
> > not have time to implement yet, unfortunately.
> 
> $ git config alias.switch checkout
> $ git switch topic
> 
> Hm? Notice that the command even reports back:
> 
> Switched to branch "topic"
> ^^^^^^^^

Nice.  And now my friend says "why does this braindamaged Git not have 
that command by _default_?  Hmm?  It is _just as braindamaged_ as CVS!"

And I would not have anything reasonable for my defense.

Because Git _should_ have an intuitive command to switch branches by 
default.  "git checkout" just does not fly, especially given that it can 
be used to revert single files (which "git revert" should know how to, but 
does not, see 
http://mid.gmane.org/7vlk8wshii.fsf@gitster.siamese.dyndns.org).

I _do_ see a cause of confusion here, _even_ if I know Git pretty well.

Ciao,
Dscho
