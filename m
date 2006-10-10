From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Mon, 09 Oct 2006 21:33:54 -0700
Message-ID: <7v7iz894ct.fsf@assigned-by-dhcp.cox.net>
References: <20061010025627.19317.70511.stgit@rover>
	<7vejtg97qh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 06:35:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX9Jj-0003xX-73
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 06:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWJJEd4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 00:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWJJEd4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 00:33:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13701 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964956AbWJJEdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 00:33:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010043355.FIKF21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 00:33:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YUZx1V00j1kojtg0000000
	Tue, 10 Oct 2006 00:33:58 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7vejtg97qh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 09 Oct 2006 20:20:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28600>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> If the project includes a README file, show it in the summary page.
>...
> I wonder how this should relate to .git/description file,
> though.  In other words, it _might_ make sense to change where
> we show the contents of description right now to show the first
> line and take README from the same location.

Also we might want to consider using this file (or description)
for git-daemon "motd" action if we were to enhance it.  I
remember that early days of git-daemon some people wanted to
have motd.
