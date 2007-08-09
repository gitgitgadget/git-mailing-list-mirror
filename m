From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 09 Aug 2007 11:11:38 -0700
Message-ID: <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 20:11:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJCU4-0005OY-9x
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 20:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbXHISLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 14:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbXHISLk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 14:11:40 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48773 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXHISLj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 14:11:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070809181138.PWPX23215.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 9 Aug 2007 14:11:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZuBe1X00C1kojtg0000000; Thu, 09 Aug 2007 14:11:38 -0400
In-Reply-To: <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 9 Aug 2007 11:06:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55467>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 9 Aug 2007, Linus Torvalds wrote:
>> 
>> Gaah. This shouldn't be *that* hard to fix, but I'm not entirely sure I'll 
>> have time today.
>
> In fact, I'm almost sure I will *not* have time today.
>
> Anyway, the really trivial (and ugly) fix is to handle the cases of adding 
> _independent_ stages to the index (which is the case for both "git 
> diff-index" and "git read-tree -m") differently...
> ...
> Sadly, this is an area that is almost exclusively mine and Junio's. I'd 
> love for somebody else to get their feet wet,...

I hopefully have some time this evening to look into this, if
not earlier.
