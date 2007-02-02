From: Junio C Hamano <junkio@cox.net>
Subject: Re: Instructions concerning detached head lead to lost local changes
Date: Thu, 01 Feb 2007 23:44:24 -0800
Message-ID: <7vps8thulj.fsf@assigned-by-dhcp.cox.net>
References: <87mz3xa3vr.wl%cworth@cworth.org>
	<7v1wl9mj48.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702012135550.3021@xanadu.home>
	<20070202065949.GI18880@thunk.org>
	<Pine.LNX.4.64.0702020206480.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 08:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCt6P-0005DS-LZ
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 08:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423199AbXBBHo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 02:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423178AbXBBHo0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 02:44:26 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:42060 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423199AbXBBHoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 02:44:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202074425.WQJB1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 2 Feb 2007 02:44:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JXkQ1W00X1kojtg0000000; Fri, 02 Feb 2007 02:44:25 -0500
In-Reply-To: <Pine.LNX.4.64.0702020206480.3021@xanadu.home> (Nicolas Pitre's
	message of "Fri, 02 Feb 2007 02:14:07 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38471>

Nicolas Pitre <nico@cam.org> writes:

> It's just that moving around amongst thousands of commits to pin point a 
> particular commit might require some digging work.  This is why there 
> might be some value in a particular position and why there is an attempt 
> at protecting that "work".
>
> But since moving to another position while still remaining detached from 
> any branch has the same potential for losing the important position and 
> so without any kind of protection then it makes no sense to have such a 
> protection when moving back to a branch.

Thanks -- I'd agree.

Also I agree that "reflog on HEAD" is the right direction as it
makes these 'protection' unnecessary.  I've applied all your
patches from today on the topic, along with Johannes's "log -g
@{now}".
