From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git merge bug: creating new files in one branch in a directory
 that is renamed in another
Date: Sun, 21 Jan 2007 23:05:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701212301340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B3224B.3020800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 23:05:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8koK-00079p-OE
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXAUWFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 17:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXAUWFI
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:05:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:47845 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751704AbXAUWFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:05:07 -0500
Received: (qmail invoked by alias); 21 Jan 2007 22:05:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 21 Jan 2007 23:05:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Liraz Siri <liraz.siri@gmail.com>
In-Reply-To: <45B3224B.3020800@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37351>

Hi,

> [merge branch where directory was renamed, but files were added in the 
>  unrenamed directory]

I think this problem is fundamentally untractable. If you move only some 
files to another directory, it is more obvious that you don't know where 
to put the newly created file (indeed, you might need it in _both_).

Another non-obvious reason to fail is that you actually _want_ the new 
file to be the only one to reside in that directory.

So I think you cannot solve that problem. IOW you have to resolve that 
conflict manually _anyway_.

Ciao,
Dscho
