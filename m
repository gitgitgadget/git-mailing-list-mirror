From: linux@horizon.com
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: 21 Dec 2006 03:41:42 -0500
Message-ID: <20061221084142.14347.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Thu Dec 21 09:48:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJbI-0007Tf-B1
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWLUIsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422868AbWLUIsZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:48:25 -0500
Received: from science.horizon.com ([192.35.100.1]:18884 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1422864AbWLUIsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 03:48:24 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 03:48:24 EST
Received: (qmail 14348 invoked by uid 1000); 21 Dec 2006 03:41:42 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35031>

Remember, OS X is FreeBSD somehow layered on top of Mach 3.
In particular, it calls though to Mach for virtual memory.

And Mach is at its heart an academic design aiming for flexibility in
its VM system rather tha performance.  In particular, its provisions
for user-space pagers.

I can easily believe that its mmap is 10x slower that Linux.  60x is.. a
bit extreme.  A Darwin kernel hacker should probably get a nudge about it.
