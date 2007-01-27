From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 20:19:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701272017110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <45BB9C8B.8020907@fs.ei.tum.de> <Pine.LNX.4.63.0701271959000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BBA405.6050409@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAt53-0006yK-Q9
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbXA0TTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbXA0TTO
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:19:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:59921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752352AbXA0TTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:19:14 -0500
Received: (qmail invoked by alias); 27 Jan 2007 19:19:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 27 Jan 2007 20:19:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45BBA405.6050409@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37987>

Hi,

On Sat, 27 Jan 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> > > Okay, let's try to assume for now that nobody said "git blame".  
> > > Instead let's say:
> > > 
> > > git rev-list and git log (with or without -p) perform poorly when 
> > > invoked with a pathspec.
> > 
> > So what? You _will_ be interested in the _newest_ changes _99%_ of the 
> > time. And for these you don't need to wait 1:18, but 0:00.01 or so.
> 
> not if you are interested which commit introduced/changed a particular 
> line.

Wonderful. Say, you want to know who last changed the beginning of the 
function main() in git.c:

	$  git blame -L '/main(/,+20' git.c

What was your point again?

> > > This particular file has 64 revisions.  However there are ~ 375000 
> > > revisions in the converted repo.
> > 
> > "file version" trap! "file version" trap! "file version" trap!
> 
> call it path and retry.

Does not matter. Not one wit. Your reasoning is still harping on "file 
versions".

Ciao,
Dscho
