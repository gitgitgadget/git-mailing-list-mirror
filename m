From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Mon, 09 Oct 2006 20:20:54 -0700
Message-ID: <7vejtg97qh.fsf@assigned-by-dhcp.cox.net>
References: <20061010025627.19317.70511.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 10 05:21:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX8BP-0002BF-Dy
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 05:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJJDU5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 23:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWJJDU5
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 23:20:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6113 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964773AbWJJDUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 23:20:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010032055.ZNTA22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 23:20:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YTLx1V00T1kojtg0000000
	Mon, 09 Oct 2006 23:20:58 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061010025627.19317.70511.stgit@rover> (Petr Baudis's message
	of "Tue, 10 Oct 2006 04:56:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28599>

Petr Baudis <pasky@suse.cz> writes:

> If the project includes a README file, show it in the summary page.
> The usual "this should be in the config file" argument does not apply here
> since this can be larger and having such a big string in the config file
> would be impractical.
>
> I don't know if this is suitable upstream, but it's one of the repo.or.cz
> custom modifications that I've thought could be interesting for others
> as well.

I agree something like this would be very useful.

I wonder how this should relate to .git/description file,
though.  In other words, it _might_ make sense to change where
we show the contents of description right now to show the first
line and take README from the same location.

Having said that I'd take this as is in "next" and wait for
public to decide having two separate files is Ok (which I
suspect is the case) or we'd be better off in the longer term to
try to minimize random files under $GIT_DIR.
