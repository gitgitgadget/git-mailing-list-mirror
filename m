From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 00:35:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080034420.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site> 
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com> 
 <Pine.LNX.4.64.0711080003080.4362@racer.site>
 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpvNu-0001Hr-O6
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbXKHAfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759262AbXKHAfz
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:35:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:39802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758632AbXKHAfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:35:54 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:35:52 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp029) with SMTP; 08 Nov 2007 01:35:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/soVkU5xjs3VDRkF8MPW5xRvvoc6fMbE0kRAk79S
	E2gyJ1OdCS3Dg+
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63911>

Hi,

On Wed, 7 Nov 2007, Jon Smirl wrote:

> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > It is consistent, when you realise that the path arguments are interpreted
> > relative to the project root.
> 
> Then why doesn't this work?
> 
> jonsmirl@terra:~/mpc5200b$ git log Documentation
> all the log for Documentation....
> jonsmirl@terra:~/mpc5200b$ cd Documentation
> jonsmirl@terra:~/mpc5200b/Documentation$ git log Documentation
> fatal: ambiguous argument 'Documentation': unknown revision or path
> not in the working tree.
> Use '--' to separate paths from revisions

Because you are in the subdirectory Documentation/, relative to the 
project root.  So when you say "Documentation", it tries to find the 
file/directory Documentation/Documentation.

Therefore, just say "git log ." and you will get what you want.

Ciao,
Dscho
