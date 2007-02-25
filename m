From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC 0/8] use "git diff" in the test suite
Date: Sun, 25 Feb 2007 23:34:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252329550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRwl-0002ex-7A
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbXBYWeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXBYWeU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:34:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:52476 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751284AbXBYWeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:34:20 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:34:19 -0000
X-Provags-ID: V01U2FsdGVkX1+MD+VoBkiM2/8XIQaX3aC+es9vj+WRGQMoO1ZGgF
	KlIA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40582>

Hi,

Now that --no-index is supported by git's diff, we can use much of the 
test suite to do the job, instead of relying on GNU diff.

This is a bit work-in-progress, since the handling of "-" as a filename is 
not fleshed out yet, and we really should have the "--quiet" option. But I 
got side-tracked by the edit-patch-series script, and did not want to hold 
these patches off any longer.

Ciao,
Dscho
