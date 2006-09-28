From: Nicolas Pitre <nico@cam.org>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 10:34:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609281029300.9349@xanadu.home>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
 <Pine.LNX.4.64.0609272232040.9349@xanadu.home>
 <7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 16:35:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSwyg-0002B7-7K
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 16:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161152AbWI1Oe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWI1Oe5
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 10:34:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:3918 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161152AbWI1Oe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 10:34:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6B00MWG4I8LX20@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 28 Sep 2006 10:34:56 -0400 (EDT)
In-reply-to: <7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28003>

On Wed, 27 Sep 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > SYNOPSIS
> >
> > 	git-local-arrival <committish>
> >
> > DESCRIPTION
> >
> > 	The command displays the time when given commit appeared in the 
> > 	local repository.
> 
> This should be certainly doable, but local-arrival may not be
> interesting if the repository has more than one branches.  Maybe
> 
> 	git-local-arrival <committish> [<branch>]
> 
> which defaults to the current branch?

Indeed.  I didn't mention it initially because it is really easy to do 
once you have it working for the current branch.  The technical 
challenge is about making it efficient to find out which reflog entry 
with a path to given commit is the oldest.


Nicolas
