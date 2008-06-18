From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 18 Jun 2008 16:25:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806181624120.6439@racer>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home>
 <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org> <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org>
 <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com> <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com>
 <200806142359.m5ENxsBI028758 @mi0.bluebottle.com> <7vabhne15k.fsf@gitster.siamese.dyndns.org> <7vy755c0b2.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806171000400.6439@racer> <7vej6v683q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 17:28:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8zZp-0005c5-Gf
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 17:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYFRP05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYFRP05
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 11:26:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:40558 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752254AbYFRP05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 11:26:57 -0400
Received: (qmail invoked by alias); 18 Jun 2008 15:26:54 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp059) with SMTP; 18 Jun 2008 17:26:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+d57FHtdida+UNIY4l3H7a33U+7phBcaeOHEE3+B
	CyJt+HFYIkErdy
X-X-Sender: gene099@racer
In-Reply-To: <7vej6v683q.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85385>

Hi,

On Tue, 17 Jun 2008, Junio C Hamano wrote:

> Of course,
> 
> 	$ git stash apply stashed-longer
> 
> would work but that is by accident, as at that point what you are feeding
> "git stash" command is not really a name of a ref that is a stash.

It would not be by accident.  It would work because we designed git-stash 
to use refs to store working-directory vs index changes, and this command 
line you wrote was _exactly_ what I intended.

Ciao,
Dscho
