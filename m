From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Thu, 09 Feb 2006 12:38:06 -0800
Message-ID: <7vd5hw9sk1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 21:39:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7IYR-0007To-CC
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 21:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWBIUiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWBIUiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 15:38:09 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:55704 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750772AbWBIUiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 15:38:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209203516.EGGM17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 15:35:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 9 Feb 2006 12:27:58 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15825>

Linus Torvalds <torvalds@osdl.org> writes:

> I found another nitpick: file removal doesn't seem to generate a good 
> diff in "git-diff-tree --cc" (but it's correct in the new "raw" format 
> diff).
>
> Here's a test-case, in case you care.

Actually, I've known about the removals and have excuse in one
of the commits why it does not show them.

It is an excuse (the internal data structure is not really
suited to show removal diff), but I think what the excuse gives
as the official reasoning behind it sort of make sense from
usability point of view as well.
