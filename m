From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 29 Dec 2006 22:21:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612292219280.18171@xanadu.home>
References: <7vtzzfp86x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 30 04:21:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0Umk-00050z-91
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 04:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWL3DVW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 22:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWL3DVW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 22:21:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10059 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030229AbWL3DVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 22:21:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JB2001RBHBK5EG0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Dec 2006 22:21:21 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0612291853210.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35612>

On Fri, 29 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 28 Dec 2006, Junio C Hamano wrote:
> 
> > * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
> >  + git-merge: preserve and merge local changes when doing fast
> >    forward
> 
> I'd like this, but behind a command line switch. And in addition to saying 
> "cannot merge, blabla needs update", git could spit out "if you want to 
> risk a 3way merge, go ahead and add the --preserve-local flag to 
> git-merge".
> 
> Comments?

Is there really a point for not always doing it?

IOW, if you really want a command line switch, maybe it should be used 
to prevent the above not to allow it?


Nicolas
