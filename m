From: Nicolas Pitre <nico@cam.org>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 16:20:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612221609430.18171@xanadu.home>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612221539100.18171@xanadu.home> <emhh4k$u4q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_5/1jGYvRTGfMnw0MfDX5Lw)"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:20:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxroh-0007CM-V6
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWLVVUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbWLVVUd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:20:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27096 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbWLVVUc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:20:32 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAP00GK51Y7LCX0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 16:20:31 -0500 (EST)
In-reply-to: <emhh4k$u4q$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35222>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_5/1jGYvRTGfMnw0MfDX5Lw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT


Could you at least keep me in CC when replying to me please?

On Fri, 22 Dec 2006, Jakub Narebski wrote:

> <opublikowany i wysłany>

?

> Nicolas Pitre wrote:
> > On Thu, 21 Dec 2006, Junio C Hamano wrote:
> 
> >> No, the message says "any REMOTE branch" -- refs/heads/next is
> >> what it is called at the remote, and that is how the value is
> >> expected to be spelled; I think somebody added an example to
> >> config.txt recently to stress this.  The above error messasge
> >> obviously was not clear enough.  Rewording appreciated.
> > 
> > But wouldn't it be much less confusing if it used the local name for 
> > that remote branch instead?  After all it is what should be used with 
> > git-merge if performed manually, it is what diff, log, and al must use 
> > as well.  Why would this need a remote name for something that is a 
> > local operation after all?  I think "refs/heads/master" is really 
> > ambigous since you might be confused between the local and remote 
> > meaning of it, whereas "origin/master" carries no confusion at all.
> 
> Perhaps less confusing, but also less powerfull. Current notation
> allows for pulling _without need for tracking branches_.

Is this really a killer feature worth the confusion?

If you put the repo to pull from on the command line then sure you might 
not want a tracking branch, but if you go to the trouble of adding a 
branch.blah.merge config entry then you certainly don't mind having a 
tracking branch?


Nicolas

--Boundary_(ID_5/1jGYvRTGfMnw0MfDX5Lw)--
