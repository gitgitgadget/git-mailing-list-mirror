From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as
 threads.
Date: Fri, 29 Feb 2008 01:54:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290150440.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <47C6F40A.4010703@comcast.net> <alpine.LSU.1.00.0802290122110.22527@racer.site>
 <47C76407.3090804@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Paul Franz <thefranz@comcast.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:56:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUuTc-0003bL-3u
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbYB2BzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbYB2BzR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:55:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:39952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750880AbYB2BzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:55:16 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:55:14 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 29 Feb 2008 02:55:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iGHUISb/ipAZC5UXhMSHEa9Y0qeJ0KPQXuTaxM9
	2DahpH7Ge4QP01
X-X-Sender: gene099@racer.site
In-Reply-To: <47C76407.3090804@comcast.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75493>

Hi,

[top-posting?]

On Thu, 28 Feb 2008, Paul Franz wrote:

> True there are the legal issues. And it is not known if it would help on 
> other platforms. My may concern is Windows because if git could be made 
> available without some of msysGit's requirements. It would definitely 
> make it more palletable (sp?) to that community which is a large chunk 
> of developers, including my own work environment. I would love to switch 
> from ClearCase to git but there are issues. One of them is integration 
> with the Windows environment.

I think that you do not help the effort to bring Git to Windows, by 
suggesting even more work, for dubitable benefits.

And that is what I think of APR here.

NOTE: my only experience with APR on Windows is to get git-svn to compile, 
and there it was not only a PITA.  The result is _SLOW_.

> Another concern is performance penalty of using non-native calls under 
> Windows and that is one of the problems that I was hoping the using APR 
> would solve. I figure if it is good enough to support the network stuff 
> under Windows well maybe it would be good for git too.

The problems with Git and Windows are not network related.  They are with 
Windows' pitiful performance when it comes to spawn processes.

IMO your efforts to help Git on Windows would be better spent on the 
msysGit list, where you would learn about the real issues we face.

Ciao,
Dscho

