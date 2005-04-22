From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [git pasky] tarball question
Date: Sat, 23 Apr 2005 00:42:51 +0200
Message-ID: <20050422224251.GE21204@pasky.ji.cz>
References: <1114180303.29271.25.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:38:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6mu-0001ru-BX
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDVWmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVDVWmy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:42:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57761 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261257AbVDVWmw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:42:52 -0400
Received: (qmail 24812 invoked by uid 2001); 22 Apr 2005 22:42:51 -0000
To: Martin Schlemmer <azarah@nosferatu.za.org>
Content-Disposition: inline
In-Reply-To: <1114180303.29271.25.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 04:31:43PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> Hi,

Hi,

> I understand why you have the git-pasky-0.6.x.tar.bz2 tarballs with
> the .git database included as well (btw, great stuff renaming it to
> something more distributable), but its going to be a pita for users of
> source based distro's like us (Gentoo), as well as our mirrors if it
> gets much bigger. (Already asked r3pek to add it to portage).

yes; that was actually the plan, it's just that my memory is so
volatile...

> How about ripping the .git directory from the next release, and just
> have a un-numbered tarball (like you used to) that have the latest
> snapshot of the .git directory for those that want to do git-pasky
> development?  Should even make things easier your side, as you could
> just do a cron to update it one a day/whatever.

Does it actually make sense to keep a tarball with history? Just build
git-pasky and do git init. (Or rsync it manually.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
