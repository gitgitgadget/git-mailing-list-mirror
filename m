From: Mike Galbraith <efault@gmx.de>
Subject: Re: bisect: "won't bisect on seeked tree"
Date: Thu, 21 Feb 2008 07:00:24 +0100
Message-ID: <1203573624.20492.12.camel@homer.simson.net>
References: <1203571214.24456.6.camel@homer.simson.net>
	 <20080221053307.GA2887@spearce.org>
	 <1203572388.20492.0.camel@homer.simson.net>
	 <20080221054332.GB2887@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 07:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS4UP-00034s-Oz
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 07:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbYBUGA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 01:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYBUGA0
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 01:00:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:53018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750776AbYBUGAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 01:00:25 -0500
Received: (qmail invoked by alias); 21 Feb 2008 06:00:23 -0000
Received: from p54B5BA9E.dip0.t-ipconnect.de (EHLO [192.168.178.23]) [84.181.186.158]
  by mail.gmx.net (mp058) with SMTP; 21 Feb 2008 07:00:23 +0100
X-Authenticated: #14349625
X-Provags-ID: V01U2FsdGVkX18Zs5VHAk8ZO8QcrxFXQrFGHE+iUyAWzbLoIWIPA2
	p5uXwz+Cz11WaC
In-Reply-To: <20080221054332.GB2887@spearce.org>
X-Mailer: Evolution 2.12.0 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74602>


On Thu, 2008-02-21 at 00:43 -0500, Shawn O. Pearce wrote:
> Mike Galbraith <efault@gmx.de> wrote:
> > On Thu, 2008-02-21 at 00:33 -0500, Shawn O. Pearce wrote:
> > > Mike Galbraith <efault@gmx.de> wrote:
> > > > I have no idea how tree became "seeked", but would love to know how to
> > > > "un-seek" it so I can proceed with a bisection.  Help?
> > > 
> > > I think you are already in the middle of a bisect.
> > > 
> > > Try "git bisect reset" first to get out of the current bisect before
> > > starting another one.
> > 
> > It says "We are not bisecting".
> 
> Your repository is in a funny state.  The file .git/BISECT_NAMES
> was removed but .git/head-name was not.  Deleting .git/head-name
> should resolve the issue.  But it would be interesting to know how
> the repository came into this state.

Bingo, thanks!

There's only one git user here, so I have a good idea who to blame...
but he (me) is claiming innocence.  The content of head-name was
"master" fwiw.

	-Mike
