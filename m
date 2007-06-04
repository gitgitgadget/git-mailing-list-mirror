From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 15:58:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041554430.4046@racer.site>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bryan Childs <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 17:00:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvE3E-0003FY-Sp
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 17:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXFDPAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 11:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbXFDPAo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 11:00:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:58020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750916AbXFDPAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 11:00:44 -0400
Received: (qmail invoked by alias); 04 Jun 2007 15:00:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 04 Jun 2007 17:00:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/Ue4ibVy/Cf8/r3ycXE/YWegInR4q8V77fi9Tyx
	GHOYoxz0aPvT66
X-X-Sender: gene099@racer.site
In-Reply-To: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49104>

Hi,

On Mon, 4 Jun 2007, Bryan Childs wrote:

> 1) Due to the nature of our project, with multiple architectures
> supported, we strive to provide a binary build of our software with
> every commit to the subversion repository.

Git has no problems with binaries. Actually, one could argue that it has 
less problems with binary files than with text files, since it only 
recently acquired the capability (disabled by default) to transcribe 
certain files into the CR/LF line ending some Windows programs still 
insist on.

As for checking in binaries, you even could set up a post-commit hook, 
which builds the binary, and checks it into a separate branch...

Ciao,
Dscho
