From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] Clean up work-tree handling
Date: Thu, 02 Aug 2007 00:04:52 -0700
Message-ID: <7vsl72zaaz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
	<Pine.LNX.4.64.0708010058130.14781@racer.site>
	<Pine.LNX.4.64.0708010129530.14781@racer.site>
	<7v3az3deac.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708011239090.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matled@gmx.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 09:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGUjz-000654-9t
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 09:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbXHBHEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 03:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXHBHEz
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 03:04:55 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61592 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbXHBHEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 03:04:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802070454.TZLD26965.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 03:04:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Wv4s1X00K1kojtg0000000; Thu, 02 Aug 2007 03:04:53 -0400
In-Reply-To: <Pine.LNX.4.64.0708011239090.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 1 Aug 2007 12:46:50 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54521>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I do not think the following is exactly what your cleaned-up
>> version tries to perform, but I am writing this down primarily
>> to demonstrate the style and the level of detail I expect to
>> accompany a clean-up patch like this.
>
> After reading your description I sink into the ground in shame.  I really 
> like the style this has, and agree that something as nice as this should 
> have been there.

Not too late.  There always is a room for Documentation/
improvements ;-)

Seriously, I think config.txt mentions GIT_WORK_TREE and GIT_DIR
and git.txt has separate sections for environment and config,
but I do not see a good section that gives a comprehensive view
of how they work together to affect your git experience.
Perhaps between File/Directory Structure and Terminology
sections we would want to have a description of how repository
and worktree relate to each other.
