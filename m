From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 16:41:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, nico@cam.org
X-From: git-owner@vger.kernel.org Fri Aug 08 16:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRT6g-000462-Qf
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYHHOhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYHHOhR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:37:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:45932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751322AbYHHOhP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:37:15 -0400
Received: (qmail invoked by alias); 08 Aug 2008 14:37:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 08 Aug 2008 16:37:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vCcBljDfvTd0HhlcUKvo8R6YsXzG2VxbISqjrsy
	sZKFjslqJxoHjj
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91671>

Hi,

my auto gc kicked in, and shows this:

fatal: corrupt packed object for 2c1e128aa51e3a64bd61556c0cd488628b423ccf
error: failed to run repack

Fortunately, I have the uncorrupted object somewhere else.  So I copy the 
single object as a loose one, and all is fine.  Right?

Wrong.

Repack still picks up the corrupt object instead of the good one.  What's 
the best way out?

Ciao,
Dscho
