From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Thu, 2 Aug 2007 22:23:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708022206130.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 23:24:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGi9U-0004Iq-Tl
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbXHBVYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbXHBVYI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:24:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:35572 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751875AbXHBVYG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:24:06 -0400
Received: (qmail invoked by alias); 02 Aug 2007 21:24:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 02 Aug 2007 23:24:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+imZQtLvSi6fwUbooauCUJcBtYCu3LgTyIpsBvOa
	1LhxoLf3cSb/kK
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54615>

Hi,

I finally broke down, waiting for the sourceforge project to get granted.  
In the meantime, I registered a project at

	http://code.google.com/p/msysgit/

(WARNING: temporary only!)

Would you believe that Google code has a restriction to 20MB per file, and 
100MB in total, and you cannot remove files?  The same Google that gives 
you 1TB mail space and counting?  Yes, it is ludicrous.

Anyway, you can get a complete Development environment in 3 files (because 
one would be too large), and... oh well, just read what is written on the 
website if you're really interested.

The plan is to move to Source forget ;-) when they finally approve the 
project, or stay with Google, should they decide to lift the quota a bit.

Dmitry already reported a buglet preventing gcc to run without changes on 
Vista, his theory is that the infamous access() function is at fault.  So 
if you are unlucky enough to be stuck with Vista, just copy 
msysGit/mingw/libexec/gcc/mingw32/3.4.2/cc1.exe to msysGit/mingw/bin/ and 
you're set.

Ciao,
Dscho
