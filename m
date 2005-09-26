From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Mon, 26 Sep 2005 14:33:34 -0500
Message-ID: <1127763214.5735.25.camel@cashmere.sps.mot.com>
References: <ud5mznc1x.fsf@peter-b.co.uk>
	 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
	 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
	 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
	 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
	 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
	 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
	 <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org>
	 <Pine.LNX.4.58.0509241526180.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 26 21:37:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJyjM-0007Tn-MM
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 21:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVIZTdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVIZTdh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 15:33:37 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:25851 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751328AbVIZTdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 15:33:36 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id j8QJfeEi022498
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 12:41:40 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j8QJdajA026266
	for <git@vger.kernel.org>; Mon, 26 Sep 2005 14:39:36 -0500 (CDT)
To: Git List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509241526180.3308@g5.osdl.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9324>

On Sat, 2005-09-24 at 17:27, Linus Torvalds wrote:
> On Sat, 24 Sep 2005, Linus Torvalds wrote:
> > 
> > It mentions longhorn.
> 
> Anyway, regardless, we could certainly make HEAD be a regular file 
> containing the name of the head instead.

I cleverly removed a branch this morning (intentionally),
but what I failed to realize was that it was also the
current HEAD.  The next series of command were oddly
cryptic, only telling me the git-read-tree usage message.
Not a clue in the world why, of course.  After poking
around, reading some scripts and all, I discovered that
I had a dangling .git/HEAD symlink still point to my
removed branch.

Would it be worthwhile for me to re-discover this
Wonky Failure (Hi Linus! :-) and try to write it up
somewhere or dream up a better error message patch?

Thanks,
jdl
