From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 10:15:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701311007550.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
 <Pine.LNX.4.64.0701302052230.3021@xanadu.home>
 <Pine.LNX.4.64.0701302331440.20138@iabervon.org>
 <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
 <20070131143811.GC10646@fieldses.org> <epqaej$nug$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHBl-00068Z-AO
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbXAaPPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbXAaPPe
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:15:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27877 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbXAaPPd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:15:33 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ00EAINPWQT50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 10:15:32 -0500 (EST)
In-reply-to: <epqaej$nug$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38257>

On Wed, 31 Jan 2007, Jakub Narebski wrote:

> I'd like to have some configuration option to make git more careful
> and prohibit commiting in detached HEAD state (the default being that
> you can commit on top of detached HEAD). More secure but less powerfull.

And what is the purpose of such an artificial annoyance that no one will 
turn on on purpose?

You have to _realize_ that there is nothing wrong with such commits.  
Merely having a config option to prohibit them not only is senseless 
technically but it also send the wrong message to users.

> > By the same argument, the original checkout of a non-branch is also not
> > the place for a warning; by the time you commit and then do a checkout
> > to switch away from the new commit, that original checkout may be a
> > distant memory.
> 
> But the initial checkout of a non-branch is place where we can notify
> user that he does something unexpected / unusual. Though I think that
> single-line warning would be enough...

There is a balance problem there.  Too large a message might be annoying 
but a too short one might not convey enough information not to be yet 
more confusing.


Nicolas
