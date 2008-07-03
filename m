From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Non-inetd git-daemon hangs in syslog(3)/fclose(3) if --syslog
 --verbose accessing non-repositories
Date: Thu, 3 Jul 2008 13:45:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031343440.9925@racer>
References: <200807031400.36315.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:53:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEOJ6-0005Az-HK
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbYGCMrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbYGCMrX
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:47:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:33768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755810AbYGCMrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:47:22 -0400
Received: (qmail invoked by alias); 03 Jul 2008 12:47:20 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp047) with SMTP; 03 Jul 2008 14:47:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/kZdAF9h/jVCniEx5xPD1sODdLRCAOfu4Hkva+m
	WE+YZLQlEw2KAg
X-X-Sender: gene099@racer
In-Reply-To: <200807031400.36315.brian.foster@innova-card.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87281>

Hi,

On Thu, 3 Jul 2008, Brian Foster wrote:

>  I've seen several reports of what seems to be the following
>  problem, but no fixes.
>
> [describes that git-daemon -v syslog()s in a signal handler, which is 
>  unsupported]

I reported this bug earlier, and my workaround was to comment out the 
syslog() in the signal handler, but I have no real fix for that, either.

Unfortunately, the wise people on this list did not have an idea either, 
at least they did not share it with me.

Ciao,
Dscho
