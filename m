From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sun, 26 Apr 2009 19:38:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904261936011.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:41:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8KE-0000hi-Pc
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 19:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbZDZRiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 13:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZDZRiA
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 13:38:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:51849 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754150AbZDZRh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 13:37:59 -0400
Received: (qmail invoked by alias); 26 Apr 2009 17:37:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 26 Apr 2009 19:37:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fLpgSGFgfOg++G34rvM954WYGhuIeiphBKeAI8A
	uMDZXntcgin756
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117632>

Hi,

On Sat, 25 Apr 2009, Linus Torvalds wrote:

> If you _don't_ do this patch, does 
> 
> 	[core]
> 		fsyncobjectfiles = true
> 
> hide the bug?

Yes.  On my EeePC with that stupid ufsd driver.

However, there is the other issue with Windows, so we still need half of 
my patch.

Junio, do you want me to throw out the core.unreliableHardlinks stuff, and 
only keep it as a Makefile option?

Ciao,
Dscho
