From: Petr Baudis <pasky@suse.cz>
Subject: Re: fetch failure from git2.kernel.org?
Date: Sun, 22 Apr 2007 16:20:20 +0200
Message-ID: <20070422142020.GR4489@pasky.or.cz>
References: <86fy6ssp32.fsf@blue.stonehenge.com> <20070422125307.GA2431@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 16:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfcvY-0001IQ-Jo
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 16:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030894AbXDVOUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 10:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030901AbXDVOUX
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 10:20:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53685 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030894AbXDVOUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 10:20:23 -0400
Received: (qmail 8923 invoked by uid 2001); 22 Apr 2007 16:20:20 +0200
Content-Disposition: inline
In-Reply-To: <20070422125307.GA2431@steel.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45244>

On Sun, Apr 22, 2007 at 02:53:07PM CEST, Alex Riesen wrote:
> Randal L. Schwartz, Sun, Apr 22, 2007 12:03:45 +0200:
> > 
> > is this known?  transient?
> > 
> >     $ git-fetch
> >     warning: no common commits

This in itself is weird. :-)

> >     remote: Generating pack...
> >     remote: Done counting 0 objects.
> >     remote: aborting due to possible repository corruption on the remote side.
> >     fatal: protocol error: bad pack header
> >     fatal: Fetch failure: git://git2.kernel.org/pub/scm/git/git.git
> >     $
> > 
> 
> Confirm this. BTW, git1 and git2 point to the same 140.211.167.38
> (poseidon.kernel.org). It used to be different addresses

Curiously enough, I have hit no problems with fetching from the
repo.or.cz mirror (which is using several months old git version, if
that might matter).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
