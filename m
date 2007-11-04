From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Warning: cvsexportcommit considered dangerous
Date: Sun, 4 Nov 2007 16:41:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041638270.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 17:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoiYF-0004b2-1E
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 17:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbXKDQmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 11:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXKDQmE
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 11:42:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:43354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbXKDQmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 11:42:03 -0500
Received: (qmail invoked by alias); 04 Nov 2007 16:42:00 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 04 Nov 2007 17:42:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jXA57F/RjBEQ7EfeaaS++Y+A7/EOtXzpRnqC4C7
	mZGfMbTb8VO08t
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63418>

Hi,

ever since the up-to-date check was changed to use just one call to "cvs 
status", a bug was present.  Now cvsexportcommit expects "cvs status" to 
return the results in the same order as the file names were passed.

This is not true, as I had to realise with one of my projects on 
sourceforge.

Since time is so scarce on my side, I will not have time to fix this bug, 
but will instead return to my old "commit by hand" procedure.

Ciao,
Dscho
