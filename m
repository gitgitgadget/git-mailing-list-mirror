From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Insert ACTIVESTATE_STRING in Git.pm
Date: Mon, 22 Jan 2007 16:44:29 +0100
Message-ID: <20070122154429.GG18276@pasky.or.cz>
References: <81b0412b0701220632t50ad42c4ucb0ebae140a9706a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 22 16:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91Lc-0002hR-R1
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 16:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbXAVPoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 10:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXAVPoe
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 10:44:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43883 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbXAVPod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 10:44:33 -0500
Received: (qmail 19034 invoked by uid 2001); 22 Jan 2007 16:44:29 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0701220632t50ad42c4ucb0ebae140a9706a@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37419>

On Mon, Jan 22, 2007 at 03:32:28PM CET, Alex Riesen wrote:
> Also add "git" to the pipe parameters, otherwise it does not work at all, as
> no git commands are usable out of git context.
> 
> ---
> 
> This is not enough to make it work on ActiveState. It's just to
> fix obvious TODOs, which should help someone to get it going.
> The other problems are:
> - tie refuses to bind a handle class activestate_pipe to a scalar $fh
>   (a patch follows)
> - there are some unexplained warnings about uninitialized values
> - cygwin-windows pathname conversion (not fixable at all)
> 
> perl/Git.pm |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)

Cool.

Acked-by: Petr Baudis <pasky@suse.cz>

Perhaps ACPIPE could use some comment in the code but that's just vain
nitpicking.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
		-- Kurt Vonnegut, Sirens from Titan
