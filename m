From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Thu, 8 Nov 2007 00:04:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080003080.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site> 
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com> 
 <Pine.LNX.4.64.0711072255420.4362@racer.site> 
 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com> 
 <Pine.LNX.4.64.0711072309380.4362@racer.site>
 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iput6-0001iq-6d
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbXKHAEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754039AbXKHAEc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:04:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:35075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752143AbXKHAEc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:04:32 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:04:30 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp043) with SMTP; 08 Nov 2007 01:04:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OFYxWRc6OQe3tnq2zFU83JOeJUvFBfnAxx7XCQF
	YFFoR37v4OUweA
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63900>

Hi,

On Wed, 7 Nov 2007, Jon Smirl wrote:

> So if git log is always whole tree, why doesn't this work?

git log is not always the whole tree.  git log without arguments is.

>  cd arch/powerpc/platforms/52xx
>  git log arch/powerpc/platforms/52xx
> fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions
> 
> It's not consistent. git log with no parameters is relative to the 
> project root, git log with a parameter is relative to the current 
> directory.

It is consistent, when you realise that the path arguments are interpreted 
relative to the project root.

Hth,
Dscho
