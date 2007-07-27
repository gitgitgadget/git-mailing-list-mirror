From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/8 REVISION2] work-tree cleanups
Date: Fri, 27 Jul 2007 19:55:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707271851370.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Fri Jul 27 20:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEUyN-0006ZQ-Rr
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 20:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbXG0Szc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 14:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757348AbXG0Szc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 14:55:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:58061 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751791AbXG0Szb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 14:55:31 -0400
Received: (qmail invoked by alias); 27 Jul 2007 18:55:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 27 Jul 2007 20:55:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6ZW9WtGC6NVfEwt6K7OYGYwkSGPWIjLoOkS5CaM
	NcyWkMuHnvdP3W
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53939>

Hi,

the patch series I sent was almost as bogus as the original work-tree 
patch series.  However, thanks to the comments, and a night's sleep, here 
comes a revised patch series which is not only readable (it was readable 
before, too), but which actually works as expected.

Not only does it pass the tests, but it also adds some tests of its own.

And yes, you can "GIT_DIR=/some/where git add <file>..." now.  Even if you 
are not at your working tree's root.

Ciao,
Dscho
