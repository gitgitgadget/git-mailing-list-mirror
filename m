From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Inconsistencies with git log
Date: Wed, 7 Nov 2007 22:58:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711072255420.4362@racer.site>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com> 
 <Pine.LNX.4.64.0711072242230.4362@racer.site>
 <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:59:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iptrc-0008F4-Ik
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 23:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbXKGW66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 17:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbXKGW66
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 17:58:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:40841 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754321AbXKGW65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 17:58:57 -0500
Received: (qmail invoked by alias); 07 Nov 2007 22:58:55 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp045) with SMTP; 07 Nov 2007 23:58:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XhJZjGizXNFmVmXErrGp8oyyE1QkBzWrOSTWzP/
	TfO6pCQirxQ1v7
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910711071445p7cfb6cffx83adb1d84d6bf9d8@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63886>

Hi,

On Wed, 7 Nov 2007, Jon Smirl wrote:

> On 11/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Wed, 7 Nov 2007, Jon Smirl wrote:
> >
> > > In project root:
> > >  git log arch/powerpc/platforms/52xx
> > > works as expected
> > >
> > >  cd arch/powerpc/platforms/52xx
> > >  git log arch/powerpc/platforms/52xx
> > > fatal: ambiguous argument 'arch/powerpc/platforms/52xx': unknown
> > > revision or path not in the working tree.
> > > Use '--' to separate paths from revisions
> >
> > Try "git log ."
> 
> Shouldn't git log default to "git log ."?

Well, it is in line with the other commands being able to work on 
subdirectories, but doing the whole repository operation by default.

We also tend to take the approach of viewing the history as that of 
the whole project.

This approach also means that it is a much more expensive operation to log 
the history as seen by a subdirectory, which is another reason why it is 
not the default.

Hth,
Dscho
