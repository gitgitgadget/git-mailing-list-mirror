From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 15:33:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231532150.4353@racer.site>
References: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com> <alpine.LSU.1.00.0803231459100.4353@racer.site> <540004BB-49C4-456B-ABA3-62659D85C15E@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdRGu-0004dJ-Q2
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbYCWOdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756468AbYCWOdX
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:33:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:52706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755787AbYCWOdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:33:22 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:33:20 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp046) with SMTP; 23 Mar 2008 15:33:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YeG4pz3tYjNZFbG5B5XxqMNi2SzIMrCD6vHvqop
	6XGSC2W5VMQM1M
X-X-Sender: gene099@racer.site
In-Reply-To: <540004BB-49C4-456B-ABA3-62659D85C15E@ai.rug.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77909>

Hi,

On Sun, 23 Mar 2008, Pieter de Bie wrote:

> On Mar 23, 2008, at 2:59 PM, Johannes Schindelin wrote:
> > > The git rev-list --all gives nice list, but, as I understand, that 
> > > is only commit objects, and there are much more of SHA1 hidden 
> > > inside.
> >
> > Just add --objects.
> 
> I thought --all --objects only shows reachable objects?

Ah yes.  But usually the objects in packs are reachable...

So you're right, it does not really show _all_ objects.  But it shows many 
objects, and is pretty easy (which I think was the original poster's real 
question).

Ciao,
Dscho

P.S.: I got two mails from you, one without the Cc: list, and one with 
it...  Strange.
