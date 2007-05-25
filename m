From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make "git gc" pack all refs by default
Date: Thu, 24 May 2007 19:04:59 -0700
Message-ID: <7vy7jdu08k.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0705241132400.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 25 04:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrPAv-0000xN-VF
	for gcvg-git@gmane.org; Fri, 25 May 2007 04:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbXEYCFC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 22:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbXEYCFB
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 22:05:01 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:54541 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbXEYCFB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 22:05:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525020502.PDSY13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 22:05:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3E501X00A1kojtg0000000; Thu, 24 May 2007 22:05:00 -0400
In-Reply-To: <alpine.LFD.0.98.0705241132400.26602@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 24 May 2007 11:41:39 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48329>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Also, make the default for refs packing just be an unambiguous "do it", 
> rather than "do it by default only for non-bare repositories". If you want 
> that behaviour, you can always just add a
>
> 	[gc]
> 		packrefs = notbare
>
> in your ~/.gitconfig file, but I don't actually see why bare would be any 
> different (except for the broken reason that http-fetching used to be 
> totally broken, and not doing it just meant that it didn't even get 
> fixed in a timely manner!).

Boy, you are a lot more aggressive than me.

But the fix was in v1.5.0 and we had two feature releases since
then, so it's a good time to do this.  Thanks.
