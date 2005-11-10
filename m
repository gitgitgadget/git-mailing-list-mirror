From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 11:04:07 -0800
Message-ID: <7vk6fgz5nc.fsf@assigned-by-dhcp.cox.net>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
	<43737EC7.6090109@zytor.com> <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
	<20051110180311.GR30496@pasky.or.cz>
	<Pine.LNX.4.64.0511101317500.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:07:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHin-000608-Og
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVKJTEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVKJTEK
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:04:10 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11247 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932158AbVKJTEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 14:04:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110190320.JTBC29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 14:03:20 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511101317500.25300@iabervon.org> (Daniel
	Barkalow's message of "Thu, 10 Nov 2005 13:31:16 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11503>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... (That is, you 
> want the head of an unreachable chain listed for recovery, but not other 
> things reachable from it; you also may want the list of blobs and trees 
> not reachable either from a ref or from something listed for recovery, but 
> not omitting a blob reachable only from an unreachable tree)

I thought that was what those 'dangling blah' was about...
That is, if you make commit A and then on top of that commit B,
and lose both, you will see dnagling for B but not A (which is
reachable from B).
