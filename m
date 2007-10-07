From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Mon, 8 Oct 2007 00:28:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080028301.4174@racer.site>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> 
 <20071007213817.GJ31659@planck.djpig.de>  <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
  <Pine.LNX.4.64.0710080018270.4174@racer.site>
 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:29:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefYo-0004pN-Kz
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083AbXJGX3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbXJGX3M
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:29:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:46402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756080AbXJGX3L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:29:11 -0400
Received: (qmail invoked by alias); 07 Oct 2007 23:29:08 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp021) with SMTP; 08 Oct 2007 01:29:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+FVg43c0mFanwdS/WueJbK63fHjAWcKHokeq1tEH
	IP4RdfHDPHWJGI
X-X-Sender: gene099@racer.site
In-Reply-To: <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60257>

Hi,

On Sun, 7 Oct 2007, Elijah Newren wrote:

> On 10/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sun, 7 Oct 2007, Elijah Newren wrote:
> >
> > > So...how do I fix the reflog, and then repack to have a pack under 
> > > 11MB in size?
> >
> > Just clone it.  The clone will be much smaller.
> 
> $ git clone test test2
> <snip>
> $ du -hs test
> 11M     test
> $ du -hs test2
> 11M     test2
> 
> Any other ideas?

Yep.  Maybe it is necessary to run "git gc" in test2.

Ciao,
Dscho
