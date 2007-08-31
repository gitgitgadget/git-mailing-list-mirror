From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git svn dcommit not checking if up-to-date?
Date: Fri, 31 Aug 2007 22:04:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708312200480.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDfQ-0006Cz-KR
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965506AbXHaVEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbXHaVEc
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:04:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:59232 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965166AbXHaVEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:04:31 -0400
Received: (qmail invoked by alias); 31 Aug 2007 21:04:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 31 Aug 2007 23:04:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7ScJJVVy7Zbkt1IUXk/D1uEKNNSBBii/Ea4O/2u
	1R/FYO2oW0k0rj
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57207>

Hi Eric,

harningt just asked about known issues of git-svn on IRC, and I remembered 
that I had an issue: Accidentally, I forgot to "git svn fetch" before "git 
svn dcommit"ing, and unfortunately, a colleague had just checked in a 
change, which got undone by my dcommit.

Is this a known issue, has it been fixed, am I a bad pilot?

Ciao,
Dscho

P.S.: harningt promised to get his hands dirty, but I just realised that 
the issue could be fixed since long ago...
