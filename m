From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-init bug -- identified
Date: Sun, 5 Jun 2005 22:19:04 +0200
Message-ID: <20050605201904.GL17462@pasky.ji.cz>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz> <20050605182912.GC6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 22:18:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df1XP-0004ZY-O4
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 22:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFEUTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 16:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVFEUTS
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 16:19:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11425 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261606AbVFEUTO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 16:19:14 -0400
Received: (qmail 23370 invoked by uid 2001); 5 Jun 2005 20:19:04 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050605182912.GC6890@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jun 05, 2005 at 08:29:12PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> I figured it out.
> 
> I made a temporary copy of the directory, and kept doing
> 
> $ rm -rf .git
> $ rm somerandomfileordir
> $ cg-init
> $ cg-status
> 
> It turned out one of my files had a "'" in the name, i.e.:
> 
> $ ls
> Zack's_file
> $
> 
> I removed it, and all of a sudden cg-init worked perfectly.
> 
> Is that a Cogito bug? I would expect git to handle any filename the filesystem
> itself can handle.

Could you check with the latest Cogito, please?
(88467971134efddf66793ba44c4ee1ffc7573a0a)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
