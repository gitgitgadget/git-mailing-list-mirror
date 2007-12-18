From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 22:43:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712182239500.23902@racer.site>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
 <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com>
 <20071218222032.GH2875@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dana How <danahow@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4lAy-0002ba-Qz
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbXLRWoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbXLRWoI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:44:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:34009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751727AbXLRWoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:44:07 -0500
Received: (qmail invoked by alias); 18 Dec 2007 22:44:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 18 Dec 2007 23:44:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Wf9YuWKpW7/MMbTTnvkkXawh3LwnS3cldIkWDYg
	eDQrhBb6hFuTXu
X-X-Sender: gene099@racer.site
In-Reply-To: <20071218222032.GH2875@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68838>

Hi,

On Tue, 18 Dec 2007, Alex Riesen wrote:

> Jakub Narebski, Tue, Dec 18, 2007 22:24:26 +0100:
> > On Tue, 18 Dec 2007, Alex Riesen wrote:
> >
> > > I think that we have parsing of the blob locators at the wrong 
> > > level: so that git-show, git-log and git-diff can handle its 
> > > pathnames as they handle path filters (relative to cwd),
> > 
> > What cwd? <path> in <tree-ish>:<path> syntax is "relative" to 
> > <tree-ish>.
> 
> But the act of running "git-show <tree-ish>:<path>" does have a working 
> directory relative to the project root.

Not necessarily.  My primary use of "git show <tree-ish>:<path>" (yes, I 
already use the dash-less form ;-) is in _bare_ repositories.

And I still maintain that expecting <tree-ish>:<path> to take the current 
relative path into account would be just like if you expected

	C:\> cd WINDOWS
	C:\WINDOWS> dir D:system32

to show you the contents of D:\WINDOWS\system32.

Or another, less Windowsy example:

	$ cd /usr/bin
	$ scp home:bash ./

No, this does not copy home:/usr/bin/bash but home:$HOME/bash.

Hth,
Dscho
