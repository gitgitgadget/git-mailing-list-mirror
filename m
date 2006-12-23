From: Nicolas Pitre <nico@cam.org>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 00:11:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612230008190.18171@xanadu.home>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612221539100.18171@xanadu.home>
 <7vpsabv6tm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzAA-0002sY-9K
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbWLWFLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbWLWFLI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:11:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49485 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbWLWFLH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:11:07 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAP0086PNQI6OD0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Dec 2006 00:11:06 -0500 (EST)
In-reply-to: <7vpsabv6tm.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35264>

On Fri, 22 Dec 2006, Junio C Hamano wrote:

> Well, "request" was very inprecise word -- I should have said
> "suggestion".  But I think I agree.
> 
> Seconds?  Thirds?
> 
> -- >8 --
> [PATCH] Do not support "partial URL shorthand" anymore.
> 
> We used to support specifying the top part of remote URL in
> remotes and use that as a short-hand for the URL.
> 
> 	$ cat .git/remotes/jgarzik
> 	URL: git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/
> 	$ git pull jgarzik/misc-2.6
> 
> This is confusing when somebody attempts to do this:
> 
> 	$ git pull origin/foo
> 
> which is not syntactically correct (unless you have origin/foo.git
> repository) and should fail, but it resulted in a mysterious
> access to the 'foo' subdirectory of the origin repository.
> 
> Which was what it was designed to do, but because this is an
> oddball "feature" I suspect nobody uses, let's remove it.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Well since I suggested it I seconds this of course.

If it ever becomes useful for, say, submodules as someone pointed out, 
then this can be restored at that point and done properly for the task.


Nicolas
