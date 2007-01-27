From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 14:00:53 -0800
Message-ID: <7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 23:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAvbh-0006io-6q
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 23:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXA0WA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXA0WA7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 17:00:59 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59771 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbXA0WAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 17:00:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127220054.WNYS16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 17:00:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GMzw1W00Y1kojtg0000000; Sat, 27 Jan 2007 16:59:57 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37999>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> This should be an example of how important interfaces can be to what feels 
> "slow".

I learn new thing (or relearn things I knew but did not apply in
my argument myself) every day from you, and this is a prime
example ;-).  I agree that latency in giving feedback helps the
feel of speed, and the feel is the most important thing in UI.

> Btw, Junio - even if nobody writes a graphical front-end for that 
> "--incremental" flag, this should be in 1.5.0. If only so that people 
> could write those front-ends and not have to patch git to get the blame 
> information out of it.
>
> The exact format for the output of this thing is obviously very debatable: 
> it might well be worthwhile to use a more verbose thing that also gives 
> the commit name and date etc information (since git-blame knows it), so 
> that any graphical front-end doesn't need to look up every commit as it 
> comes out of the incremntal blame engine. I just wrote it as a quick 
> "proof of concept" thing, and the output is obviously pretty minimalistic 
> right now.

I would think we probably should reuse the --porcelain output,
perhaps enhancing it even more.
