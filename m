From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Jun 2008 22:57:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806292256200.9925@racer>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0806291127140.21402@hp.linux-foundation.org> <7vk5g89f34.fsf@gitster.siamese.dynd ns.org> <A87D312D-8B65-4D57-84AC-8FC07A27B937@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD4wj-0003Uc-QJ
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYF2V7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYF2V7h
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 17:59:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:50250 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752310AbYF2V7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 17:59:37 -0400
Received: (qmail invoked by alias); 29 Jun 2008 21:59:35 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp065) with SMTP; 29 Jun 2008 23:59:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5un9PkmH5jgxdlLV/QxjqbKipBL1/nzFNFTnjf5
	AtuZdiQH/Ftl98
X-X-Sender: gene099@racer
In-Reply-To: <A87D312D-8B65-4D57-84AC-8FC07A27B937@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86839>

Hi,

On Sun, 29 Jun 2008, Pieter de Bie wrote:

> On 29 jun 2008, at 22:11, Junio C Hamano wrote:
> 
> >  use of them from your scripts after adding output from "git 
> >  --exec-path" to the $PATH will still be supported in 1.6.0, but users 
> >  are again strongly encouraged to adjust their scripts to use "git 
> >  xyzzy" form, as we will stop installing "git-xyzzy" hardlinks for 
> >  built-in commands in later releases.
> 
> I think msysgit doesn't (didn't?) install the hardlinks to conserve 
> space, as Windows doesn't support hard links.

Please do not spread FUD.  Where available, we install hardlinks.

And even if we did not, given that we do not yet actively support MinGW, I 
think your suggestion is a bit early, to say the least.

Ciao,
Dscho
