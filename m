From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW build environment for Git
Date: Wed, 1 Aug 2007 11:44:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011143180.14781@racer.site>
References: <a1bbc6950707291614w392bf3a9t5d0d9e50bfcb0f36@mail.gmail.com> 
 <46B016FC.4050005@trolltech.com> <a1bbc6950708010208v15071005w3bcc471bef172fcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 12:45:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGBhS-0008Ju-3V
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 12:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbXHAKop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 06:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbXHAKop
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 06:44:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:58035 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756016AbXHAKoo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 06:44:44 -0400
Received: (qmail invoked by alias); 01 Aug 2007 10:44:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 01 Aug 2007 12:44:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wg2tbQQbwC1pElovC76uoi94Im6UD69unkL9JVS
	i3ocYfg+kU5oTV
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950708010208v15071005w3bcc471bef172fcc@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54426>

Hi,

On Wed, 1 Aug 2007, Dmitry Kakurin wrote:

> On 7/31/07, Marius Storm-Olsen <marius@trolltech.com> wrote:
> > Dmitry Kakurin said the following on 30.07.2007 01:14:
> > > I want to be able to build MinGW port of Git on Windows. I've tried
> > > to follow steps in README.MinGW to setup this environment myself
> > > (install MinGW, MSys, ZLib etc.) but after wasting a lot of time
> > > with no result I give up. So, could somebody please just pkzip
> > > their environment (everything required) and share the zip file with
> > > me (privately or publicly)? I also think that an even better idea
> > > is to create a new Git repository with MinGW build environment.
> > > This will make contributing to MinGW port of Git MUCH easier.
> >
> > Aaron has done this, and you can find the link on his blog, here:
> >     http://www.ekips.org/cgi-bin/aaron.cgi/2007/02/27
> 
> I've downloaded and installed it. But I could not make it work :-(.
> First I had this problem:
> $ make
> GIT_VERSION = 1.5.3.GIT
>     * new build flags or prefix
>     CC convert-objects.o
> gcc.exe: installation problem, cannot exec `cc1': No such file or directory
> make: *** [convert-objects.o] Error 1
> 
> Then I've copied cc1.exe and some others from
> C:\mingw4git\libexec\gcc\mingw32 into /bin.
> 
> $ make
>     CC convert-objects.o
> In file included from cache.h:4,
>                  from convert-objects.c:1:
> git-compat-util.h:51:22: sys/wait.h: No such file or directory
> 
> Searching entire (downloaded) tree for wait.h gives nothing.
> 
> 'make configure' does not work:
> $ make configure
>     GEN configure
> configure.ac+:4: error: Autoconf version 2.59 or higher is required
> configure.ac+:4: the top level
> autom4te: /bin/m4 failed with exit status: 1
> make: *** [configure] Error 1
> 
> What do I do now?

This looks like you downloaded git.git.  Official releases do not have 
MinGW support yet!  You have to get the MinGW port from repo.or.cz:

	http://repo.or.cz/w/git/mingw.git

Hth,
Dscho
