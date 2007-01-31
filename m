From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 20:48:13 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701302042160.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <20070130231015.GB10075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 02:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC4aE-0000Jj-7O
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 02:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbXAaBsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 20:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbXAaBsS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 20:48:18 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38193 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbXAaBsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 20:48:18 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCP00GYDMCEKFD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Jan 2007 20:48:16 -0500 (EST)
In-reply-to: <20070130231015.GB10075@coredump.intra.peff.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38219>

On Tue, 30 Jan 2007, Jeff King wrote:

> On Tue, Jan 30, 2007 at 12:13:26PM -0800, Carl Worth wrote:
> 
> > Also, if I'm willing to assume (or insist) that users have git 1.5 or
> > newer, it'd be nice to be able to drop the "-b build" thing thanks to
> > the new detached HEAD support. But if I suggest doing just:
> > 
> > 		git checkout origin/proposed-fix
> > 
> > the user is presented with the following message which is much more
> > scary than useful in this situation:
> > 
> > 	warning: you are not on ANY branch anymore.
> > 	If you meant to create a new branch from the commit, you need -b to
> > 	associate a new branch with the wanted checkout.  Example:
> > 	  git checkout -b <new_branch_name> origin/proposed-fix

Note that the latest revision on the master branch of git has a slightly 
less scary message.

> I don't see any reason why we can't scare the user when making a commit,
> instead of just checkout out to look around. Something like the patch
> below. It needs a few things:
>   - remove the old checkout message

I don't think that is a good idea in general.

It is already kind of a challenge to teach people about git's branch 
concept.  The detached head is yet another exotic thing about git that 
is sure not to be really obvious to everyone.  Now if you remove the 
message to hide the detached head state from the user just to come later 
on with a "hey btw did you know that your head was detached?" message 
then you can be assured that most people will simply go WTF.


Nicolas
