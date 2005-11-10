From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 14:09:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511101405300.25300@iabervon.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
 <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net> <20051110180311.GR30496@pasky.or.cz>
 <Pine.LNX.4.64.0511101317500.25300@iabervon.org> <7vk6fgz5nc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:12:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHo8-0007zY-MN
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVKJTJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVKJTJ5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:09:57 -0500
Received: from iabervon.org ([66.92.72.58]:32786 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932161AbVKJTJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:09:57 -0500
Received: (qmail 3910 invoked by uid 1000); 10 Nov 2005 14:09:53 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Nov 2005 14:09:53 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6fgz5nc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11505>

On Thu, 10 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > ... (That is, you 
> > want the head of an unreachable chain listed for recovery, but not other 
> > things reachable from it; you also may want the list of blobs and trees 
> > not reachable either from a ref or from something listed for recovery, but 
> > not omitting a blob reachable only from an unreachable tree)
> 
> I thought that was what those 'dangling blah' was about...
> That is, if you make commit A and then on top of that commit B,
> and lose both, you will see dnagling for B but not A (which is
> reachable from B).

Right; what I was pointing out is that you want the dangling commits, but 
the unreachable blobs and trees, and want reachability to count things 
listed as dangling, which is a somewhat novel combination of desires, I 
think.

	-Daniel
*This .sig left intentionally blank*
