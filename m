From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: Big syntax change; support rewriting multiple refs
Date: Mon, 23 Jul 2007 22:35:16 -0700
Message-ID: <7vfy3ejre3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 07:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDD3M-0001kB-8k
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 07:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbXGXFfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 01:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbXGXFfT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 01:35:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49260 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbXGXFfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 01:35:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724053516.SEJV1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 01:35:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id THbG1X00B1kojtg0000000; Tue, 24 Jul 2007 01:35:16 -0400
In-Reply-To: <Pine.LNX.4.64.0707231829210.14781@racer.site> (Johannes
	Schindelin's message of "Mon, 23 Jul 2007 18:34:13 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53523>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Junio, I know that this comes quite late in the game, but I really
> 	think that the "first arg is new branch name" was a bad syntax.
>
> 	Could you please consider taking this patch (or whatever version
> 	comes out after review ;-) or keeping filter-branch of 1.5.3?  I 
> 	do not want people to get used to the borked syntax...

Yeah, "No new features after -rc" should not apply to this one.

I was actually going to ask you about it, since this is a
feature we have already advertised to the public, but still is a
new feature, and we'd be better off getting it right in the
first public version.

> 	BTW I considered "git log -g --all" as an alternative to 
> 	inspecting refs/original/, but ATM this die()s if just _one_ of 
> 	the refs has no logs.  Probably should fix that, too.

I do not think refs/original/ is such a hot feature.  What's
wrong with "gitk mine@{1}...mine"?
