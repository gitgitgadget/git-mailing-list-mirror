From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 16:14:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 16:14:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM21W-0008HZ-DT
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 16:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbZAKPNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 10:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZAKPNU
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 10:13:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:38638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751221AbZAKPNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 10:13:19 -0500
Received: (qmail invoked by alias); 11 Jan 2009 15:13:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 11 Jan 2009 16:13:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PiYxAkJMPEfppsRwL9gWgM7WdcBnRGe5pGLuAUF
	D7kLs1JibzEhZ+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901111607.59054.borntraeger@de.ibm.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105189>

Hi,

On Sun, 11 Jan 2009, Christian Borntraeger wrote:

> Am Sonntag 11 Januar 2009 schrieb Christian Borntraeger:
> > doing a 
> > git bisect start
> > git bisect good a3a798c
> > git bisect bad v2.6.29-rc1
> > 
> > results in a repository without several files, e.g Makefile!
> > git describe also fails.
> 
> In fact, retesting with a clean repository shows, that there are only btrfs 
> files - nothing else.
> 
> Linus did you pull a broken btrfs repository?

I guess it is a subtree merge.  So no, nothing went wrong

Use "git bisect skip" to skip over those.

Hth,
Dscho
