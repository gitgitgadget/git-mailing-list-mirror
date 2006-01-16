From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git
Date: Mon, 16 Jan 2006 11:53:56 +0100
Message-ID: <20060116105356.GH28365@pasky.or.cz>
References: <7vhd8al3ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 11:53:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyRyu-0004nY-TI
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 11:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbWAPKww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 05:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWAPKww
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 05:52:52 -0500
Received: from w241.dkm.cz ([62.24.88.241]:12229 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751122AbWAPKww (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 05:52:52 -0500
Received: (qmail 24599 invoked by uid 2001); 16 Jan 2006 11:53:56 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd8al3ae.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14740>

Dear diary, on Thu, Jan 12, 2006 at 01:04:41AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - Disable USE_SYMLINK_HEAD by default (Pavel Roskin).
> 
>    This has been on hold for almost two months -- forever in git
>    timescale.
> 
>    One offender that could have been broken by this change was
>    fixed recently (gitweb), so this can go in anytime now.  Do
>    people still care about it?  The argument for the change when
>    it was proposed was "then we only have to worry about one
>    format of .git/HEAD, not two", and it still is a valid
>    argument from Porcelain writers' point of view.  To be
>    honest, since I do not do Porcelain, I am neutral about it.

Yes, I'd still be pleased to see this. Cogito should be ready for this
for long enough, as far as I'm concerned.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
