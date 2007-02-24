From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Sat, 24 Feb 2007 02:25:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240222100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <45DE3D5C.5060105@xs4all.nl>
 <Pine.LNX.4.63.0702230204190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702232053.49489.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org,
	junkio@cox.net
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmNp-00018T-3P
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933334AbXBXCLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933339AbXBXCLa
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:11:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:43279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933334AbXBXCL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:11:29 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:25:52 -0000
X-Provags-ID: V01U2FsdGVkX19/rk8Bf2J/ktqowAv2sJdbTcdnb0oVCdmJbNNkYY
	lEQw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702232053.49489.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40493>

Hi,

On Fri, 23 Feb 2007, Robin Rosenberg wrote:

> fredag 23 februari 2007 02:07 skrev Johannes Schindelin:
> > 
> > On Fri, 23 Feb 2007, Han-Wen Nienhuys wrote:
> > 
> > > nitpick:
> > > 
> > >   \n
> > > 
> > > for newline would be nice. Similar for backslash, formfeed, alarm, 
> > > etc.
> > 
> > Yes, I thought about that. But it would change behaviour (even if I 
> > don't think it would do serious damage; the only user of 
> > interpolate.[ch] I saw is git-daemon, and that does not need \n, I 
> > guess).
>
> Other tools that come to mind, rpm and clearcase use \n vfor newline in 
> the format argument, which is good because I can guess that even without 
> looking at the documentation. %n I'd guess would be for a number of some 
> kind, e..g. the ordinal number of the commit listed (in subset and order 
> of the listed commits)

Okay. Patch?

> > Besides, "%n" is
> > 
> > - more consistent,
>
> with...?

... itself? Why should not _one_ escape character be enough?

> > - you can put BS, FF, AL, etc. into the format string before passing
> >   it as an option to git; git does not have to help you there.
>
> They are hard to type in shells and even harder in gui's.

You would not do that all that often, but rather write a script. Even the 
config format allows for inclusion of special characters, so aliases 
should be fine.

Ciao,
Dscho
