From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 11 Apr 2006 10:58:58 -0700
Message-ID: <7vpsjo56zh.fsf@assigned-by-dhcp.cox.net>
References: <7v3bgk7mhy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604110645060.3722@g5.osdl.org>
	<20060411155518.GY27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 19:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTN8t-0004WR-LF
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 19:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWDKR7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 13:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWDKR7E
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 13:59:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:39368 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750896AbWDKR7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 13:59:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411175859.PLDT17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Apr 2006 13:58:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060411155518.GY27689@pasky.or.cz> (Petr Baudis's message of
	"Tue, 11 Apr 2006 17:55:18 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18615>

Petr Baudis <pasky@suse.cz> writes:

>> I think the builtins should be a install-time only issue. 
>
> I don't care about git-log in particular since I don't use it, but I use
> development Git versions without actually installing them and if it's
> not a huge hurdle, it would be nice to keep this possible.

Also not making the link would probably break test suite (I do
not know if we have git-log test right now, though).

But installing *copies* is obviously not right as you pointed out.
