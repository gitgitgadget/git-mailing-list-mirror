From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/40] MinGW port
Date: Wed, 27 Feb 2008 23:58:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802272351580.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 01:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWBw-00025c-8Q
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940AbYB0X7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 18:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758688AbYB0X7E
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:59:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:49338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758152AbYB0X7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 18:59:03 -0500
Received: (qmail invoked by alias); 27 Feb 2008 23:59:01 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp017) with SMTP; 28 Feb 2008 00:59:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9s84ZqBG9/zo4n1nTp1JJiwGHw6oWLGXiqlEBZ2
	X7P3NaMtxt7xTY
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75327>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> - perl scripts don't work. We have a hack in the port tree, but I haven't
>   yet taken the time to clean it up enough.

AFAICT the perl scripts work in msysGit.

> - The test suite does not pass because of missing features like symbolic
>   links. Again we have adjusted the tests in the port tree so that the
>   test suite can be completed unattended.

We have patches in msysGit for that.  Maybe they should come _before_ the 
MinGW series?

> I've arranged the patches in a few subsets. They are different from what 
> Dscho had proposed some weeks ago when I announced the series for the 
> first time because I felt this topical partitioning makes more sense.

FWIW I like your partitioning very much!

> 27/40 Windows: Implement a custom spawnve().

AFAIR this is needed to call git from git-gui, because of that fscked-up 
semantics of Windows' CreateProcess().

I'll try to review the patches in the next days, but I have no doubt that 
there is not much to complain about.

Thanks, Hannes, for all your valuable and persistent work on mingw.git!

Ciao,
Dscho
