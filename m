From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] http-push fixes
Date: Thu, 14 Feb 2008 23:25:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142319340.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, mh@glandium.org
X-From: git-owner@vger.kernel.org Fri Feb 15 00:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPnSX-0000gf-9j
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 00:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758011AbYBNXZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 18:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757555AbYBNXZH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 18:25:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:34333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757288AbYBNXZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 18:25:05 -0500
Received: (qmail invoked by alias); 14 Feb 2008 23:25:03 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 15 Feb 2008 00:25:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QR688Oq8QH+mJbQgq75ZrUTQzgnPRFaZAGKiGTl
	xczonNN1Ysa802
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73923>

Hi,

I have to admit that impatience got the better part of me.  So I did not 
wait for those promised http cleanups, but dived into the current code and 
debugged a (failing) http-push for several hours.

Let me tell this: http-push's source code is not nice.  The code is hard 
to follow, and it is repetitive.  I would really welcome a major cleanup, 
but unfortunately, I do not have half the time I would need for this.

So here go three patches, the first two of them fixing real issues (a 
segfault, and an "out of memory", which is not really one), and the last 
showing just what kind of cruft needs removing in http-push.c.

I'm particularly bad with cover-letters (waiting for format-patch 
--cover-letter to be applied, hint, hint), so this is my version of one:

 http-push.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Ciao,
Dscho
