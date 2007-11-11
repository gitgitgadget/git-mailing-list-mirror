From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitk/git-gui misfeature: saving the geometry can the window out of reach
Date: Sun, 11 Nov 2007 00:11:29 -0500
Message-ID: <20071111051128.GS14735@spearce.org>
References: <63F7323C-D90A-4F5E-AE3C-8937455972FD@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Nov 11 06:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir56u-00086E-34
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbXKKFLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbXKKFLd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:11:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38061 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbXKKFLd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 00:11:33 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir56M-0003ga-39; Sun, 11 Nov 2007 00:11:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 314C720FBAE; Sun, 11 Nov 2007 00:11:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <63F7323C-D90A-4F5E-AE3C-8937455972FD@lrde.epita.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64400>

Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> gitk (and I think git-gui too) save their "geometry" (which includes  
> X/Y position) in ~/.gitk.  So far so good.  The problem is that I  
> often use 2 screens at work (one is the screen of my laptop, the  
> other one is above) and I happen to put my gitk/git-gui windows on  
> the 2nd screen.  When I go back home, I don't have a second screen  
> and gitk/git-gui open their windows out of reach.  This could well be  
> an ugly wart in Apple's port of Tcl/Tk (I have a MacBook with OSX  
> 10.4.10) or a more general problem (didn't try with other OSes).
> 
> git-gui version 0.8.4
> git version 1.5.3.5.654.gdd5ec (tonight's master's HEAD)
> Tcl/Tk version 8.4.7 (Apple's)
> (gitk doesn't support --version!)
> 
> For those struggling with the same problem, here is a quick workaround:
>   gnused -i /geometry/d ~/.gitk

Actually git-gui saves the geometry to .git/config so I'm not sure
why the sed line above would correct git-gui's display issues.  But I
have also noticed this problem on my Mac OS X laptop when running
again after leaving either git-gui or gitk on the external display.

I once started working on a fix for git-gui but put it aside as I
didn't have an external monitor handy.  I haven't hooked one up to
my laptop in months so it would be a bit of work for me to test
and debug.

-- 
Shawn.
