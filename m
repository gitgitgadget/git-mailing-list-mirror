From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk geometry bug on OSX
Date: Sun, 20 Jan 2008 23:52:07 -0500
Message-ID: <20080121045207.GI24004@spearce.org>
References: <58195B8E-BBFF-4B4D-9986-2D46E5C5BB27@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Jan 21 05:52:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGoeH-0003Gj-Kf
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 05:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbYAUEwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 23:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756805AbYAUEwM
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 23:52:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57543 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbYAUEwL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 23:52:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGodY-0007h7-FD; Sun, 20 Jan 2008 23:51:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A59D220FBAE; Sun, 20 Jan 2008 23:52:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <58195B8E-BBFF-4B4D-9986-2D46E5C5BB27@lrde.epita.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71219>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> there is another nit which annoys me in gitk.  Besides the fact that  
> the maximize button (the green `+' button that is part of Apple-style  
> windows) does not do anything, I can't maximize the window on a 2nd  
> screen even if I try manually.  Wild guess: I can't make the window  
> bigger than the maximum area usable on the main screen of my MacBook  
> (max area = screen resolution - area used by the Apple menu - (dock  
> hides automatically ? 0 : min size of dock)).
> 
> Whether this is a bug in gitk or in Apple's port of Tcl/Tk (I'm still  
> under Tiger btw), this is another story.  But if there's a known  
> workaround for this issue, I'd be great if gitk could include it :-)
> 
> PS: I've just checked and, yes, I have the same issue with git-gui.

I'm pretty certain this is an issue with the aqua port of Tcl/Tk
and not with git-gui or gitk directly.

git-gui and gitk both maximize correctly under Win32.  But you are
quite right, here on my Mac OS X system (Tcl/Tk 8.4.10) the maximize
button doesn't do anything.

I haven't tried Tcl/Tk 8.5 yet to see if this problem has been
resolved by the more recent release.

-- 
Shawn.
