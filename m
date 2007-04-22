From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Add 'filter' attribute and external filter driver definition.
Date: Sat, 21 Apr 2007 23:12:36 -0700
Message-ID: <7v7is5rl7v.fsf@assigned-by-dhcp.cox.net>
References: <11771520591529-git-send-email-junkio@cox.net>
	<11771520591703-git-send-email-junkio@cox.net>
	<alpine.LFD.0.98.0704212243080.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 08:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfVJQ-000090-4L
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 08:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbXDVGMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 02:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbXDVGMh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 02:12:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:47486 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbXDVGMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 02:12:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422061236.HWMZ1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 02:12:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id q6Cc1W0061kojtg0000000; Sun, 22 Apr 2007 02:12:36 -0400
In-Reply-To: <alpine.LFD.0.98.0704212243080.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 21 Apr 2007 22:47:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45218>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I suspect that this gets some complaining off our back, but I *also* 
> suspect that people will actually end up really screwing themselves with 
> something like this and then blaming us and causing a huge pain down the 
> line when we've supported this and people want "extended semantics" that 
> are no longer clean.
>
> But I'm not sure how valid an argument that really is. I do happen to 
> believe in the "give them rope" philosophy. I think you can probably screw 
> yourself royally with this, but hey, anybody who does that only has 
> himself to blame ...

That's exactly my argument when I had an exchange with Nico on
this thread.  I haven't decided if I want to make them (I sent
out a replacement patch for the tip one, and added another one)
merged in 'next' yet for that exact reason.
