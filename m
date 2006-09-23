From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git user survey and `git pull`
Date: Sat, 23 Sep 2006 16:12:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609231608070.25853@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060921162401.GD3934@spearce.org>  <ef1j6j$8sn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 16:12:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR8Et-0001Sp-On
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 16:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWIWOMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWIWOMF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 10:12:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:8370 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751184AbWIWOMD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 10:12:03 -0400
Received: (qmail invoked by alias); 23 Sep 2006 14:12:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 23 Sep 2006 16:12:01 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <matthias@urlichs.de>
In-Reply-To: <ef1j6j$8sn$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27591>

Hi,

On Fri, 22 Sep 2006, Matthias Urlichs wrote:

> For what it's worth, I'm in favor of renaming the things.
> 
> On Thu, 21 Sep 2006 12:24:01 -0400, Shawn Pearce wrote:
> 
> >   Current            Shoulda Been
> >   ---------------    ----------------
> >   git-push           git-push
> >   git-fetch          git-pull
> >   git-pull . foo     git-merge foo
> >   git-pull           git-pull --merge
> >   git-merge          git-merge-driver
> > 
> The new programs can (for the most part) recognize when they're called with
> "old" semantics, and spit out a warning.

Now, that only introduces more confusion!

If there is another tool rename, better choose names which are virgins. 
Besides, I am still not convinced that the rename is necessary. Granted, 
some new users might get confused with the current naming, but what about 
those who are not? They would be confused by the new naming.

And if you want unambiguous names, and even succeed in choosing sensible 
ones, you can make them hardwired aliases, and old habits don't have to 
die.

Ciao,
Dscho
