From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Savannah Git repositories: do not panic
Date: Tue, 2 Jun 2009 23:55:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906022349120.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBbwu-000827-2P
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 23:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbZFBVzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 17:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZFBVzB
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:55:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:44447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbZFBVzB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 17:55:01 -0400
Received: (qmail invoked by alias); 02 Jun 2009 21:55:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 02 Jun 2009 23:55:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FKCJXjbvFsL+BGhToeOWsUVj/gzT8htNIn5iVTB
	8KP5awcMkzZGgJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120552>

Hi,

I got aware of several projects who hosted a Git repository on Savannah 
being affected by their filesystem corruption.  The good Savannah 
people put back some revisions from their backup, which are something 
like a month old.

Some people seem to think that it has adverse effects to fetch those 
obsolete branch revisions with a "git fetch".

This mail tries to serve to cool everybody down: nobody can take away from 
you what you already fetched: in the default set up, you will still have 
the "reflogs", i.e. "git log -g origin/master" will show you a "forced 
update" to the obsolete revision, but as the next commit, you will have 
the most up-to-date revision you fetched before.

And, oh, your local branches are unaffected.

You can even help the project maintainers if you have a newer revision 
than is the current revision on Savannah...

Ciao,
Dscho

P.S.: congratulations to everybody who switched to a distributed version 
control system before this corruption...
