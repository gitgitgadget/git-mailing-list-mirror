From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current
 branch reflog
Date: Thu, 01 Feb 2007 16:46:56 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011632070.3021@xanadu.home>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
 <20070201191323.GA18608@spearce.org> <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 22:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjm3-0001Kc-FT
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 22:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbXBAVrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 16:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXBAVrA
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 16:47:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:28776 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbXBAVq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 16:46:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCT00GKC0I8PZ80@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 16:46:56 -0500 (EST)
In-reply-to: <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38410>

On Thu, 1 Feb 2007, Junio C Hamano wrote:

> Although from the consistency point of view, HEAD reflog to
> follow swicthing branches like Nico's patch aims for (but not
> implements fully yet) makes perfect sense, I still am somewhat
> doubtful about it being actually useful in practice.

It is useful as it then becomes almost impossible to lose things.  It 
could be a great tool to assist with user problems.  It also could serve 
as the data source for true back/undo/redo commands. And above all it 
just feels right.  ;-)

> Even if we assume it is useful, I think forbidding people from saying 
> HEAD@{...} right now only because the new semantics is unimplemented 
> yet feels wrong.  If you use only one branch, there is no difference 
> between the reflog of master and HEAD today, without waiting for that 
> "reflog on HEAD".

If you're OK with a potential semantic change for HEAD@{..} in the 
future then I don't mind.  The semantic change will affect those who 
actively use multiple branches and/or detached head.  Hopefully those 
people are confortable enough with git not to be confused by the change.

( I still think preventing HEAD@{} has its merits though )

Your call.


Nicolas
