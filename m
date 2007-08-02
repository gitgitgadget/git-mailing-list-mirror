From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Thu, 2 Aug 2007 14:18:53 -0400
Message-ID: <20070802181853.GB31885@fieldses.org>
References: <11858118802945-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 20:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGfGG-0004oL-Am
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 20:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755814AbXHBSS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 14:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbXHBSS5
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 14:18:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:42637 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbXHBSS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 14:18:56 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IGfG9-0000Tn-P6; Thu, 02 Aug 2007 14:18:53 -0400
Content-Disposition: inline
In-Reply-To: <11858118802945-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54582>

On Mon, Jul 30, 2007 at 06:11:20PM +0200, Steffen Prohaska wrote:
> git gui is especially useful because it allows to select diff hunks.
> Now it is at least mentioned in the user-manual.

Hm, OK.  I think the user manual's only departures from the commandline
right now are a few mentions of gitk (which don't actually explain how
to use it; I assume that's self-explanatory).

But this seems interesting enough to be worth a mention, thanks.

> +Another approach for creating commits is git gui:
> +
> +-------------------------------------------------
> +$ git gui citool
> +-------------------------------------------------
> +
> +starts the commit tool (Note, "`git gui`" starts the full gui, which
> +provides more options).
> +
> +Beyond the basic operation of staging and unstaging complete files,
> +git gui can also selectively stage diff hunks.  You can do so by
> +selecting a modified or staged file and right-click on the diff view
> +in the lower part of the gui. A pop-up will appear that lets you
> +select a specific hunk and stage or unstage it for the next commit.
> +This is particular useful for slicing large, ugly commits into smaller
> +pieces, for example when cherry-picking (see
> +<<reordering-patch-series>>).

I wonder whether we could get away with just the brief list of features
("lets you view changes in the index and the working file, lets you
individually select diff hunks for inclusion in the index"), and leave
the how-to stuff to online guit-gui help, if it's necessary?

Also, I like the verb "stage" as a way to explain the part of the index
file in creating commits, but I've been consistently using the word
"index" throughout the user manual, and I think that's consistent with
the rest of the documentation--so don't avoid it here.

--b.
