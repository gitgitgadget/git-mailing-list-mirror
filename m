From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport: setup indexes correctly for ancestors and incremental imports
Date: Sun, 25 Jun 2006 02:27:30 -0700
Message-ID: <7v4py9y48t.fsf@assigned-by-dhcp.cox.net>
References: <11511475882820-git-send-email-martin@catalyst.net.nz>
	<Pine.LNX.4.63.0606242111250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64iqq6ab.fsf@assigned-by-dhcp.cox.net>
	<20060625085359.GC21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 11:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuQu0-0007vb-Gb
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 11:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWFYJ1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 05:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWFYJ1d
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 05:27:33 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16864 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932170AbWFYJ1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 05:27:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625092732.IKL554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 05:27:32 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060625085359.GC21864@pasky.or.cz> (Petr Baudis's message of
	"Sun, 25 Jun 2006 10:53:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22597>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sun, Jun 25, 2006 at 05:10:36AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Please please please do not use --- between the cover letter and
>> commit message body if you choose to do the cover letter first.
>
> Oops, I suspect that I'm a huge offender in this regard in that case.
> Can I format my patch mails so that they look like natural replies _and_
> you can still apply them easily?

It's not a big deal.

I do it with scissors mark "-- >8 --" because I can use "git-am"
while still in GNUS with '|' (gnus-summary-pipe-output) on the
message, and immediately after that I can amend the commit with
"git-commit --amend" to remove everything up to the scissors
mark.

If you have --- then I have to save the message in a separate
file with 'C-o' (gnus-summary-save-article-mail), open the file
and remove up to that first --- in the editor, and then run
git-am on the file.

Only when the cover letter is short, I'd prefer Linus style,
which places cover letter material after the --- and the
diffstat, although that makes the message like top-posting.
