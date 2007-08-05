From: Junio C Hamano <gitster@pobox.com>
Subject: Re: way to automatically add untracked files?
Date: Sat, 04 Aug 2007 22:14:55 -0700
Message-ID: <7vr6mih8a8.fsf@assigned-by-dhcp.cox.net>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 07:15:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYSF-0006g4-8S
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbXHEFO6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbXHEFO5
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:14:57 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37687 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbXHEFO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 01:14:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070805051457.JYEY11888.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 5 Aug 2007 01:14:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y5Ew1X0011kojtg0000000; Sun, 05 Aug 2007 01:14:56 -0400
In-Reply-To: <alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 4 Aug 2007 22:03:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54950>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... (except, as we found out last week, we've had a huge 
> performance regression, so that's actually a really slow way to do it, and 
> so it's actually faster to do
>
> 	git ls-files -o | git update-index --add --stdin
> 	git commit -a
>
> instead...

Is it still the case after the fix in rc4?  Other than the
theoretical "on multi-core, ls-files and update-index can run in
parallel" performance boost potential, I thought the fixed
"git-add ." would be the same...
