From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 27 Apr 2007 10:01:47 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704270938000.6186@xanadu.home>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net>
 <1177662893872-git-send-email-junkio@cox.net>
 <200704271019.56341.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 16:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhR1V-0002yl-2T
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 16:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbXD0OCF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 10:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755853AbXD0OCF
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 10:02:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29413 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbXD0OCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 10:02:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH5005BVTMZC100@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 27 Apr 2007 10:01:48 -0400 (EDT)
In-reply-to: <200704271019.56341.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45718>

On Fri, 27 Apr 2007, Andy Parkins wrote:

> I am still concerned about the submodule thing - once we push a mainline 
> version out with the format decided, that will be that and we'll be stuck 
> with it.  Are we _really_ sure that it's right to have a non-object hash in 
> the tree objects?
> 
> It's a fundamental change in the form of the tree: at the moment every hash in 
> the tree object represents another object in the same repository; with 
> gitlink as it is, that convention is broken.
> 
> Let's be really, really sure.  I'm not sure a big enough fuss has been made of 
> the fact that this is a change of repository format.  Before this you could 
> pretty much access any repository with any version.

I think it is reasonable to say that if you intend to work with a repo 
that contains references to submodules, then you need to upgrade your 
Git version.  It is not like if the Git licensing fees are really 
prohibitive.


Nicolas
