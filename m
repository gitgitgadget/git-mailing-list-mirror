From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito: cannot add dangling symlinks whereas git can
Date: Tue, 7 Feb 2006 01:58:17 +0100
Message-ID: <20060207005817.GL31278@pasky.or.cz>
References: <20060102120912.13409.qmail@c3aed7b85ae352.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 07 01:58:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6HBZ-0004Qq-JM
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 01:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWBGA6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWBGA6J
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 19:58:09 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37096 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964913AbWBGA6I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 19:58:08 -0500
Received: (qmail 1953 invoked by uid 2001); 7 Feb 2006 01:58:17 +0100
To: git@vger.kernel.org, 313596@bugs.debian.org,
	313596-submitter@bugs.debian.org
Content-Disposition: inline
In-Reply-To: <20060102120912.13409.qmail@c3aed7b85ae352.315fe32.mid.smarden.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15674>

Dear diary, on Mon, Jan 02, 2006 at 01:15:17PM CET, I got a letter
where Gerrit Pape <pape@smarden.org> said that...
> forwarded 313596 upstream
> quit
> 
> Hi, cg-add refuses to add special files such as dangling symlinks while
> git can handle them just fine.  Please see http://bugs.debian.org/313596
> 
> I'm not sure why cg-add checks files to commit with test -f.

Because you really do not want to add character specials or named pipes.
;-) I have changed the test to also check for symlinks.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
