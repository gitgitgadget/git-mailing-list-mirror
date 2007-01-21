From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sun, 21 Jan 2007 03:19:51 -0800
Message-ID: <7vac0c39uw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhcum80u4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701202225020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhcuk500j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701211152400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 12:19:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8ajs-00079n-C9
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 12:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXAULTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 06:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAULTx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 06:19:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61217 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbXAULTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 06:19:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121111951.NBOE16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 06:19:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DnJw1W00E1kojtg0000000; Sun, 21 Jan 2007 06:18:57 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701211152400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 21 Jan 2007 11:53:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37320>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 20 Jan 2007, Junio C Hamano wrote:
>
>> Sorry, I was reading the timestamp wrong.  That is one minute 
>> thirty-five seconds past midnight, not thirty five minute past one 
>> o'clock.
>
> Wow! I missed that completely!

Sorry for that.  It was late and I was tired.

By the way, "git log --walk-reflog master@{now}" seems to give
me one non-reflog entry output for me at the end (which is I
think the parent of the oldest reflog entry which itself does
not have the record of being at the tip of the ref in
question).  Other than that I think we are Ok.

Also doesn't --walk-reflog sound too long?
