From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Renaming environment variables.
Date: Tue, 10 May 2005 02:13:51 +0200
Message-ID: <20050510001351.GH15712@pasky.ji.cz>
References: <Pine.LNX.4.21.0505091847050.30848-100000@iabervon.org> <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Sean <seanlkml@sympatico.ca>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:06:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIGi-0001c2-AP
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVEJANy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVEJANy
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:13:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8078 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261449AbVEJANw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:13:52 -0400
Received: (qmail 3188 invoked by uid 2001); 10 May 2005 00:13:51 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7ji8vt5c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 10, 2005 at 02:09:19AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> If you mean the parent directory of ${SHA1_FILE_DIRECTORY}, and
> your only gripe is about git-init-db creating ".git" in the
> current working directory regardless of SHA1_FILE_DIRECTORY, I
> would agree that what git-init-db does is broken.  Not that I
> have a suggested "right behaviour" for it, though.
> 
> However if you also mean by ".git" the directory refs/heads and
> friends hang underneath, then I have to disagree.  That does not
> belong to core GIT, which always expects to run from the top
> level directory that has such directory directly under it, and
> at the same time corresponds to the tree structure the dircache
> describes.  There is no need for the environment variable you
> suggest, since it always is the ".git" subdirectory of such a
> directory.

I think it would be nice to have something like GIT_BASEDIR, which would
default to .git, and the objects directory would then default to
$GIT_BASEDIR/objects and the index file would default to
$GIT_BASEDIR/index.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
