From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Sun, 10 Feb 2008 01:26:44 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100125510.11591@racer.site>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> <vpq63x5swsj.fsf@bauges.imag.fr> <m3tzkp6eqz.fsf@localhost.localdomain> <20080210011203.GL25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO0yR-0000kX-T1
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbYBJB0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbYBJB0n
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:26:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:53444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbYBJB0m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:26:42 -0500
Received: (qmail invoked by alias); 10 Feb 2008 01:26:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 10 Feb 2008 02:26:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lNU9173SlyYfzsQVbDWfecpG76CTgDiOjPXhMc7
	pppGl916CEnWAB
X-X-Sender: gene099@racer.site
In-Reply-To: <20080210011203.GL25954@genesis.frugalware.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73284>

Hi,

On Sun, 10 Feb 2008, Miklos Vajna wrote:


>  builtin-cp.c                 |   24 ++++++++++
>  builtin-mv.c                 |  104 ++++++++++++++++++++++++++++++++++++++++--

If you touch builtin-mv.c already, why not just move cmd_cp() in there?  
It's not like it would be the first cmd_*() function living in the same 
file as other cmd_*() functions.

Ciao,
Dscho
