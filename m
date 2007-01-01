From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 00:45:36 -0500
Message-ID: <20070101054536.GG15537@fieldses.org>
References: <20070101034825.GD15537@fieldses.org> <951491.40207.qm@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 06:46:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Fzf-0002uY-BF
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 06:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbXAAFpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 00:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbXAAFpk
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 00:45:40 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40260 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbXAAFpk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 00:45:40 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1FzM-0000FP-Sm; Mon, 01 Jan 2007 00:45:36 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <951491.40207.qm@web31807.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35724>

On Sun, Dec 31, 2006 at 09:13:49PM -0800, Luben Tuikov wrote:
> Yes, but I don't want to just type "git-pull", I want to explicitly
> type "git-pull parent" and depending in which branch I'm at, "parent"
> would have identical meaning but would merge a different branch... because
> I'm in a different branch...

Wouldn't it do what you want if by default "git branch new" and "git
checkout -b new" set branch.* options that pointed at the "parent"
branch?

The only reason I can see to require the extra bit of syntax ("git-pull
parent" instead of "git-pull") is if for the same branch you expect to
sometimes pull from one source and sometimes from another, and the pulls
from those various sources are common enough that it's worth defining
some shortcuts for more than one of them.

I can imagine sometimes doing that.  (E.g. if you pull into your master
branch from upstream and from local topic branches.)  But in that case
having to give the remote and branch name explicitly doesn't seem so
bad.

I dunno....

--b.
