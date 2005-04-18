From: Petr Baudis <pasky@ucw.cz>
Subject: Re: SCSI trees, merges and git status
Date: Tue, 19 Apr 2005 01:28:03 +0200
Message-ID: <20050418232803.GP5554@pasky.ji.cz>
References: <1113856118.4998.70.camel@mulgrave> <Pine.LNX.4.58.0504181429570.15725@ppc970.osdl.org> <7vmzrvsm8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 01:24:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNfb9-0006wQ-OU
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 01:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVDRX2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 19:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVDRX2J
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 19:28:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5297 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261193AbVDRX2F (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 19:28:05 -0400
Received: (qmail 20419 invoked by uid 2001); 18 Apr 2005 23:28:04 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzrvsm8j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 01:23:24AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> However the "Getting object database" part trashed this symlink
> when I tried to pull from my other repo locally.  I am wondering
> it the following might be a better alternative.  A possible
> downside in this approach is that you would not pull .git/heads
> and .git/tags (i.e. Pesky stuff) from the remote anymore.  Is it
> a problem (I am also CC'ing Petr to hear his opinion on this).

Getting tags is probably nice. You should definitively not get
.git/heads, though. Those are your private stuff mostly, and the HEAD
you "export" is .git/HEAD.

I'm thinking about this yet, since it might be useful to be able to
export multiple branches without needing to set up multiple rsync
URLs... you still don't want the heads/ directory en block, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
