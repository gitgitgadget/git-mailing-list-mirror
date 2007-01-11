From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 09:59:40 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701110955100.4964@xanadu.home>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
 <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701102241230.4964@xanadu.home>
 <20070111080035.GA28222@spearce.org> <45A6016B.4030800@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 15:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H51P7-00006J-H2
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 15:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbXAKO7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 09:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbXAKO7l
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 09:59:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52603 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030450AbXAKO7l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 09:59:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBP00H2CLNGGW10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Jan 2007 09:59:40 -0500 (EST)
In-reply-to: <45A6016B.4030800@op5.se>
X-X-Sender: nico@xanadu.home
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36595>

On Thu, 11 Jan 2007, Andreas Ericsson wrote:

> Shawn O. Pearce wrote:
> > Where we really get hit is the large number of possible tags.  The
> > master branch is turning up 14 tags, some dating back to v1.4.1-rc1.
> > I do try to abort the revision list as soon as one of those tags
> > cannot give me a better selection than the one I have currently,
> > but I still had to generate a revision list to reach that point.
> > 
> 
> It could be worth skipping tags more than 6 months older than current
> branch-head. That would, at least for the git case, cut the number of tags
> down by a considerable amount.

This is bound to be wrong in some cases if a project is very active with 
many tags, or if there was a long period of inactivity. And what would 
be the benefit?  Saving 250ms on git-describe output latency?


Nicolas
