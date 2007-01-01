From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Sun, 31 Dec 2006 22:48:25 -0500
Message-ID: <20070101034825.GD15537@fieldses.org>
References: <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net> <59142.7095.qm@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 04:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1EAA-0004Bx-8a
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 04:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933246AbXAADsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 22:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933247AbXAADsb
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 22:48:31 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34158 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933246AbXAADsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 22:48:30 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1E9x-0007AD-CJ; Sun, 31 Dec 2006 22:48:25 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <59142.7095.qm@web31801.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35722>

On Sun, Dec 31, 2006 at 07:29:22PM -0800, Luben Tuikov wrote:
> I.e. I'd like to say "git-pull parent" or "git-pull parents"
> in such and such branch, and this would pull the designated
> parent(s) for the current branch.  But if I'm in a different
> branch (of the same repo) then the meaning of "parent" changes
> accordingly.

Could you explain a situation where this would be useful?  A
"parent<-->child" relationship, where there's one upstream branch that
is always merged in, is easily handled; just replace your "git pull
parent" by a "git pull", right?  Am I misunderstanding the proposal?

And is there any reason why your proposal conflicts with Junio's?

--b.
