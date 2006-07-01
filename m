From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 14:01:25 -0400
Message-ID: <20060701180125.GA27550@fieldses.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org> <20060701150926.GA25800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 20:02:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwjmj-0006oH-Se
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbWGASBc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933150AbWGASBc
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:01:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:31634 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S933032AbWGASBa
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 14:01:30 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FwjmX-0007RE-6l; Sat, 01 Jul 2006 14:01:25 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <20060701150926.GA25800@lsrfire.ath.cx>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23052>

On Sat, Jul 01, 2006 at 05:09:26PM +0200, Rene Scharfe wrote:
> +Another special notation is <commit1>...<commit2> which is useful for
> +merges.  The resulting set of commits is the symmetric difference
> +between the two operands.  The following two commands are equivalent:

What's the logic behind naming the operator "..."?

Seems like asking for trouble to have two visually similar operators (".." and
"...") with different meanings, and "..." seems like kind of an arbitrary
choice anyway.

A symmetric difference is basically equivalent to an xor--would a carat ("^")
work?  Or could we just stick a word there instead of using some tricky
notation?

--b.
